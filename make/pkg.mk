TARGET_DIR = $(CURDIR)/target
BUILD_DIR = $(TARGET_DIR)/build

$(TARGET_DIR):
	mkdir -p $(TARGET_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build target to be defined in upper-level makefile
package: build
	cd $(BUILD_DIR); zip --symlinks -r ../$(LIB_NAME)-$(VERSION).zip *

clean:
	rm -fr $(TARGET_DIR)