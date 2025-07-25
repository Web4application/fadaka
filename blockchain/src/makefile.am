AM_CFLAGS = @CFLAGS@

lib_LTLIBRARIES = libfadaka_crypto.la

libfadaka_crypto_la_SOURCES = secp.c

if HAS_X86_64_ASM
libfadaka_crypto_la_SOURCES += secp_x86_64.S
endif

if HAS_ARM32_ASM
libfadaka_crypto_la_SOURCES += secp_arm32.S
endif

libfadaka_crypto_la_LDFLAGS = -version-info 1:0:0
