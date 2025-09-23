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
        image = "${CONTAINER_REGISTRY_ADDR}/anyone-protocol/test-build:${VERSION}"
      }

      env {
        VERSION="[[ .commit_sha ]]"
      }

      consul {}

      template {
        data = <<-EOF
        CONTAINER_REGISTRY_ADDR="https://internal.containers.ops.anyone.tech"
        EOF
        env = true
        destination = "local/env"
      }
    }
  }
}
