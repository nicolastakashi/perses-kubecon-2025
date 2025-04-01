package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

statRAMTotal: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "RAM Total"
			description: "Total RAM"
		}
		plugin: commonStatPlugin & unitBytes
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				query: """
                node_memory_MemTotal_bytes{\(#filter)}
                """
			}}
		}]
	}
}
