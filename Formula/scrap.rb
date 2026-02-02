class Scrap < Formula
  desc "CLI note-taking app with TUI, tag-based organization, and LLM-powered summaries"
  homepage "https://github.com/ZacharyAnderson/scrap-rs"
  url "https://github.com/ZacharyAnderson/scrap-rs.git", tag: "v0.1.0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "A CLI note-taking app", shell_output("#{bin}/scrap --help")
  end
end
