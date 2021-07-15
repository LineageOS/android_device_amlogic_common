#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

## AAPT
PRODUCT_AAPT_PREF_CONFIG := tvdpi

## Characteristics
PRODUCT_CHARACTERISTICS := tv

## Logo
PRODUCT_HOST_PACKAGES += \
    res_packer

## NRDP (Netflix)
PRODUCT_COPY_FILES +=  \
    $(LOCAL_PATH)/nrdp/nrdp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp.xml \
    $(LOCAL_PATH)/nrdp/nrdp_audio_platform_capabilities.json:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp_audio_platform_capabilities.json \
    $(LOCAL_PATH)/nrdp/nrdp_audio_platform_capabilities_ms12.json:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp_audio_platform_capabilities_ms12.json \
    $(LOCAL_PATH)/nrdp/nrdp_platform_capabilities.json:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp_platform_capabilities.json

## Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
