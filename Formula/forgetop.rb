class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "1.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.7.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "dd5ec7c4449995e5996af2c03f03b45e0d187323d8a962fb341ad4215fb27ce8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.7.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "6164f38bd104537d16e3bc463f3f248b84e202b0e6870c91b1872aa834c77b5c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.7.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "20447fb6fab20a0af8497b38a202c9727dc5103a8742d7db3e7ab6d32237ca09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v1.7.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2847d8e9ed7a543aa268519458ede93259a1359d63ec72b3938e4ec31a8d30c2"
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
