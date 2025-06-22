// Copyright 2023 The Gitea Authors. All rights reserved.
// SPDX-License-Identifier: MIT

package cmd

import (
	"context"
	"fmt"
	"os"
	"os/signal"

	"gitea.com/gitea/act_runner/internal/pkg/config"

	"github.com/nektos/act/pkg/artifactcache"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type cacheServerArgs struct {
	Dir    string
	Host   string
	Port   uint16
	Secret string
}

func runCacheServer(ctx context.Context, configFile *string, cacheArgs *cacheServerArgs) func(cmd *cobra.Command, args []string) error {
	return func(cmd *cobra.Command, args []string) error {
		cfg, err := config.LoadDefault(*configFile)
		if err != nil {
			return fmt.Errorf("invalid configuration: %w", err)
		}

		initLogging(cfg)

		var (
			dir    = cfg.Cache.Dir
			host   = cfg.Cache.Host
			port   = cfg.Cache.Port
			secret = cfg.Cache.Secret
		)

		// cacheArgs has higher priority
		if cacheArgs.Dir != "" {
			dir = cacheArgs.Dir
		}
		if cacheArgs.Host != "" {
			host = cacheArgs.Host
		}
		if cacheArgs.Port != 0 {
			port = cacheArgs.Port
		}
		if cacheArgs.Secret != "" {
			secret = cacheArgs.Secret
		}

		if secret == "" {
			// no cache secret was specified, panic
			log.Error("no cache secret was specified, exiting.")
			return nil
		}

		cacheHandler, err := artifactcache.StartHandler(
			dir,
			host,
			port,
			secret,
			log.StandardLogger().WithField("module", "cache_request"),
		)
		if err != nil {
			return err
		}

		log.Infof("cache server is listening on %v", cacheHandler.ExternalURL())

		c := make(chan os.Signal, 1)
		signal.Notify(c, os.Interrupt)
		<-c

		return nil
	}
}
