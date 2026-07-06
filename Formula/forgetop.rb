class Forgetop < Formula
  desc "htop for your software forges — a keyboard-driven terminal UI for pull requests, work items, and CI pipelines across GitHub, Azure DevOps, and Linear"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.1.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "697efe410458af5ec6993b85e2800d12e0d969f3ca9f5b42a282e0448308eb53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.1.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "f7e6da5b605aa851637ba20a720da8f9b9d56b6a01e34da8b86b1efbe9509233"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.1.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a77bcab4cc8e007b94794e360207f3794fb29532ec5fb92db6494f6cbefed7a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.1.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0a370d1efbf2b13d27a569f2acb48059c6b908a2f91d3c85f2cc38b84e7bbffd"
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
