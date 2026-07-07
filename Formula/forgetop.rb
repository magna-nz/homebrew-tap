class Forgetop < Formula
  desc "htop for your software forges — a keyboard-driven terminal UI for pull requests, work items, and CI pipelines across GitHub, Azure DevOps, and Linear"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.3.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "9153bf517fcb4fb5a34b10bc4d95c98c6fcffd1b072eeda00696e7c051457b67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.3.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "a8aa5753a743ec4a941579deb9b86d961dceffda34f4dbf946598ae62e298b88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.3.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8c015173c716a06e678d089be02036455ebec630ab451798268623114ca68cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.3.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "111c2901790de96e840e7ecba7710a92d4d7453c82e32aa6cfe9c166db3aad33"
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
