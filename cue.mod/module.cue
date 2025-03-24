module: "github.com/nicolastakashi/perses-kubecon-2025"
language: {
	version: "v0.12.0"
}
deps: {
	"github.com/perses/perses/cue@v0": {
		v:       "v0.51.0-preview"
		default: true
	}
	"github.com/perses/plugins/gaugechart@v0": {
		v:       "v0.5.0"
		default: true
	}
	"github.com/perses/plugins/prometheus@v0": {
		v:       "v0.7.0-preview"
		default: true
	}
	"github.com/perses/plugins/statchart@v0": {
		v:       "v0.5.0"
		default: true
	}
	"github.com/perses/plugins/timeserieschart@v0": {
		v:       "v0.5.0"
		default: true
	}
}
