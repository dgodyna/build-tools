### Test coverage file
COVERAGE_FILE = $(TARGET_DIR)/coverage.out

### Basic GO commands
GO=go
GOCMD=env $(GO)
GOBIN := $(shell $(GOCMD) env GOPATH)/bin
GORUN=GOFLAGS="$(RUN_GOFLAGS) $(ALL_GOFLAGS)" $(GOCMD) run -v
GOVET=GOFLAGS="$(ALL_GOFLAGS)" $(GOCMD) vet -v
GOBUILD=GOFLAGS="$(BUILD_GOFLAGS) $(ALL_GOFLAGS)" $(GOCMD) build $(GOBUILD_ARGS)
GO_COVERPKG=$(shell GOFLAGS="$(RUN_GOFLAGS) $(ALL_GOFLAGS)" $(GOCMD) list $(ROOT_PKG)/...)
GOTEST=GOFLAGS="$(TEST_GOFLAGS) $(ALL_GOFLAGS)" $(GOCMD) test \
	-covermode=atomic \
	-coverpkg=./... \
	-short \
	-coverprofile=$(COVERAGE_FILE) \
	$(GOTEST_ARGS)

GOCLEAN=$(GOCMD) clean
GOMOD=$(GOCMD) mod
GOGENERATE=GOFLAGS="$(GOGENERATE_GOFLAGS) $(ALL_GOFLAGS)" $(GOCMD) generate

### Build root package
ROOT_PKG ?= $(shell $(GOCMD) list -m)

test: $(BUILD_DIR)
	$(GOTEST) -v ./...
	$(GOVET) ./...