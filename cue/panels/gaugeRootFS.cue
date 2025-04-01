package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

gaugeRootFS: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Root FS used"
			description: "Used Root FS"
		}
		plugin: commonGaugePlugin
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				query: """
                    100 - (
                        (
                            avg_over_time(node_filesystem_avail_bytes{\(#filter),mountpoint="/",fstype!="rootfs"}[$__rate_interval])
                            *
                            100
                        )
                        /
                        avg_over_time(node_filesystem_size_bytes{\(#filter),mountpoint="/",fstype!="rootfs"}[$__rate_interval])
                    )
                """
			}}
		}]
	}
}
