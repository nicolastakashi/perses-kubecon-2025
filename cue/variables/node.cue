package node

import (
	varGroupBuilder "github.com/perses/perses/cue/dac-utils/variable/group"
	textVarBuilder "github.com/perses/perses/cue/dac-utils/variable/text"
	promQLVarBuilder "github.com/perses/plugins/prometheus/sdk/cue/variable/promql"
)

varGroupBuilder & {
	#input: [
		textVarBuilder & {
			#name: "job"
			#value: "node"
			#constant: true
			#display: hidden: true
		},
		promQLVarBuilder & {
			#name: "instance"
			#display: name: "Host"
			#metric: "node_uname_info"
		},
	]
}
