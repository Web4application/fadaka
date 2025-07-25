package crypto_test

import (
	"go/build"
	"internal/testenv"
	"os"
	"os/exec"
	"strings"
	"testing"
)

func TestPureGoAssembly(t *testing.T) {
	// List your Fadaka crypto packages here
	packages := []string{
		"fadaka/crypto/secp256k1",
		"fadaka/crypto/bls12_381",
		// add other crypto packages as needed
	}

	goos := "linux"

	cmd := exec.Command(testenv.GoToolPath(t), "tool", "dist", "list")
	cmd.Stderr = os.Stderr
	out, err := cmd.Output()
	if err != nil {
		t.Fatalf("failed to get architecture list: %v\n%s", err, out)
	}
	allGoArch := make(map[string]bool)
	for _, line := range strings.Split(strings.TrimSpace(string(out)), "\n") {
		goarch := strings.Split(line, "/")[1]
		allGoArch[goarch] = true
	}

	for _, pkg := range packages {
		for goarch := range allGoArch {
			ctx := build.Context{
				GOOS:      goos,
				GOARCH:    goarch,
				GOROOT:    testenv.GOROOT(t),
				Compiler:  build.Default.Compiler,
				BuildTags: []string{"purego"},
			}

			pkgInfo, err := ctx.Import(pkg, "", 0)
			if err != nil {
				t.Fatalf("failed to import package %s for arch %s: %v", pkg, goarch, err)
			}

			if len(pkgInfo.SFiles) > 0 {
				t.Errorf("package %s contains assembly files on %s: %v", pkg, goarch, pkgInfo.SFiles)
			}
		}
	}
}
