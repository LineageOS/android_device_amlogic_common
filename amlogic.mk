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

## Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
