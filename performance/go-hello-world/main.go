package main

import (
	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus"
	goginprometheus "github.com/zsais/go-gin-prometheus"
)

var (
	info = prometheus.NewGauge(prometheus.GaugeOpts{
		Name: "app_info",
		ConstLabels: prometheus.Labels{
			"version":      "1.0.3",
			"project_name": "go_hello_world",
			"project_type": "test_metrics_labels",
		},
	})
)

func init() {
	prometheus.MustRegister(info)
	info.Set(1)
}

func main() {
	r := gin.Default()

	p := goginprometheus.NewPrometheus("gin")
	p.Use(r)

	r.GET("/", func(c *gin.Context) {
		c.String(200, "Hello, World!")
	})

	r.GET("/_health", func(c *gin.Context) {
		c.String(200, "Healthy!")
	})

	r.Run(":8083") // Listen and serve on 0.0.0.0:8083
}