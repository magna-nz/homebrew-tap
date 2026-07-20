class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.10.1/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "fdb93141cfdd471fe136c1de7e21495a872cae0816d37d430b9118b693479ab1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.10.1/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "4861d264b2b2176c9c049a399974b9c9484b7b0f988ea4d90dcb0e880195e000"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.10.1/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ad6331d7bac50dbe77ef21af823d8267af7d2fd761b43fbf7d90bce14f9da86c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.10.1/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "49b9fade33ee659d851e470c6668eadd63c7d6808c75d09908f4527173bf3239"
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
