package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

statRootFSTotal: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "RootFS Total"
			description: "Total RootFS"
		}
		plugin: commonStatPlugin & unitBytes
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				query: """
                node_filesystem_size_bytes{\(#filter),mountpoint="/",fstype!="rootfs"}
                """
			}}
		}]
	}
}
