// enable volume mount support for docker containers
plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}
