
GO_COMPILER_OPTS = -a -tags netgo -ldflags '-w -extldflags "-static"'

win:
	GOOS=windows go build \
		$(GO_COMPILER_OPTS) \
		-buildmode=exe \