class Scrap < Formula
  desc "Fast, interactive note-taking CLI tool with integrated explorer interface"
  homepage "https://github.com/ZacharyAnderson/Scrap"
  version "0.0.6"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.6/scrap-macos-arm64.tar.gz"
      sha256 "ae0739fb67e4fee8cb4bdcb7c53a0783af7ff7b5be8b9b3a001b8c90e81bbab5"
    else
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.6/scrap-macos-x86_64.tar.gz"
      sha256 "ac3ad0c6f4caafe3b350ce87fc8b7e7d71b21b0b2d95a177fd9273e7fc87788e"
    end
  else
    url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.6/scrap-linux-x86_64.tar.gz"
    sha256 "00442b4cc406c7b1a4cbcd2c1d6c6b08498a77cd12a3c610ea6df658f0f62cc5"
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
