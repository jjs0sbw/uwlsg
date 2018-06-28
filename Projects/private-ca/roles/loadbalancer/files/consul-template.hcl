consul {
  retry {
    attempts    = 12
    backoff     = "250ms"
    max_backoff = "20s"
  }

  ssl {
    verify = true

    key     = "/etc/ssl/cert-key.pem"
    cert    = "/etc/ssl/cert.pem"
    ca_cert = "/usr/local/share/ca-certificates/Example_Root_CA.crt"
  }
}

max_stale = "10m"

log_level = "warn"

pid_file = "/run/consul-template.pid"

wait {
  min = "2s"
  max = "10s"
}

syslog {
  enabled  = true
  facility = "LOCAL5"
}

template {
  source      = "/etc/haproxy/haproxy.cfg.ctmpl"
  destination = "/etc/haproxy/haproxy.cfg"
  command     = "systemctl reload-or-restart haproxy"
  perms       = 0644
}
