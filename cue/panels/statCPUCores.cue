package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

statCPUCores: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "CPU Cores"
			description: "Total number of CPU cores"
		}
		plugin: commonStatPlugin & {spec: format: unit: "decimal"}
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				datasource: name: "argos-world"
				query: """
                count(count(node_cpu_seconds_total{\(#filter)}) by (cpu))
                """
			}}
		}]
	}
}
