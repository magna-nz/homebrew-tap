class RedisLens < Formula
  desc "A terminal UI for Redis and Valkey: browse keys and values, find what uses the memory, watch the server and run commands."
  homepage "https://magna-nz.github.io/redis-lens/"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/redis-lens/releases/download/v1.0.0/redis-lens-aarch64-apple-darwin.tar.xz"
      sha256 "c21d952cdfbffa698d5a7896b11889593cf5702056775b1221ce239541cf7b30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/redis-lens/releases/download/v1.0.0/redis-lens-x86_64-apple-darwin.tar.xz"
      sha256 "ba089800f227c76ea4f549293adc73e893a8df3c813eca514039620dec9d8f98"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/redis-lens/releases/download/v1.0.0/redis-lens-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78ee66519856d0048a1d585626ab2368e0861aa6a49a4077beecc01174d726e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/redis-lens/releases/download/v1.0.0/redis-lens-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25dbd833a89c7b66865b481367c01c4a4cdea61c92ad1867794fca71855da874"
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
