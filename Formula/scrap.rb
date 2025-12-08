class Scrap < Formula
  desc "Fast, interactive note-taking CLI tool with integrated explorer interface"
  homepage "https://github.com/ZacharyAnderson/Scrap"
  version "0.0.4"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.4/scrap-macos-arm64.tar.gz"
      sha256 "5efea2cb937b47fe1f046974e706225fd5125a9f4a06a228acf2b2c0b3ef8afb"
    else
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.4/scrap-macos-x86_64.tar.gz"
      sha256 "2fa404dd963e4216967c24b76414800bd1b9cbdf423692b0254e359da7f9d730"
    end
  end

  on_linux do
    url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.4/scrap-linux-x86_64.tar.gz"
    sha256 "da05dd29ab7f3df2517d118a797118a0dfc58d4eeef3ead545ecd439dd52bc0a"
  end

  license "MIT"

  depends_on "fzf"
  depends_on "bat"

  def install
    bin.install "scrap"
    
    # Install the explorer script
    (libexec/"scripts").install "scripts/explorer.sh"
    
    # Create a wrapper script that sets the environment variable
    (bin/"scrap").write <<~EOS
      #!/bin/bash
      export SCRAP_SCRIPTS_PATH="#{libexec}/scripts"
      exec "#{libexec}/scrap" "$@"
    EOS
    
    # Install the actual binary
    libexec.install "scrap"
  end

  test do
    system "#{bin}/scrap", "help"
  end
end
