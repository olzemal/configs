#!/bin/sh

set -eu

dconf dump / > ./dconf-dump.txt
