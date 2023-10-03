from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics
from gevent.pywsgi import WSGIServer


app = Flask(__name__)
metrics = PrometheusMetrics(app)

# Static information as metric
metrics.info('app_info', 'Application info', version='1.0.3',
             project_name='python_hello_world', project_type='test_metrics_labels')


@app.route('/')
def hello():
    return "Hello, World!"


@app.route('/_health')
def health():
    return "Healthy!"


# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=8082)

if __name__ == '__main__':
    http_server = WSGIServer(('0.0.0.0', 8082), app)
    http_server.serve_forever()
