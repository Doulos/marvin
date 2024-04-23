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

# This PRODUCT_COPY_FILES must come before we inherit the aosp_cf.mk below.

PRODUCT_COPY_FILES += \
		      $(LOCAL_PATH)/init.cutf_cvm.rc:vendor/etc/init/hw/init.cutf_cvm.rc


# Include the Phone profile for Cuttlefish x86_64.

$(call inherit-product, device/google/cuttlefish/vsoc_x86_64/phone/aosp_cf.mk)


# Add all other customization for marvin here ...


