package main

import (
	"flag"
	"time"

	"github.com/perses/perses/go-sdk"
	"github.com/perses/perses/go-sdk/common"
	"github.com/perses/perses/go-sdk/dashboard"
	"github.com/perses/perses/go-sdk/panel"
	panelgroup "github.com/perses/perses/go-sdk/panel-group"
	timeSeriesPanel "github.com/perses/perses/go-sdk/panel/time-series"
	promDs "github.com/perses/perses/go-sdk/prometheus/datasource"
	"github.com/perses/perses/go-sdk/prometheus/query"
	labelValuesVar "github.com/perses/perses/go-sdk/prometheus/variable/label-values"
	listVar "github.com/perses/perses/go-sdk/variable/list-variable"
)

func AddInstanceVariable(enabled bool) dashboard.Option {
	if !enabled {
		return func(plugin *dashboard.Builder) error {
			return nil
		}
	}
	return dashboard.AddVariable("instance",
		listVar.List(
			labelValuesVar.PrometheusLabelValues("instance",
				labelValuesVar.Matchers(
					"node_uname_info{job='node', sysname!='Darwin'}",
				),
			),
			listVar.DisplayName("instance"),
			listVar.AllowAllValue(true),
		),
	)
}

var enableInstanceVariable bool

func main() {
	flag.BoolVar(&enableInstanceVariable, "enable-instance-variable", false, "enable instance variable")
	flag.Parse()
	exec := sdk.NewExec()

	dash, err := dashboard.New(
		"node-exporter-simple-go",
		dashboard.Duration(time.Hour),
		dashboard.Name("Node Exporter Simple"),
		dashboard.AddDatasource("Prometheus", promDs.Prometheus(promDs.DirectURL("https://prometheus.demo.prometheus.io"))),
		dashboard.ProjectName("KubeConEurope2025"),
		AddInstanceVariable(enableInstanceVariable),
		dashboard.AddPanelGroup("CPU",
			panelgroup.PanelsPerLine(1),
			panelgroup.AddPanel("CPU Usage",
				panel.AddQuery(query.PromQL("rate(node_cpu_seconds_total{mode=\"user\"}[5m])")),
				timeSeriesPanel.Chart(
					timeSeriesPanel.WithYAxis(
						timeSeriesPanel.YAxis{
							Format: &common.Format{
								Unit: string(common.SecondsUnit),
							},
						},
					),
					timeSeriesPanel.WithLegend(timeSeriesPanel.Legend{
						Position: timeSeriesPanel.BottomPosition,
						Mode:     timeSeriesPanel.TableMode,
						Values:   []common.Calculation{common.LastCalculation},
					}),
				),
			),
		),
	)

	exec.BuildDashboard(dash, err)
}
