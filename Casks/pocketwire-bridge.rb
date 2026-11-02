# Homebrew cask for the Pocketwire Bridge menu bar app, rendered by render.sh into the tap
# (Hubert-Rybak/homebrew-pocketwire, Casks/pocketwire-bridge.rb) for every release:
#   brew install --cask hubert-rybak/pocketwire/pocketwire-bridge
cask "pocketwire-bridge" do
  version "0.4.1"
  sha256 "3dae39f8d92ff2f8826b83e0618f4fccb1843a270b8268ddca9c9d4ed8cb27f7"

  url "https://github.com/Hubert-Rybak/pocketwire-bridge/releases/download/v#{version}/Pocketwire-Bridge-macos.zip"
  name "Pocketwire Bridge"
  desc "Lets your AI agents send texts from your phone, with your approval"
  homepage "https://pocketwire.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Pocketwire Bridge.app"
  # The same program works as the command line tool (pocketwire pair, doctor, connect, ...).
  binary "#{appdir}/Pocketwire Bridge.app/Contents/MacOS/pocketwire"

  uninstall quit:      "app.pocketwire.bridge",
            launchctl: ["app.pocketwire.bridge.app", "app.pocketwire.bridge"],
            delete:    [
              "~/Library/LaunchAgents/app.pocketwire.bridge.app.plist",
              "~/Library/LaunchAgents/app.pocketwire.bridge.plist",
            ]

  # Pairing, the control page's key and the log; removed only with `brew uninstall --zap`.
  zap trash: "~/Library/Application Support/pocketwire"

  caveats <<~EOS
    Pocketwire Bridge is not notarized by Apple yet. The first time you open it, macOS
    blocks it: open System Settings > Privacy & Security and click "Open Anyway".
    Source code and build provenance: https://github.com/Hubert-Rybak/pocketwire-bridge
  EOS
end
