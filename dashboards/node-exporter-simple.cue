package dashboard

import (
	dashboardBuilder "github.com/perses/perses/cue/dac-utils/dashboard"
	panelGroupsBuilder "github.com/perses/perses/cue/dac-utils/panelgroups"
	promFilterBuilder "github.com/perses/plugins/prometheus/sdk/cue/filter"

	"github.com/nicolastakashi/perses-kubecon-2025/cue/panels"
	"github.com/nicolastakashi/perses-kubecon-2025/cue/variables:node"
)

#nodeFilter: {promFilterBuilder & node}.filter

dashboardBuilder & {
	#name: "node-exporter-simple-cue"
	#display: name: "Node Exporter Simple"
	#project: "KubeConEurope2025"
	#variables: node.variables
	#panelGroups: panelGroupsBuilder & {
		#input: [
			{
				#title: "Quick CPU / Mem / Disk"
				#cols:  7
				#panels: [
					panels.gaugeSysLoad & {#filter: #nodeFilter},
					panels.gaugeRAMUsed & {#filter: #nodeFilter},
					panels.gaugeRootFS & {#filter: #nodeFilter},
					panels.statCPUCores & {#filter: #nodeFilter},
					panels.statRAMTotal & {#filter: #nodeFilter},
					panels.statRootFSTotal & {#filter: #nodeFilter},
					panels.statUptime & {#filter: #nodeFilter},
				]
			},
			{
				#title:  "Basic CPU / Mem / Net / Disk"
				#cols:   2
				#height: 7
				#panels: [
					panels.timeseriesCPUBasic & {#filter: #nodeFilter},
					panels.timeseriesMemoryBasic & {#filter: #nodeFilter},
					panels.timeseriesNetworkTrafficBasic & {#filter: #nodeFilter},
					panels.timeseriesDiskSpaceUsedBasic & {#filter: #nodeFilter},
				]
			},
		]
	}
}
