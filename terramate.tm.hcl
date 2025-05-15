terramate {
  config {
    git {
      # Git configuration
      default_remote = "origin"
      default_branch = "master"

      # Safeguard
      check_untracked   = false # Deprecated as of v0.4.5 (use terramate.config.disable_safeguards instead)
      check_uncommitted = false # Deprecated as of v0.4.5 (use terramate.config.disable_safeguards instead)
      check_remote      = false # Deprecated as of v0.4.5 (use terramate.config.disable_safeguards instead)
    }
  }
}
