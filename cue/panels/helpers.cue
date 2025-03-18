package panels

import (
	gaugeChart "github.com/perses/plugins/gaugechart/schemas:model"
	statChart "github.com/perses/plugins/statchart/schemas:model"
	timeseriesChart "github.com/perses/plugins/timeserieschart/schemas:model"
)

commonGaugePlugin: gaugeChart & {spec: {
	calculation: "last-number"
	format: unit: "percent"
	max: 100
	thresholds: steps: [
		{color: "rgba(50, 172, 45, 0.97)", value: 0},
		{color: "rgba(237, 129, 40, 0.89)", value: 80},
		{color: "rgba(245, 54, 54, 0.9)", value: 90},
	]
}}

commonStatPlugin: statChart & {spec: {
	calculation: "last-number"
	thresholds: defaultColor: "#7b7b7b"
}}

commonTimeseriesPlugin: timeseriesChart & {spec: {
	legend: {
		mode:     "table"
		position: "right"
		values:   ["min", "max"]
	}
	visual: areaOpacity: 0.05
}}

unitBytes: {spec: format: unit: "bytes"}
