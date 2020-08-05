#!/bin/bash

# Copyright (C) 2020 Chris Simmonds, chris@2net.co.uk
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

# Change this to match the pem file for the server
SSH_CERT="android-N.pem"

# Change this to match the user and url of the server
REMOTE="ubuntu@ec2-xxxxxxxx.amazonaws.com"

# This is the $OUT directory on the server
OUT="aosp/out/target/product/marvin"

# SYSTEMIMGDIR is the place to sync the image files to. The paths below assume
# the Android SDK is installed in the default location
if grep -q Microsoft /proc/version; then
	# WSL
	# If the Linux user name != Windows user name, replace $USER with Windows user
	SYSTEMIMGDIR=/mnt/c/users/$USER/AppData/Local/Android/Sdk/system-images/marvin
	RSYNC_EXTRA="-A --no-perms"
else
	# Linux
	SYSTEMIMGDIR=$HOME/Android/Sdk/system-images/marvin
fi

mkdir -p $SYSTEMIMGDIR
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/kernel-ranchu "$SYSTEMIMGDIR/kernel-ranchu-64"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/system/build.prop "$SYSTEMIMGDIR/build.prop"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/advancedFeatures.ini "$SYSTEMIMGDIR/advancedFeatures.ini"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/encryptionkey.img  "$SYSTEMIMGDIR/encryptionkey.img"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/ramdisk.img  "$SYSTEMIMGDIR/ramdisk.img"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/system-qemu.img  "$SYSTEMIMGDIR/system.img"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/userdata.img  "$SYSTEMIMGDIR/userdata.img"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/vendor-qemu.img  "$SYSTEMIMGDIR/vendor.img"
rsync -av --progress $RSYNC_EXTRA -e "ssh -i $SSH_CERT" $REMOTE:$OUT/VerifiedBootParams.textproto "$SYSTEMIMGDIR/VerifiedBootParams.textproto"

