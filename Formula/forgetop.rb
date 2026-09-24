class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "1.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.2.1/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "853800bb420b734e5ec49ee48739d54f9a0b464139599c17d55812c33ae49170"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.2.1/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "c6b7fef568677b14f6ab18b85cd7d46ca00cae15c74a51a9cfe2404e37be162d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.2.1/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5c2771c71c3d69f1d3a13d62109aa8a8d6928ea8cab497b0896f0d72b744d433"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.2.1/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d614b3f546588318fbb51947a60a54efea211d4d549838136a3060cade1a2392"
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
