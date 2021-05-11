#
# Copyright 2013 The Android Open-Source Project
# Copyright 2020 Chris Simmonds, chris@2net.co.uk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This is based on build/target/product/aosp_x86_64.mk

# If there are two PRODUCT_COPY_FILES rules for the same target file, the FIRST
# ONE WINS. In the section below, we want to override some files that are copied
# in emulator_vendor.mk so this MUST come before we inherit that file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.ranchu.rc:vendor/etc/init/hw/init.ranchu.rc \
    $(LOCAL_PATH)/config.ini:config.ini

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# The system image of aosp_x86_64-userdebug is a GSI for the devices with:
# - x86 64 bits user space
# - 64 bits binder interface
# - system-as-root
# - VNDK enforcement
# - compatible property override enabled

# This is a build configuration for a full-featured build of the
# Open-Source part of the tree. It's geared toward a US-centric
# build quite specifically for the emulator, and might not be
# entirely appropriate to inherit from for on-device configurations.

#
# All components inherited here go to system image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)

# Enable mainline checking for excat this product name
ifeq (aosp_x86_64,$(TARGET_PRODUCT))
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed
endif

#
# All components inherited here go to system_ext image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

#
# All components inherited here go to vendor image
#
$(call inherit-product-if-exists, device/generic/goldfish/x86_64-vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulator_vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/board/generic_x86_64/device.mk)

#
# Special settings for GSI releasing
#
ifeq (aosp_x86_64,$(TARGET_PRODUCT))
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_release.mk)
endif

# Multidisplay stuff, cribbed from
# build/target/product/emulator_system.mk
#PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST := \
#    system/lib/libemulator_multidisplay_jni.so \
#    system/lib64/libemulator_multidisplay_jni.so \
#    system/priv-app/MultiDisplayProvider/MultiDisplayProvider.apk \
#
#PRODUCT_PACKAGES += MultiDisplayProvider
