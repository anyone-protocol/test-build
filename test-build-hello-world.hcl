job "test-build-hello-world" {
  datacenters = ["ator-fin"]
  type = "batch"
  namespace = "dev-services"

  constraint {
    attribute = "${meta.pool}"
    value = "dev"
  }

  group "test-build-hello-world-group" {
    count = 1

    task "test-build-hello-world-task" {
      driver = "docker"
      config {
        image = "containers.ops.anyone.tech/anyone-protocol/test-build:${VERSION}"
      }

      env {
        VERSION="[[ .commit_sha ]]"
      }
    }
  }
}
