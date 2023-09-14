#
# Copyright (C) 2022-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

## AAPT
ifeq ($(PRODUCT_IS_ATV),true)
PRODUCT_AAPT_PREF_CONFIG := xhdpi
else
PRODUCT_AAPT_PREF_CONFIG := hdpi
endif

## Audio
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/hearing_aid_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/msd_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/msd_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/surround_sound_configuration_5_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_configuration_5_0.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml

PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-impl \
    android.hardware.audio.effect@4.0-impl \
    android.hardware.audio.service \
    audio.r_submix.default \
    audio.usb.default

## Bluetooth
ifeq ($(TARGET_HAVE_BLUETOOTH),false)
PRODUCT_PROPERTY_OVERRIDES += \
    config.disable_bluetooth=true
else
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio@2.0-impl \
    audio.bluetooth.default

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.autoconnectbt.btclass=50c \
    ro.vendor.autoconnectbt.isneed=false \
    ro.vendor.autoconnectbt.macprefix=00:CD:FF \
    ro.vendor.autoconnectbt.nameprefix=Amlogic_RC \
    ro.vendor.autoconnectbt.rssilimit=70

ifeq ($(PRODUCT_IS_ATV),true)
PRODUCT_PROPERTY_OVERRIDES += \
    atv.setup.bt_remote_pairing=true
endif

PRODUCT_COPY_FILES +=  \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml
endif

## Boot animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920

## Characteristics
ifeq ($(PRODUCT_IS_ATV),true)
PRODUCT_CHARACTERISTICS := tv
else
PRODUCT_CHARACTERISTICS ?= tablet
endif

## Codecs
ifeq ($(PRODUCT_USE_SW_OMX),true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs_sw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml
endif

## DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey \
    libdrm.vendor \
    libz_stable.vendor

## fastbootd
PRODUCT_PACKAGES += fastbootd

## File-system permissions
PRODUCT_PACKAGES += \
    fs_config_dirs \
    fs_config_files

## Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

## Hardware Composer
PRODUCT_PACKAGES += \
    libhwc2on1adapter \
    libhwc2onfbadapter

## HDMI CEC
PRODUCT_PACKAGES += \
    android.hardware.tv.cec@1.0-impl \
    android.hardware.tv.cec@1.0-service

PRODUCT_COPY_FILES +=  \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hdmi.cec.xml

## Light
ifneq ($(TARGET_KERNEL_VERSION),5.4)
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service
endif

## Logo
PRODUCT_HOST_PACKAGES += \
    res_packer

## Memtrack
ifneq ($(TARGET_KERNEL_VERSION),5.4)
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service
endif

## NRDP (Netflix)
PRODUCT_COPY_FILES +=  \
    $(LOCAL_PATH)/nrdp/nrdp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp.xml \
    $(LOCAL_PATH)/nrdp/nrdp_audio_platform_capabilities.json:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp_audio_platform_capabilities.json \
    $(LOCAL_PATH)/nrdp/nrdp_audio_platform_capabilities_ms12.json:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp_audio_platform_capabilities_ms12.json \
    $(LOCAL_PATH)/nrdp/nrdp_platform_capabilities.json:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp_platform_capabilities.json

## Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

ifneq ($(PRODUCT_IS_ATV),true)
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-tab
endif

PRODUCT_ENFORCE_RRO_TARGETS := *

## Permissions (Hardware)
PRODUCT_COPY_FILES +=  \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.gamepad.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.gamepad.xml \
    frameworks/native/data/etc/android.hardware.location.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml

ifneq ($(PRODUCT_IS_ATV),true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.portrait.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.portrait.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml
endif

## Permissions (Software)
PRODUCT_COPY_FILES +=  \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml \
    frameworks/native/data/etc/android.software.cts.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.cts.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.picture_in_picture.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.picture_in_picture.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.voice_recognizers.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.voice_recognizers.xml

## Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

## Trust HAL
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

## USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

PRODUCT_COPY_FILES +=  \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

ifneq ($(BOARD_HAVE_WIFI),false)
## Wi-Fi
PRODUCT_PACKAGES += \
    hostapd \
    libwpa_client \
    WifiOverlay \
    wpa_supplicant \
    wpa_supplicant.conf

ifneq ($(TARGET_HAVE_WIFIHAL),false)
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service
endif

PRODUCT_COPY_FILES +=  \
    device/amlogic/common/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml
endif
