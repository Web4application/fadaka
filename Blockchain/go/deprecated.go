// Copyright 2023 The Gitea Authors. All rights reserved.
// SPDX-License-Identifier: MIT

package config

import (
	"os"
	"strconv"
	"strings"

	log "github.com/sirupsen/logrus"
)

// Deprecated: could be removed in the future. TODO: remove it when Gitea 1.20.0 is released.
// Be compatible with old envs.
func compatibleWithOldEnvs(fileUsed bool, cfg *Config) {
	handleEnv := func(key string) (string, bool) {
		if v, ok := os.LookupEnv(key); ok {
			if fileUsed {
				log.Warnf("env %s has been ignored because config file is used", key)
				return "", false
			}
			log.Warnf("env %s will be deprecated, please use config file instead", key)
			return v, true
		}
		return "", false
	}

	if v, ok := handleEnv("GITEA_DEBUG"); ok {
		if b, _ := strconv.ParseBool(v); b {
			cfg.Log.Level = "debug"
		}
	}
	if v, ok := handleEnv("GITEA_TRACE"); ok {
		if b, _ := strconv.ParseBool(v); b {
			cfg.Log.Level = "trace"
		}
	}
	if v, ok := handleEnv("GITEA_RUNNER_CAPACITY"); ok {
		if i, _ := strconv.Atoi(v); i > 0 {
			cfg.Runner.Capacity = i
		}
	}
	if v, ok := handleEnv("GITEA_RUNNER_FILE"); ok {
		cfg.Runner.File = v
	}
	if v, ok := handleEnv("GITEA_RUNNER_ENVIRON"); ok {
		splits := strings.Split(v, ",")
		if cfg.Runner.Envs == nil {
			cfg.Runner.Envs = map[string]string{}
		}
		for _, split := range splits {
			kv := strings.SplitN(split, ":", 2)
			if len(kv) == 2 && kv[0] != "" {
				cfg.Runner.Envs[kv[0]] = kv[1]
			}
		}
	}
	if v, ok := handleEnv("GITEA_RUNNER_ENV_FILE"); ok {
		cfg.Runner.EnvFile = v
	}
}
