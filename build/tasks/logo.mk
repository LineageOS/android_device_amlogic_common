#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifneq ($(filter gxl gxm g12a g12b sm1 s4 t7 sc2, $(TARGET_AMLOGIC_SOC)),)

COMMON_LOGO_FILES := device/amlogic/common/logo

IMGPACK := $(HOST_OUT_EXECUTABLES)/res_packer$(HOST_EXECUTABLE_SUFFIX)

INSTALLED_LOGOIMAGE_TARGET := $(PRODUCT_OUT)/logo.img
$(INSTALLED_LOGOIMAGE_TARGET): $(LOCAL_INSTALLED_MODULE) | $(IMGPACK) $(MINIGZIP) $(ACP)
	@echo "generate $(INSTALLED_LOGOIMAGE_TARGET) $(COMMON_LOGO_FILES) $(LOGO_FILES) $(LOGO_FILES_OVERRIDE)"
	$(hide) mkdir -p $(PRODUCT_OUT)/logo
	$(foreach bmpf, $(filter %.bmp, $(wildcard $(COMMON_LOGO_FILES)/* $(LOGO_FILES)/* $(LOGO_FILES_OVERRIDE)/*)), \
		if [ -n "$(shell find $(bmpf) -type f -size +256k)" ]; then \
			echo "logo pic $(bmpf) >256k gziped"; \
			$(MINIGZIP) -c $(bmpf) > $(PRODUCT_OUT)/logo/$(notdir $(bmpf)); \
		else \
			$(ACP) $(bmpf) $(PRODUCT_OUT)/logo; \
		fi;)
	$(hide) $(IMGPACK) -r $(PRODUCT_OUT)/logo $(INSTALLED_LOGOIMAGE_TARGET)
	$(hide) rm -rf $(PRODUCT_OUT)/logo

droidcore: $(INSTALLED_LOGOIMAGE_TARGET)
$(INSTALLED_2NDBOOTLOADER_TARGET): $(INSTALLED_LOGOIMAGE_TARGET)
$(BUILT_TARGET_FILES_PACKAGE): $(INSTALLED_LOGOIMAGE_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_LOGOIMAGE_TARGET)

endif
