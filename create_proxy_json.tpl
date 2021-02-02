{
  "data": {
    "type": "proxy",
    "attributes": {
      "label": "arch-test",
      "note": "some-text-here",
      "tags": [],
      "ipv6_front_end": false,
      "backends": [
        {
          "address_fqdn": "example.com",
          "zones": [
            "UK"
          ]
        }
      ],
      "proxy_services": [
        {
          "service_type": "HTTP",
          "protocol": "TCP",
          "load_balancing_method": "Round Robin",
          "threat_profile": "threat-intel-profile-name",
          "profile_settings": [
            {
              "host": "*",
              "uri": "*",
              "l7_profile": "",
              "waf_policy": ""
            },
            {
              "host": "example.com",
              "uri": "/apage/index",
              "l7_profile": "my_profile",
              "waf_policy": "my_policy"
            }
          ],
          "monitoring": {
            "type": "HTTP",
            "interval": 30,
            "send_string": "GET / HTTP/1.1\r\nHost:example.local\r\nConnection: Close\r\n\r\n",
            "receive_string": "Application is running."
          },
          "frontend_port": 80,
          "backend_port": 80,
          "client_connection_idle_timeout": 60,
          "insert_x_forwarded_for_header": true,
          "multiplex_http_https_requests": false,
          "alternative_trusted_source_header": "header-name",
          "cookie_persistence": false,
          "cache_enabled": false,
          "irules": [
            "irule-name",
            "irule2-name"
          ],
          "tcp_profile": "Modern"
        }
      ]
    }
  }
}