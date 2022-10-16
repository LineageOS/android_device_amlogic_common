#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

ifneq ($(filter gxl gxm g12a g12b sm1, $(TARGET_AMLOGIC_SOC)),)

$(INSTALLED_2NDBOOTLOADER_TARGET): $(INSTALLED_DTBIMAGE_TARGET)
	$(hide) cp $< $@

endif
