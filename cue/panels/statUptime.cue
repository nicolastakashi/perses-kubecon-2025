package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

statUptime: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Uptime"
			description: "System uptime"
		}
		plugin: commonStatPlugin & {spec: format: unit: "seconds"}
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				query: """
                node_time_seconds{\(#filter)}
                -
                node_boot_time_seconds{\(#filter)}
                """
			}}
		}]
	}
}
