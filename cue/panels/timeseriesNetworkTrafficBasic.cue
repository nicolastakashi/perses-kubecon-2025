package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

timeseriesNetworkTrafficBasic: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Network Traffic Basic"
			description: "Basic network info per interface"
		}
		plugin: commonTimeseriesPlugin
		queries: [
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					query: """
                    irate(node_network_receive_bytes_total{\(#filter)}[$__rate_interval]) * 8
                    """
					seriesNameFormat: "recv {{device}}"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					query: """
                    irate(node_network_transmit_bytes_total{\(#filter)}[$__rate_interval]) * 8
                    """
					seriesNameFormat: "trans {{device}}"
				}}
			},
		]
	}
}
