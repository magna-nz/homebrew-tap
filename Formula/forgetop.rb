class Forgetop < Formula
  desc "Keyboard-driven terminal UI for PRs, work items, and CI across six forges"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.9.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "22ed596b6393f9d5414ebeee26f76ecf8c9421663368dfca884bcf5c84cc6927"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.9.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "16c7102cd1679d7b14457a38e705e24e59d68aaae3445ad58e41a44515e56bca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.9.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "746e17e5e362be5baf7c36884a8ecb7b46b7e820fe841b900f2038862027645a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.9.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "021b72d3572807973a66ac70c7a8cdc1bf55f53da5411fdd68e468bf2c112090"
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
