class Scrap < Formula
  desc "CLI note-taking app with TUI, tag-based organization, and LLM-powered summaries"
  homepage "https://github.com/ZacharyAnderson/scrap-rs"
  url "https://github.com/ZacharyAnderson/scrap-rs.git", tag: "v0.2.0"
  head "https://github.com/ZacharyAnderson/scrap-rs.git", branch: "master"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "A CLI note-taking app", shell_output("#{bin}/scrap --help")
  end
end
