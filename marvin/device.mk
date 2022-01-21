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

# This is based on device/google/cuttlefish/vsoc_x86/phone/aosp_cf.mk


# If there are two PRODUCT_COPY_FILES rules for the same target file, the FIRST
# ONE WINS. In the section below, we want to override some files that are copied
# in emulator_vendor.mk so this MUST come before we inherit that file
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/init.cutf_cvm.rc:vendor/etc/init/hw/init.cutf_cvm.rc

$(call inherit-product, device/google/cuttlefish/vsoc_x86/phone/aosp_cf.mk)

