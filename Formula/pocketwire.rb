# Homebrew formula that builds the Pocketwire Bridge from source on macOS and Linux, rendered
# by render.sh into the tap (Hubert-Rybak/homebrew-pocketwire, Formula/pocketwire.rb):
#   brew install hubert-rybak/pocketwire/pocketwire
# On a Mac the cask (the menu bar app) is the easier choice; install one or the other.
class Pocketwire < Formula
  desc "Lets your AI agents send texts from your phone, with your approval"
  homepage "https://pocketwire.app/"
  url "https://github.com/Hubert-Rybak/pocketwire-bridge/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "fe7a79ec060c44b6b992ffa65450b952e9862b1f66ba80eebb0a9b1d90af3f3e"
  license "Apache-2.0"
  head "https://github.com/Hubert-Rybak/pocketwire-bridge.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pocketwire version")
    assert_match "not paired", shell_output("POCKETWIRE_CONFIG=#{testpath}/c.json #{bin}/pocketwire doctor")
  end
end
