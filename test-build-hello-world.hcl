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

        auth {
          server_address = "containers.ops.anyone.tech"
          username = "[[ DOCKER_USER ]]"
          password = "[[ DOCKER_PASSWORD ]]"
        }
      }

      env {
        VERSION="[[ .commit_sha ]]"
      }
    }
  }
}
