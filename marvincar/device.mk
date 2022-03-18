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

# This is based on device/google/cuttlefish/vsoc_x86/auto/device.mk

$(call inherit-product, device/google/cuttlefish/vsoc_x86/auto/device.mk)
#    // Configure external displays
#    // each display has the following info:
#    //   physicalId,width,height,dpi,flags
#    // serveral displays can be provided, e.g., following has 2 displays:
#    // setprop hwservicemanager.external.displays 1,1200,800,120,0,2,1200,800,120,0
#    Note: 'flags' is not used in Goldfish
PRODUCT_PRODUCT_PROPERTIES += \
    hwservicemanager.external.displays=1,1080,600,120,0,2,1200,800,120,0

# Add overlay that modifies config.xml to create occupant zones and maps external displays 
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

