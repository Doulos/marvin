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

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config.ini:config.ini

$(call inherit-product, device/generic/car/common/car.mk)

#    device/generic/goldfish-opengl/system/hwc2/EmuHWC2.cpp
#    and
#    device/google/cuttlefish/guest/hals/hwcomposer/common/hwcomposer.cpp
#    // this guest property, hwservicemanager.external.displays,
#    // specifies multi-display info, with comma (,) as separator
#    // each display has the following info:
#    //   physicalId,width,height,dpi,flags
#    // serveral displays can be provided, e.g., following has 2 displays:
#    // setprop hwservicemanager.external.displays 1,1200,800,120,0,2,1200,800,120,0
#    Note: 'flags' is not used in Goldfish
PRODUCT_PRODUCT_PROPERTIES += \
    hwservicemanager.external.displays=1,1080,600,120,0

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

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

