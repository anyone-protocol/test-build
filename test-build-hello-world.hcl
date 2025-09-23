job "test-build-hello-world" {
  datacenters = ["ator-fin"]
  type = "batch"
  namespace = "operations"

  constraint {
    attribute = "${node.unique.id}"
    value = "2d423f2c-5ab2-0106-ef1f-56f953626d87"
    # attribute = "${meta.pool}"
    # value = "operations"
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
        {{- range service "anon-container-registry" }}
        CONTAINER_REGISTRY_ADDR="{{ .Address }}:{{ .Port }}"
        {{- end }}
        EOF
        env = true
        destination = "local/env"
      }
    }
  }
}
