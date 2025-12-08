class Scrap < Formula
  desc "Fast, interactive note-taking CLI tool with integrated explorer interface"
  homepage "https://github.com/ZacharyAnderson/Scrap"
  version "0.0.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.4/scrap-macos-arm64.tar.gz"
      sha256 "5efea2cb937b47fe1f046974e706225fd5125a9f4a06a228acf2b2c0b3ef8afb"
    else
      url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.4/scrap-macos-x86_64.tar.gz"
      sha256 "2fa404dd963e4216967c24b76414800bd1b9cbdf423692b0254e359da7f9d730"
    end
  else
    url "https://github.com/ZacharyAnderson/Scrap/releases/download/v0.0.2/scrap-linux-x86_64.tar.gz"
    sha256 "9cc274cb7ff6b9088843cc64765f14166fec305aeca318cae78f1f1829d4878f"
  end

  depends_on "bat"
  depends_on "fzf"

  def install
    # Install the binary
    bin.install "scrap"
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
