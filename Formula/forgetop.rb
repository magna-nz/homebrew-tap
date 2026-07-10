class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.7.1/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "472f0f33826215aa54af47f091d168c8b6457de6a6d0033a89f0150dd2a73ea0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.7.1/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "619d8693960b38bf7be802c52b68c4c405b3b95e127cf49be81c994c269ac198"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.7.1/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d4a3628f16afb998a3ad1d5ffbf0b5ef9f1f996c91490fddb8a63e4b7674cf4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.7.1/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "754be48bffd7e7ce6e773c1f67405b33f2bf93a37245c651f12fe4104d3ba117"
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
