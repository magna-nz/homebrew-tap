class Forgetop < Formula
  desc "htop for your software forges — a keyboard-driven terminal UI for pull requests, work items, and CI pipelines across GitHub, Azure DevOps, and Linear"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.5.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "b8b2878fe3d3a9a1623256286ed3984ebee773cbb4c7840a59d6b04a015bc8b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.5.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "b2a22c9f24cb1ceab623efd2b810376e0936b2afb84a957e7fe31305a9617ca0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.5.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a73aa90517aca5cd94641e5f6b255b3006376fdbc86549e40ca3d3db5f839c39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.5.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "35a087e991f621469d7ad81bf2ce677b7b9dc4055958df23802b5c08988c3a5e"
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
