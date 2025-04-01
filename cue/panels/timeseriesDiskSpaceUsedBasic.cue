package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

timeseriesDiskSpaceUsedBasic: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Disk Space Used Basic"
			description: "Disk space used of all filesystems mounted"
		}
		plugin: commonTimeseriesPlugin & {spec: yAxis: format: unit: "percent"}
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				query: """
                100 - (
                    (node_filesystem_avail_bytes{\(#filter),device!~'rootfs'} * 100)
                    /
                    node_filesystem_size_bytes{\(#filter),device!~'rootfs'}
                )
                """
				seriesNameFormat: "{{mountpoint}}"
			}}
		}]
	}
}
