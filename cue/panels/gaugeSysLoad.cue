package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

gaugeSysLoad: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Sys Load (5m avg)"
			description: "Busy state of all CPU cores together (5 min average)"
		}
		plugin: commonGaugePlugin
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				datasource: name: "argos-world"
				query: """
                avg_over_time(node_load5{\(#filter)}[$__rate_interval]) * 100
                /
                on(instance) group_left sum by (instance) (
                    irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                )
                """
			}}
		}]
	}
}
