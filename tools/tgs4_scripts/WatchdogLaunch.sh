#!/bin/bash

# Ensure all required dependencies exist.
# Right now, this is just rust-g.

# strict mode
set -euo pipefail

# +e: don't fail the whole script if it's not there
set +e
has_git="$(command -v git)"
has_cargo="$(command -v ~/.cargo/bin/cargo)"
has_sudo="$(command -v sudo)"
has_grep="$(command -v grep)"
set -e

# if cargo is not there, install rust
if ! [ -x "$has_cargo" ]; then
	echo "Installing Rust..."
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	. ~/.profile
fi

# install apt dependencies
echo "Installing apt dependencies..."
if ! [ -x "$has_sudo" ]; then
	dpkg --add-architecture i386
	apt-get update
	apt-get install -y git lib32z1 pkg-config libssl-dev:i386 libssl-dev
	rm -rf /var/lib/apt/lists/*
else
	sudo dpkg --add-architecture i386
	sudo apt-get update
	sudo apt-get install -y git lib32z1 pkg-config libssl-dev:i386 libssl-dev
	sudo rm -rf /var/lib/apt/lists/*
fi
