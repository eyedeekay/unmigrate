
GO_COMPILER_OPTS = -a -tags netgo -ldflags '-w -extldflags "-static"'

USER_GH=eyedeekay
packagename=unmigrate
VERSION=0.0.02

win:
	GOOS=windows go build \
		$(GO_COMPILER_OPTS) \
		-buildmode=exe \

win32:
	GOOS=windows GOARCH=386 go build \
		$(GO_COMPILER_OPTS) \
		-buildmode=exe \
		-o unmigrate32.exe

lin:
	GOOS=linux go build \
		$(GO_COMPILER_OPTS) \

lin32:
	GOOS=linux GOARCH=386 go build \
		$(GO_COMPILER_OPTS) \
		-o unmigrate32

sums: win win32 lin lin32
	@echo $(packagename) $(VERSION) | tee SUMS.md
	@echo ========================= | tee -a SUMS.md
	@echo "" | tee -a SUMS.md
	@echo "These are the checksums for the versions found in the release." | tee -a SUMS.md
	@echo "These are all 100% static builds." | tee -a SUMS.md
	@echo "" | tee -a SUMS.md
	@echo "Windows" | tee -a SUMS.md
	@echo "-------" | tee -a SUMS.md
	@echo "" | tee -a SUMS.md
	sha256sum unmigrate.exe >> SUMS.md
	sha256sum unmigrate32.exe >> SUMS.md
	@echo "" | tee -a SUMS.md
	@echo "Linux" | tee -a SUMS.md
	@echo "-----" | tee -a SUMS.md
	@echo "" | tee -a SUMS.md
	sha256sum unmigrate >> SUMS.md
	sha256sum unmigrate32 >> SUMS.md
	@echo "" | tee -a SUMS.md


release: sums
	cat SUMS.md | gothub release -s $(GITHUB_TOKEN) -u $(USER_GH) -r $(packagename) -t v$(VERSION) -d -
