#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

MKDTBOIMG := $(HOST_OUT_EXECUTABLES)/mkdtboimg.py
DTBDIR := $(PRODUCT_OUT)/obj/KERNEL_OBJ/arch/arm64/boot/dts/amlogic

TARGET_DTBO_NAME ?= android_p_overlay_dt

$(BOARD_PREBUILT_DTBOIMAGE): $(INSTALLED_KERNEL_TARGET) $(MKDTBOIMG)
	$(MKDTBOIMG) create $@ $(foreach dtbo, $(TARGET_DTBO_NAME), \
		$(DTBDIR)/$(strip $(dtbo)).dtb \
	)
