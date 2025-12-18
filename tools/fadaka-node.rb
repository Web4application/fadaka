# typed: false
# frozen_string_literal: true

class FadakaNode < Formula
  desc "Fadaka blockchain full node + CLI"
  homepage "https://github.com/Web4application/fadaka-blockchain"
  url "https://github.com/Web4application/fadaka-blockchain/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "REPLACE_ME_SHA256_OF_TARBALL"
  license "MIT"
  head "https://github.com/Web4application/fadaka-blockchain.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    # Add bottle hashes after build
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.Version=\#{version}
      -X main.Commit=\#{Utils.git_short_head}
      -X main.BuildDate=\#{Time.now.utc.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/fadaka"

    generate_completions_from_executable(bin/"fadaka", "completion")
  end

  service do
    run [opt_bin/"fadaka", "node", "--config", "~/.fadaka/config.toml"]
    keep_alive true
    log_path var/"log/fadaka-node.log"
    error_log_path var/"log/fadaka-node.err.log"
  end

  test do
    assert_match "Fadaka", shell_output("\#{bin}/fadaka --help")
  end
end