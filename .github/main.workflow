workflow "Build and publish debian container" {
  resolves = [
    "Publish debian container"
  ]
  on = "push"
}

action "Docker login" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  env = {
    DOCKER_REGISTRY_URL = "docker.pkg.github.com/jordemort/base-images"
  }
  needs = ["Build debian container"]
}

action "Check if debian was modified" {
  uses = "jordemort/modified-file-filter-action@master"
  args = "debian/** .github/main.workflow"
  needs = ["Check if branch is master"]
}

action "Build debian container" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build --tag docker.pkg.github.com/jordemort/base-images/debian:master debian"
  needs = ["Check if debian was modified"]
}

action "Publish debian container" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Build debian container", "Docker login"]
  args = "push docker.pkg.github.com/jordemort/base-images/debian:master"
}

action "Check if branch is master" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch master"
}
