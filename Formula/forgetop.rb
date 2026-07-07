class Forgetop < Formula
  desc "htop for your software forges — a keyboard-driven terminal UI for pull requests, work items, and CI pipelines across GitHub, Azure DevOps, and Linear"
  homepage "https://github.com/magna-nz/forgetop"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.4.0/forgetop-aarch64-apple-darwin.tar.xz"
      sha256 "8d712cc587e10bdc55cfdbc03b23d484330fa2d53bde09e15bd5289e48deb236"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.4.0/forgetop-x86_64-apple-darwin.tar.xz"
      sha256 "9a5a973c08b06583f2610802cae9b9a7472d61dbf1c0668c45e73172d26fe610"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.4.0/forgetop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3fed6e245b253ce78abfb69107ddb618e1b47d0e9598c3ed195204fc240c179e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magna-nz/forgetop/releases/download/v0.4.0/forgetop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "228edeff4e4da14d70906a9d6ebc3f507a28faccbba747ff6b72b3b59f7b5939"
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
