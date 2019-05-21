workflow "Build container" {
  resolves = ["Publish debian container"]
  on = "push"
}

action "Docker login" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  env = {
    DOCKER_REGISTRY_URL = "docker.pkg.github.com/jordemort/base-images"
  }
}

action "Check if debian/** was modified" {
  uses = "jordemort/modified-file-filter-action@master"
  args = "debian/**"
}

action "Build debian container" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build --tag docker.pkg.github.com/jordemort/base-images/debian:latest debian"
  needs = ["Check if debian/** was modified"]
}

action "Publish debian container" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Build debian container", "Docker login"]
  args = "push docker.pkg.github.com/jordemort/base-images/debian:latest"
}
