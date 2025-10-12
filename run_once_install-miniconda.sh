#!/bin/bash

set -e

# Only install if miniconda3 doesn't exist
if [ -d "$HOME/miniconda3" ]; then
    echo "Miniconda already installed at $HOME/miniconda3"
    exit 0
fi

echo "Installing Miniconda..."

# Create directory
mkdir -p ~/miniconda3

# Download Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

# Install Miniconda
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

# Clean up
rm ~/miniconda3/miniconda.sh

echo "Miniconda installed successfully!"

