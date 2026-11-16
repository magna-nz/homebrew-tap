class RedisLens < Formula
  desc "A terminal UI for Redis and Valkey: browse keys and values, find what uses the memory, watch the server and run commands."
  homepage "https://magna-nz.github.io/redis-lens/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/redis-lens/releases/download/v0.1.0/redis-lens-aarch64-apple-darwin.tar.xz"
      sha256 "70e7d215534107cde746b052b59b90c81f0aa946ecf3bc04c264bdb36e804e5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/redis-lens/releases/download/v0.1.0/redis-lens-x86_64-apple-darwin.tar.xz"
      sha256 "d48fa2e19cd8a82360f262053c7eac4ccdbc6044213478b0d8d2377f7c55e967"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/redis-lens/releases/download/v0.1.0/redis-lens-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "55cc7f7ad1a50ec15fdef158ec00c311fd1fa6c0d5002391354384759a8666ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/redis-lens/releases/download/v0.1.0/redis-lens-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "de505d9c53999ac43975cef8646187e5d31042c9d6d07f06f2f82d1eb29ba094"
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
      bin.install "redis-lens"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "redis-lens"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "redis-lens"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "redis-lens"
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
