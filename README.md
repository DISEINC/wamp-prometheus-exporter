# Crossbar + Prometheus exporter
Combines a crossbar image and a Prometheus exporter

## WAMP Prometheus Exporter

Uses WAMP meta events and meta procedures to collect and expose metrics.


Sample output:

```
# HELP python_info Python platform information
# TYPE python_info gauge
python_info{implementation="CPython",major="3",minor="6",patchlevel="5",version="3.6.5"} 1.0
# HELP active_session_count Number of sessions currently active
# TYPE active_session_count gauge
active_session_count{realm="myapp",router_url="ws://localhost:9101/ws"} 3.0
# HELP active_callee_count Number of sessions currently attached to the registration
# TYPE active_callee_count gauge
active_callee_count{realm="myapp",router_url="ws://localhost:9101/ws",uri="cz.myapp.api.authenticate"} 1.0
active_callee_count{realm="myapp",router_url="ws://localhost:9101/ws",uri="cz.myapp.api.authorize"} 1.0
# HELP active_subscription_count Number of sessions currently subscribed to the subscription
# TYPE active_subscription_count gauge
active_subscription_count{realm="myapp",router_url="ws://localhost:9101/ws",uri="cz.myapp.api.chatlist.someuser"} 1.0
active_subscription_count{realm="myapp",router_url="ws://localhost:9101/ws",uri="cz.myapp.api.chat.somechat"} 1.0
active_subscription_count{realm="myapp",router_url="ws://localhost:9101/ws",uri="cz.myapp.api.chat.somechat2"} 1.0
active_subscription_count{realm="myapp",router_url="ws://localhost:9101/ws",uri="cz.myapp.api.chat.somechat3"} 1.0
```

## Install and deploy

Build and push docker image:

```
docker build -t wamp .
docker tag wamp registry.dise.local:5000/wamp
docker push registry.dise.local:5000/wamp
```

Pull and use docker image:

```
docker pull registry.dise.local:5000/wamp
docker run -d -v $pwd/crossbar:/node/.crossbar -e WAMP_SECRET=E0087005-3B4C-48B7-AA33-C209430893C9 -e WAMP_PORT=3100 -e PROMETHEUS_EXPORTER_PORT=9123 -p 3100:3100 -p 9123:9123 registry.dise.local:5000/wamp
```

## Metrics

Metrics will be made available on port specified by the environment variable ``PROMETHEUS_EXPORTER_PORT`` (default 9123)
