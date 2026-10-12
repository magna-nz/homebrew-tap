class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "1.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.9.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "da55dbd3dfeb824d181e9ea61f64235f9fe8db323bd4eca4fc5d8becd200caeb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.9.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "941f4bcfcae3000f15be5a6757b33f996cb849c03c45b8bfae96b847877395cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.9.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "093f37b50cd4a6f6062d10c26b61e561fae98c4c0ff512a72fffec925e99ca6d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.9.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2abea3a39bd57de14db1926d432f31c264f8a1d93e7418e4ba1867b08e7402f1"
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
