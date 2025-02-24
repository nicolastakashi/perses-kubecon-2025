package main

import (
	"flag"

	"github.com/perses/perses/go-sdk"
	"github.com/perses/perses/go-sdk/dashboard"
)

func main() {
	flag.Parse()
	exec := sdk.NewExec()

	exec.BuildDashboard(dashboard.Builder{}, nil)
}
