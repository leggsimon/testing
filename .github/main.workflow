workflow "New workflow" {
  on = "pull_request"
  resolves = ["docker://node:10"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@46ffca7632504e61db2d4cb16be1e80f333cb859"
  args = "action closed"
}

action "docker://node:10" {
  uses = "docker://node:10"
  needs = ["Filters for GitHub Actions"]
  args = "-e 'process.exit(require(process.env.GITHUB_EVENT_PATH).pull_request.merged ? 0 : 1)'"
  runs = "node"
}
