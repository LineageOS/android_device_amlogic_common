#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

PLATFORM_PATH := device/amlogic/common

## Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_KERNEL_ARCH := arm64

## Platform
TARGET_BOARD_PLATFORM := amlogic

## Properties
TARGET_VENDOR_PROP += $(PLATFORM_PATH)/vendor.prop

## SELinux
include device/amlogic/sepolicy/sepolicy.mk
