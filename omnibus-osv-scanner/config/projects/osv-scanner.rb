#
# Copyright 2025 InfraHouse Inc.
#
# All Rights Reserved.
#

name "osv-scanner"
maintainer "InfraHouse Inc."
homepage "https://github.com/infrahouse/osv-scanner"

# Defaults to C:/osv-scanner on Windows
# and /opt/osv-scanner on all other platforms
install_dir "#{default_root}/#{name}"

build_version '2.0.0'
build_iteration 1

# Creates required build directories
dependency "preparation"
# osv-scanner dependencies/components
dependency "osv-scanner"

scripts_dir = '/usr/local/bin'
extra_package_file "#{scripts_dir}/osv-scanner"

exclude "**/.git"
exclude "**/bundler/git"
