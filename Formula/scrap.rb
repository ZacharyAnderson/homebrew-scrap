class Scrap < Formula
  desc "Fast, interactive note-taking CLI tool with integrated explorer interface"
  homepage "https://github.com/ZacharyAnderson/Scrap"
  version "0.0.5"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.5/scrap-macos-arm64.tar.gz"
      sha256 "1f1d2cf6a919813404db004acd5bcffbf3422b4f570f0ef9a71cea4ced368bd5"
    else
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.5/scrap-macos-x86_64.tar.gz"
      sha256 "f25c13d2128361123e999a1bc52444ce47871b22131de55e4c2dc62f7301ffd0"
    end
  else
    url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.5/scrap-linux-x86_64.tar.gz"
    sha256 "22eeea7124ee7822c7a31f303822e82a5fc3aba0912c2576c6a4ec3e20bc3a0f"
  end

  depends_on "bat"
  depends_on "fzf"

  def install
    # Install the binary
    bin.install "scrap"
    
    # Install scripts to libexec/scripts
    libexec.install "scripts"
  end

  def post_install
    # Create the scrap data directory in user's home
    scrap_dir = "#{Dir.home}/.scrap"
    mkdir_p scrap_dir

    # Initialize SQLite database and notes table if it doesn't exist
    db_path = "#{scrap_dir}/scrap.db"
    unless File.exist?(db_path)
      system "sqlite3", db_path, <<~SQL
        CREATE TABLE notes(
          id integer primary key autoincrement,
          title text not null,
          note text not null,
          tags json,
          created_at text NOT NULL DEFAULT CURRENT_TIMESTAMP,
          updated_at text NOT NULL DEFAULT CURRENT_TIMESTAMP
        );

        CREATE TRIGGER update_notes_updated_at
        AFTER UPDATE ON notes
        WHEN old.updated_at <> current_timestamp
        BEGIN
            UPDATE notes
            SET updated_at = CURRENT_TIMESTAMP
            WHERE id = OLD.id;
        END;
      SQL
    end
  end

  test do
    system bin/"scrap", "help"
  end
end
