#!/bin/bash

# confirm that you want to run this script
read -p "Are you sure you want to run this? (y/n) " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi
