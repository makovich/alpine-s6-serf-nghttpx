{
  "bind": "${HOST_IP}",
  "node_name": "${HOSTNAME}",

  "log_level": "info",

  "retry_interval": "5s",
  "retry_join": [
    "${FRONTEND_NAME}"
  ],

  "tags": {
    "role": "backend",
    "BE_IP": "${HOST_IP}",
    "BE_PORT": "${BACKEND_PORT}",
    "BE_PATTERN": "${BACKEND_PATTERN}",
    "BE_PARAMS": "${BACKEND_PARAMS}"
  }
}
