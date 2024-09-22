from todo_project import app
from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)
metrics = PrometheusMetrics(app)

@app.route('/metrics')
def metrics_endpoint():
    return metrics.get_metrics()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')


