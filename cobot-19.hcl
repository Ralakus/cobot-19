job "cobot-19" {
  datacenters = ["dc1"]

  type = "service"

  reschedule {
    delay = "30s"
    delay_function = "constant"
    unlimited = true
  }

  update {
    max_parallel      = 1
    health_check      = "checks"
    min_healthy_time  = "10s"
    healthy_deadline  = "5m"
    progress_deadline = "10m"
    auto_revert       = true
    canary            = 0
    stagger           = "30s"
  }

  group "bot" {
    count = 1

    restart {
      interval = "10m"
      attempts = 2
      delay    = "15s"
      mode     = "fail"
    }

    task "bot" {
      driver = "docker"
      config {
        image = "ralakus/cobot-19:latest"

        volumes = [
          "/home/mikhail/services/cobot-19/:/usr/src/app",
          "/var/run/docker.sock:/var/run/docker.sock:rw",
        ]
      }

      service {
        name = "cobot-19"
        tags = ["discord", "bot"]
      }

      resources {
        cpu    = 500 # MHz
        memory = 512 # MB
        network {
          mbits = 100
        }
      }
    }
  }
}