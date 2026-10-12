class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "1.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.10.1/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "058e82682ce9478f672a736ab13450ab2c1897f88d66010bc7aa620829a30dc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.10.1/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "b60333c2dc67c1af770b1cdb3e5200a81d5ecd8632d37d3b272cc9b3998634d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.10.1/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "71fe71471736532c3df3bf1ef64e3aad2cae0092edd05ecabe0bd3807495c8c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.10.1/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd8ee7251d2820dcebda998b93515cd36df96767c80689456648cff56d12ab2f"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "forgetop"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "forgetop"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "forgetop"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "forgetop"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
