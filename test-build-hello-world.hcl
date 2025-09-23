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
        image = "containers.ops.anyone.tech/anyone-protocol/test-build:${VERSION}"
      }

      env {
        VERSION="[[ .commit_sha ]]"
      }

      consul {}

      template {
        data = <<-EOF
        {{- range service "anon-container-registry" }}
        HTTP_PROXY="http://{{ .Address }}:{{ .Port }}"
        {{- end }}
        EOF
        env = true
        destination = "local/env"
      }
    }
  }
}
