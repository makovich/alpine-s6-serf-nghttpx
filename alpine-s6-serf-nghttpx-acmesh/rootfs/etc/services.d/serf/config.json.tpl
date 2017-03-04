{
  "bind": "${HOST_IP}",
  "node_name": "${HOSTNAME}",

  "tags": {
    "role": "frontend"
  },

  "event_handlers": [
    "/etc/serf/handler"
  ]
}
