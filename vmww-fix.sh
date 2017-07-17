#!/bin/bash
#Create for VMWare Workstation with Fedora 26 

# Set Variables
VMNET_SOURCE_DIR=/usr/lib/vmware/modules/source/vmnet-only
VMMON_SOURCE_DIR=/usr/lib/vmware/modules/source/vmmon-only
SOURCE_DIR=/usr/lib/vmware/modules/source
MISC_DIR=/lib/modules/$(uname -r)/misc

# Remove Old Traces
sudo rm -rf $VMNET_SOURCE_DIR
sudo rm -rf $VMMON_SOURCE_DIR

# Extract Directories
sudo tar xvf $SOURCE_DIR/vmnet.tar --directory=$SOURCE_DIR/
sudo tar xvf $SOURCE_DIR/vmmon.tar --directory=$SOURCE_DIR/

# Make From source
sudo make --directory=$VMNET_SOURCE_DIR
sudo make --directory=$VMMON_SOURCE_DIR

# Create misc directory for running kernel
sudo mkdir -p $MISC_DIR

# Copy files to misc directory
sudo cp -v $VMNET_SOURCE_DIR/vmnet.ko $MISC_DIR
sudo cp -v $VMMON_SOURCE_DIR/vmmon.ko $MISC_DIR

# Run Depmod -av
sudo depmod -av

# Echo restart
echo "This fix requires a restart."