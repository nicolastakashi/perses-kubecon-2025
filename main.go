package main

import (
	"flag"

	"github.com/perses/perses/go-sdk"
	"github.com/perses/perses/go-sdk/dashboard"
)

func main() {
	flag.Parse()
	exec := sdk.NewExec()

	dash, err := dashboard.New(
		"Node Resources",
		dashboard.AddDatasource("Prometheus"),
		dashboard.ProjectName("KubeConEurope2025"),
	)

	exec.BuildDashboard(dash, err)
}
