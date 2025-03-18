package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
)

timeseriesCPUBasic: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "CPU Basic"
			description: "Basic CPU info"
		}
		plugin: commonTimeseriesPlugin & {spec: yAxis: format: unit: "percent-decimal"}
		queries: [
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter), mode="system"}[$__rate_interval])
                    )
                    / 
                    on(instance) group_left sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                    )
                    """
					seriesNameFormat: "System"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    sum by(instance) (
                        irate(node_cpu_seconds_total{\(#filter), mode="user"}[$__rate_interval])
                    )
                    / on(instance) group_left sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                    )
                    """
					seriesNameFormat: "User"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    sum by(instance) (
                        irate(node_cpu_seconds_total{\(#filter), mode="iowait"}[$__rate_interval])
                    )
                    / on(instance) group_left sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                    )
                    """
					seriesNameFormat: "IOWait"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    sum by(instance) (
                        irate(node_cpu_seconds_total{\(#filter), mode=~".*irq"}[$__rate_interval])
                    ) 
                    / on(instance) group_left sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                    )
                    """
					seriesNameFormat: "IRQ & SOFTIRQ"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter), mode!='idle',mode!='user',mode!='system',mode!='iowait',mode!='irq',mode!='softirq'}[$__rate_interval])
                    )
                    / on(instance) group_left sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                    )
                    """
					seriesNameFormat: "Other"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    sum by(instance) (
                        irate(node_cpu_seconds_total{\(#filter), mode="idle"}[$__rate_interval])
                    )
                    / on(instance) group_left sum by (instance) (
                        irate(node_cpu_seconds_total{\(#filter)}[$__rate_interval])
                    )
                    """
					seriesNameFormat: "Idle"
				}}
			},
		]
	}
}
