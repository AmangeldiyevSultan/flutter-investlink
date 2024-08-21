SCRIPTS_DIR := scripts

CLEAN_IOS_SCRIPT := $(SCRIPTS_DIR)/clean_ios.sh
CODEGEN_SCRIPT := $(SCRIPTS_DIR)/build_runner.sh
BUILD_APK_DEV := $(SCRIPTS_DIR)/build_apk_dev.sh
BUILD_AAB_DEV := $(SCRIPTS_DIR)/build_aab_dev.sh
BUILD_SPLASH := $(SCRIPTS_DIR)/build_splash.sh
BUILD_ICON := $(SCRIPTS_DIR)/build_icon.sh

# Tasks to run each script
clean_ios:
	sh $(CLEAN_IOS_SCRIPT)

# Tasks to run code generation
codegen:
	sh $(CODEGEN_SCRIPT) 

# Tasks to build APK for development
apk_dev:
	sh $(BUILD_APK_DEV)

# Tasks to build AAB for development
aab_dev:
	sh $(BUILD_AAB_DEV)

# Tasks to generate splash screen
splash:
	sh $(BUILD_SPLASH)

# Tasks to generate app icon
icon:
	sh $(BUILD_ICON)


# By default, we display a message about available tasks
all:
	@echo "Available tasks:"
	@echo " - clean_ios: Clears local dependencies for iOS."
	@echo " - codegen: build_runner build & dart format"
	@echo " - apk_dev: Build APK for development"
	@echo " - aab_dev: Build AAB for development"
	@echo " - splash: Generate splash screen"
	@echo " - icon: Generate app icon"

