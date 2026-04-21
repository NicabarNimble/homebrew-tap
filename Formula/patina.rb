class Patina < Formula
  desc "Patina AI + Mother CLI"
  homepage "https://github.com/NicabarNimble/patina"
  version "0.64.0"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    url "https://github.com/NicabarNimble/patina/releases/download/v#{version}/patina-aarch64-apple-darwin.tar.gz"
    sha256 "8a5b1babc9d9defdd281a6b4d00a9bf162c6897309e1d3ed95f84d4ab177a5ce"
  end

  on_linux do
    url "https://github.com/NicabarNimble/patina/releases/download/v#{version}/patina-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9c1770fb292c1e1b3c4edd196f410b018561ee04b949615137ec0f21938e5c0c"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      odie "Patina requires macOS 14+ on Apple Silicon"
    end

    bin.install "patina"
  end

  service do
    run [opt_bin/"patina", "mother", "start"]
    keep_alive true
    log_path var/"log/patina-mother.log"
    error_log_path var/"log/patina-mother.error.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/patina --version")
    assert_match "mother", shell_output("#{bin}/patina mother --help")
  end
end
