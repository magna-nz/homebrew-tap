class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "1.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.1.3/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "0fb0b1644ef395539e020bf35d0c3dcc8774d1771ba4f2ab4cee2fc4471b761d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.1.3/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "b1d34d4a1426bf6245068809ad5160ae588e914ffe0cab23b36242083bc6b3f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.1.3/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "149db620b0771fb8bd11210402801ab9c59b7ba2d7a4c9d016054f931b78e2c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.1.3/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c87f5cb1a0bd30cc38055b2a76351ac02428a92a26db3d1cc874e979899dbb7c"
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
