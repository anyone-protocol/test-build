job "test-build-hello-world" {
  datacenters = ["ator-fin"]
  type = "batch"
  namespace = "operations"

  constraint {
    attribute = "${meta.pool}"
    value = "operations"
  }

  group "test-build-hello-world-group" {
    count = 1

    task "test-build-hello-world-task" {
      driver = "docker"
      config {
        image = "ghcr.io/anyone-protocol/test-build:${VERSION}"
      }

      env {
        VERSION="[[ .commit_sha ]]"
      }
    }
  }
}
