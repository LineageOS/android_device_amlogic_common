#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#


LOCAL_PATH := $(call my-dir)

DTBTARGET := $(PRODUCT_OUT)/dtb.img

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS) $(INSTALLED_KERNEL_TARGET) $(DTBTARGET)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) --kernel $(call bootimage-to-kernel,$@) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --second $(DTBTARGET) --dtb $(DTBTARGET) --output $@
	$(hide )$(call assert-max-image-size,$@,$(call get-bootimage-partition-size,$@,boot))

INTERNAL_RECOVERYIMAGE_ARGS += --second $(DTBTARGET) --dtb $(DTBTARGET)
$(INSTALLED_RECOVERYIMAGE_TARGET): $(recoveryimage-deps) $(RECOVERYIMAGE_EXTRA_DEPS) $(DTBTARGET)
	$(call build-recoveryimage-target, $@, $(recovery_kernel))
