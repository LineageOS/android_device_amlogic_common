#
# Copyright (C) 2022-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

PLATFORM_PATH := device/amlogic/common

## BUILD_BROKEN_*
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

## Android Verified Boot
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := 0
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --prop dovi_hash:3cd93647bdd864b4ae1712d57a7de3153e3ee4a4dfcfae5af8b1b7d999b93c5a
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

ifeq ($(TARGET_KERNEL_VERSION),5.4)
BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
else
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 2
endif

## Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_KERNEL_ARCH := arm64

## Audio
BOARD_USES_ALSA_AUDIO := true

## Dex Pre-Opt
WITH_DEXPREOPT_DEBUG_INFO := false

## Display
ifeq ($(PRODUCT_IS_ATV),true)
TARGET_SCREEN_DENSITY ?= 320
else
TARGET_SCREEN_DENSITY ?= 240
endif

## HIDL
ifeq ($(TARGET_KERNEL_VERSION),5.4)
DEVICE_MANIFEST_FILE += $(PLATFORM_PATH)/manifest_5.4.xml
else
DEVICE_MANIFEST_FILE += $(PLATFORM_PATH)/manifest.xml
endif

ifneq ($(BOARD_HAVE_BLUETOOTH),false)
DEVICE_MANIFEST_FILE += $(PLATFORM_PATH)/manifest_bt.xml
endif

ifeq ($(PRODUCT_IS_ATV),true)
DEVICE_MANIFEST_FILE += $(PLATFORM_PATH)/manifest_tv.xml
endif

DEVICE_MATRIX_FILE := $(PLATFORM_PATH)/compatibility_matrix.xml

## Kernel
BOARD_CUSTOM_DTBIMG_MK := device/amlogic/common/mkdtbimg.mk
BOARD_CUSTOM_DTBOIMG_MK := device/amlogic/common/mkdtboimg.mk
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_NEEDS_DTBOIMAGE := true
BOARD_KERNEL_BASE := 0x01078000
BOARD_KERNEL_CMDLINE += androidboot.dtbo_idx=0 hdr_policy=1 otg_device=1
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048

ifeq ($(TARGET_KERNEL_VERSION),5.4)
BOARD_BOOT_HEADER_VERSION := 3
TARGET_BOOTLOADER_IS_2ND := false
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
else
BOARD_BOOT_HEADER_VERSION := 2
BOARD_DTB_OFFSET := 0x00e88000
BOARD_RAMDISK_OFFSET := 0xfef10000
BOARD_SECOND_OFFSET := 0xfee10000
BOARD_TAGS_OFFSET := 0xfdf10100
TARGET_BOOTLOADER_IS_2ND := true
BOARD_MKBOOTIMG_ARGS = --kernel_offset $(BOARD_KERNEL_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_TAGS_OFFSET) --dtb_offset $(BOARD_DTB_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION)
endif

## Partitions
ifeq ($(TARGET_KERNEL_VERSION),5.4)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 25165824
else
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824
endif
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 838860800
ifeq ($(TARGET_KERNEL_VERSION),5.4)
BOARD_DTBIMAGE_PARTITION_SIZE := 258048
else
BOARD_DTBIMAGE_PARTITION_SIZE := 262144
endif
BOARD_DTBOIMG_PARTITION_SIZE := 2097152
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 4896849920
BOARD_USES_METADATA_PARTITION := true
TARGET_USERIMAGES_USE_EXT4 := true

ifneq ($(PRODUCT_IS_ATV),true)
BOARD_PRODUCTIMAGE_MINIMAL_PARTITION_RESERVED_SIZE ?= true
endif

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
include vendor/lineage/config/BoardConfigReservedSize.mk
endif

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

## Platform
TARGET_BOARD_PLATFORM := amlogic

## Properties
TARGET_PRODUCT_PROP += $(PLATFORM_PATH)/product.prop
TARGET_VENDOR_PROP += $(PLATFORM_PATH)/vendor.prop

## Recovery
TARGET_RECOVERY_DENSITY := 200dpi
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

## SELinux
include device/amlogic/sepolicy/sepolicy.mk

## Wi-Fi
ifneq ($(BOARD_HAVE_WIFI),false)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X
endif
