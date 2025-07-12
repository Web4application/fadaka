/*
Package dnslink implements a dns link resolver. dnslink is a basic
standard for placing traversable links in dns itself. See dnslink.info

A dnslink is a path link in a dns TXT record, like this:

  dnslink=/ipfs/QmR7tiySn6vFHcEjBeZNtYGAFh735PJHfEMdVEycj9jAPy

For example:

  > dig TXT ipfs.io
  ipfs.io.  120   IN  TXT  dnslink=/ipfs/QmR7tiySn6vFHcEjBeZNtYGAFh735PJHfEMdVEycj9jAPy

This package eases resolving and working with thse dns links. For example:

  import (
    dnslink "github.com/jbenet/go-dnslink"
  )

  link, err := dnslink.Resolve("ipfs.io")
  // link = "/ipfs/QmR7tiySn6vFHcEjBeZNtYGAFh735PJHfEMdVEycj9jAPy"

It even supports recursive resolution. Suppose you have three domains with
dnslink records like these:

  > dig TXT foo.com
  foo.com.  120   IN  TXT  dnslink=/dns/bar.com/f/o/o
  > dig TXT bar.com
  bar.com.  120   IN  TXT  dnslink=/dns/long.test.baz.it/b/a/r
  > dig TXT long.test.baz.it
  long.test.baz.it.  120   IN  TXT  dnslink=/b/a/z

Expect these resolutions:

  dnslink.ResolveN("long.test.baz.it", 0) // "/dns/long.test.baz.it"
  dnslink.Resolve("long.test.baz.it")     // "/b/a/z"

  dnslink.ResolveN("bar.com", 1)          // "/dns/long.test.baz.it/b/a/r"
  dnslink.Resolve("bar.com")              // "/b/a/z/b/a/r"

  dnslink.ResolveN("foo.com", 1)          // "/dns/bar.com/f/o/o/"
  dnslink.ResolveN("foo.com", 2)          // "/dns/long.test.baz.it/b/a/r/f/o/o/"
  dnslink.Resolve("foo.com")              // "/b/a/z/b/a/r/f/o/o"

*/

#include <stdlib.h>
#include <string.h>
#ifdef __MINGW32__
    #include <stdint.h>

    #define u_char unsigned char
    #define u_int16_t uint16_t
    #define u_int32_t uint32_t
    #define NS_MAXDNAME     1025    /*%< maximum domain name */
    #define ns_c_in 1
    #define ns_t_txt 16

    typedef enum __ns_sect {
            ns_s_qd = 0,            /*%< Query: Question. */
            ns_s_zn = 0,            /*%< Update: Zone. */
            ns_s_an = 1,            /*%< Query: Answer. */
            ns_s_pr = 1,            /*%< Update: Prerequisites. */
            ns_s_ns = 2,            /*%< Query: Name servers. */
            ns_s_ud = 2,            /*%< Update: Update. */
            ns_s_ar = 3,            /*%< Query|Update: Additional records. */
            ns_s_max = 4
    } ns_sect;

    typedef struct __ns_msg {
            const unsigned char    *_msg, *_eom;
            u_int16_t       _id, _flags, _counts[ns_s_max];
            const unsigned char    *_sections[ns_s_max];
            ns_sect         _sect;
            int             _rrnum;
            const unsigned char    *_msg_ptr;
    } ns_msg;

    typedef struct __ns_rr {
            char            name[NS_MAXDNAME];
            u_int16_t       type;
            u_int16_t       rr_class;
            u_int32_t       ttl;
            u_int16_t       rdlength;
            const u_char *  rdata;
    } ns_rr;
#else
    #include <netinet/in.h>
    #include <arpa/nameser.h>
    #include <resolv.h>
#endif
#include "ipfs/namesys/namesys.h"
#define IPFS_DNSLINK_C
#include "ipfs/dnslink/dnslink.h"
#include "ipfs/cid/cid.h"
#include "ipfs/path/path.h"

int ipfs_dns (int argc, char **argv)
{
#ifdef __MINGW32__
        fprintf (stderr, "Sorry, dns has not yet been implemented for the Windows version.\n");
        return -1;
    }
#else
        int err, r=0, i;
        char **txt, *path, *param;

        if (argc == 4 && strcmp ("-r", argv[2])==0) {
            r = 1;
            argc--; argv++;
        }

        if (argc != 3) {
            fprintf (stderr, "usage: ipfs dns [-r] dns.name.com\n");
            return -1;
        }

        param = malloc (strlen (argv[2]) + 1);
        if (!param) {
            fprintf (stderr, "memory allocation failed.\n");
            return 1;
        }
        strcpy (param, argv[2]);

        for (i = 0 ; i < DefaultDepthLimit ; i++) {
            if (memcmp(param, "/ipns/", 6) == 0) {
                err = ipfs_dnslink_resolv_lookupTXT (&txt, param+6);
            } else {
                err = ipfs_dnslink_resolv_lookupTXT (&txt, param);
            }
            free (param);

            if (err) {
                fprintf (stderr, "dns lookupTXT: %s\n", Err[err]);
                return err;
            }

            err = ipfs_dnslink_parse_txt(&path, *txt);
            if (err) {
                free (*txt);
                free (txt);
                fprintf (stderr, "dns parse_txt: %s\n", Err[err]);
                return err;
            }

            free (*txt);
            free (txt);
            param = path;

            if (! r) {
                // not recursive.
                break;
            }

            if (memcmp(path, "/ipfs/", 6) == 0) {
                break;
            }
        } while (--r);
        fprintf (stdout, "%s\n", param);
        free (param);

        return 0;
    }
#endif // MINGW

// ipfs_dnslink_resolve resolves the dnslink at a particular domain. It will
// recursively keep resolving until reaching the defaultDepth of Resolver. If
// the depth is reached, ipfs_dnslink_resolve will return the last value
// retrieved, and ErrResolveLimit. If TXT records are found but are not valid
// dnslink records, ipfs_dnslink_resolve will return ErrInvalidDNSLink.
// ipfs_dnslink_resolve will check every TXT record returned. If resolution
// fails otherwise, ipfs_dnslink_resolve will return ErrResolveFailed
int ipfs_dnslink_resolve (char **p, char *domain)
{
    return ipfs_dnslink_resolve_n (p, domain, DefaultDepthLimit);
}

// ipfs_dnslink_lookup_txt is a function that looks up a TXT record in some dns resolver.
// This is useful for testing or passing your own dns resolution process, which
// could take into account non-standard TLDs like .bit, .onion, .ipfs, etc.
int (*ipfs_dnslink_lookup_txt)(char ***txt, char *name) = NULL;

// ipfs_dnslink_resolve_n is just like Resolve, with the option to specify a
// maximum resolution depth.
int ipfs_dnslink_resolve_n (char **p, char *d, int depth)
{
    int err, i, l;
    char *rest, **link, tail[500], buf[500], domain[500];
    char dns_prefix[] = "/dns/";

    domain[sizeof(domain)-1] = '\0';
    strncpy (domain, d, sizeof(domain) - 1);
    for (i=0 ; i < depth ; i++) {
        err = ipfs_dnslink_resolve_once (&link, domain);
        if (err) {
            return err;
        }

        // if does not have /dns/ as a prefix, done.
        if (memcmp (*link, dns_prefix, sizeof(dns_prefix) - 1)!=0) {
            l = strlen(*link) + strlen(tail);
            *p = malloc(l + 1);
            if (!*p) {
                free(*link);
                free(link);
                return ErrAllocFailed;
            }
            *p[l] = '\0';
            strncpy(*p, *link, l);
            free(*link);
            free(link);
            strncat(*p, tail, l - strlen(*p));
            return 0; // done
        }

        // keep resolving
        err = ipfs_dnslink_parse_link_domain (&d, &rest, *link);
        free (*link);
        free (link);
        if (err) {
            *p = NULL;
            return err;
        }

        strncpy (domain, d, sizeof(domain) - 1);
        free (d);
        strncpy (buf, tail, sizeof(buf) - 1);
        strncpy (tail, rest, sizeof(tail) - 1);
        strncat (tail, buf, sizeof(tail) - 1 - strlen(tail));
    }

    strncpy (buf, tail, sizeof(buf) - 1);
    strncpy (tail, dns_prefix, sizeof(tail) - 1);
    strncat (tail, domain, sizeof(tail) - 1 - strlen(tail));
    strncat (tail, buf, sizeof(tail) - 1 - strlen(tail));
    return ErrResolveLimit;
}

#ifndef __MINGW32__
    // lookup using libresolv -lresolv
    int ipfs_dnslink_resolv_lookupTXT(char ***txt, char *domain)
    {
        char buf[4096], *p;
        int responseLength;
        int i, l, n = 0;
        ns_msg query_parse_msg;
        ns_rr query_parse_rr;
        u_char responseByte[4096];

        // Use res_query from libresolv to retrieve TXT record from DNS server.
        if ((responseLength = res_query(domain,ns_c_in,ns_t_txt,responseByte,sizeof(responseByte))) < 0 ||
            ns_initparse(responseByte,responseLength,&query_parse_msg) < 0) {
            return ErrResolveFailed;
        } else {
            l = sizeof (buf);
            buf[--l] = '\0';
            p = buf;
            // save every TXT record to buffer separating with a \0
            for (i=0 ; i < ns_msg_count(query_parse_msg,ns_s_an) ; i++) {
                if (ns_parserr(&query_parse_msg,ns_s_an,i,&query_parse_rr)) {
                    return ErrResolveFailed;
                } else {
                    const unsigned char *rdata = ns_rr_rdata(query_parse_rr);
                    memcpy(p, rdata+1, *rdata); // first byte is record length
                    p += *rdata; // update pointer
                    *p++ = '\0'; // mark end-of-record and update pointer to next record.
                    n++; // update record count
                }
            }
            // allocate array for all records + NULL pointer terminator.
            *txt = calloc(n+1, sizeof(void*));
            if (!*txt) {
                return ErrAllocFailed;
            }
            l = p - buf; // length of all records in buffer.
            p = malloc(l); // allocate memory that will be used as string data at *txt array.
            if (!p) {
                free(*txt);
                *txt = NULL;
                return ErrAllocFailed;
            }
            memcpy(p, buf, l); // transfer from buffer to allocated memory.
            for (i = 0 ; i < n ; i++) {
                *txt[i] = p; // save position of current record at *txt array.
                p = memchr(p, '\0', l - (p - *txt[0])) + 1; // find next record position after next \0
            }
        }
        return 0;
    }
#endif

// ipfs_dnslink_resolve_once implements resolver.
int ipfs_dnslink_resolve_once (char ***p, char *domain)
{
    int err, i;
    char **txt;

    if (!p || !domain) {
        return ErrInvalidParam;
    }

    *p = NULL;

    if (!ipfs_isdomain_is_domain (domain)) {
        return ErrInvalidDomain;
    }

#ifndef __MINGW32__
    if (!ipfs_dnslink_lookup_txt) { // if not set
        ipfs_dnslink_lookup_txt = ipfs_dnslink_resolv_lookupTXT; // use default libresolv
    }

    err = ipfs_dnslink_lookup_txt (&txt, domain);
#endif
    if (err) {
        return err;
    }

    err = ErrResolveFailed;
    for (i=0 ; txt[i] ; i++) {
        err = ipfs_dnslink_parse_txt(*p, txt[i]);
        if (!err) {
            break;
        }
    }
    free(*txt);
    free(txt);
    return err;
}

// ipfs_dnslink_parse_txt parses a TXT record value for a dnslink value.
// The TXT record must follow the dnslink format:
//   TXT dnslink=<path>
//   TXT dnslink=/foo/bar/baz
// ipfs_dnslink_parse_txt will return ErrInvalidDNSLink if parsing fails.
int ipfs_dnslink_parse_txt (char **path, char *txt)
{
    char **parts;

    if (!path || !txt) {
        return ErrInvalidParam;
    }
    parts = ipfs_path_split_n (txt, "=", 2);
    if (!parts) {
        return ErrAllocFailed;
    }
    if (ipfs_path_segments_length (parts) == 2 && strcmp(parts[0], "dnslink")==0 && memcmp(parts[1], "/", 1)==0) {
        *path = ipfs_path_clean_path(parts[1]);
        if (path) {
            ipfs_path_free_segments (&parts);
            return 0;
        }
    }
    ipfs_path_free_segments (&parts);
    *path = NULL;
    return ErrInvalidDNSLink;
}

// ipfs_dnslink_parse_link_domain parses a domain from a dnslink path.
// The link path must follow the dnslink format:
//   /dns/<domain>/<path>
//   /dns/ipfs.io
//   /dns/ipfs.io/blog/0-hello-worlds
// ipfs_dnslink_parse_link_domain will return ErrInvalidDNSLink if parsing
// fails, and ErrInvalidDomain if the domain is not valid.
int ipfs_dnslink_parse_link_domain (char **domain, char**rest, char *txt)
{
    char **parts;
    int parts_len;

    if (!domain || !rest || !txt) {
        return ErrInvalidParam;
    }

    *domain = *rest = NULL;

    parts = ipfs_path_split_n (txt, "/", 4);
    parts_len = ipfs_path_segments_length(parts);
    if (!parts || parts_len < 3 || parts[0][0]!='\0' || strcmp(parts[1], "dns") != 0) {
        return ErrInvalidDNSLink;
    }

    if (! ipfs_isdomain_is_domain (parts[2])) {
        ipfs_path_free_segments (&parts);
        return ErrInvalidDomain;
    }

    *domain = malloc(strlen (parts[2]) + 1);
    if (!*domain) {
        ipfs_path_free_segments (&parts);
        return ErrAllocFailed;
    }
    strcpy(*domain, parts[2]);

    if (parts_len > 3) {
        *rest = malloc(strlen (parts[3]) + 1);
        if (!*rest) {
            ipfs_path_free_segments (&parts);
            free (*domain);
            *domain = NULL;
            return ErrAllocFailed;
        }
        strcpy(*rest, parts[3]);
    }

    return 0;
}
