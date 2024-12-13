return {
	name = "Final Checks",
	builder = function()
		return {
			cmd = "/bin/bash",
			args = {
				"-c",
				'go mod tidy && if [ `go env GOWORK` != "" ]; then go work vendor; else go mod vendor; fi && make all && make qa && make lint-golangci',
			},
		}
	end,
}
