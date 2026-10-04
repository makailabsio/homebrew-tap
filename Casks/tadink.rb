cask "tadink" do
  version "0.6.0"
  sha256 "f1b2dfc733268951335637ed5433474e3c28e3aba05fee78d851764712ae84b2"

  url "https://download.makailabs.io/tadink/Tadink-#{version}.dmg"
  name "Tadink"
  desc "Local-first voice dictation and meeting recorder"
  homepage "https://github.com/makailabsio/tadink"

  # Installed copies update themselves through Sparkle, so the cask never has
  # to be the thing that delivers a new version — it only has to be right.
  auto_updates true

  # arm64 only: Tadink needs Foundation Models and the ANE. An Intel Mac gets a
  # clean refusal here rather than an app that installs and cannot launch.
  depends_on arch: :arm64

  # :tahoe means "26.0 or newer". Homebrew has no comparator for a minor
  # version, so the app's own floor is what tells a Mac on 26.0 or 26.1 that
  # it cannot run Tadink — the OS says so before the app ever launches.
  depends_on macos: :tahoe

  app "Tadink.app"

  zap trash: [
    "~/Library/Caches/io.makailabs.tadink",
    "~/Library/HTTPStorages/io.makailabs.tadink",
    "~/Library/Preferences/io.makailabs.tadink.plist",
    "~/Library/Saved Application State/io.makailabs.tadink.savedState",
  ]

  # DELIBERATELY ABSENT from every path above:
  #   ~/Library/Application Support/Tadink/
  # That folder holds the user's meeting audio and their database. `brew
  # uninstall --zap` must never be the thing that destroys someone's
  # recordings, so it is not listed here and must not be added.
end
