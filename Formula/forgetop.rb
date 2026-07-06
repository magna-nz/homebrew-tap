class Forgetop < Formula
  desc "htop for your software forges — a keyboard-driven terminal UI for pull requests, work items, and CI pipelines across GitHub, Azure DevOps, and Linear"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.2.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "85b698c341a7394d82516c8fde26c370d512bde7939c89ac619ce9ff685bb45d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.2.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "47e634553435de5205d87473dc3e24364ac73b9c495f5c71bc3b6e13456109ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.2.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a4871704a65b563bd00ce30ca99f37e93babd562754a3ad6b663cd3c1f880cc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.2.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "db20d8b0a7fc683b68b744606398a31666e4de567f4bdf6dc0f0021ef5ab1840"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "forgetop" if OS.mac? && Hardware::CPU.arm?
    bin.install "forgetop" if OS.mac? && Hardware::CPU.intel?
    bin.install "forgetop" if OS.linux? && Hardware::CPU.arm?
    bin.install "forgetop" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
