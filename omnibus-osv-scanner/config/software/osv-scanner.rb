#
# Copyright 2025 InfraHouse Inc.
#
# All Rights Reserved.
#


# These options are required for all software definitions

name "osv-scanner"
default_version "2.0.0"

version("2.0.0")  { source sha256: "b60c273474aecad1158cfe1e9828f3841483701ba0fe3560517a45b2db16e84c" }

source url: "https://github.com/google/osv-scanner/releases/download/v#{version}/osv-scanner_linux_amd64"

license 'License :: Other/Proprietary License'
skip_transitive_dependency_licensing true
scripts_dir = '/usr/local/bin'

build do
  # Setup a default environment from Omnibus - you should use this Omnibus
  # helper everywhere. It will become the default in the future.
  env = with_standard_compiler_flags(with_embedded_path)

  copy "#{relative_path}/osv-scanner_linux_amd64", "#{install_dir}/embedded/bin/osv-scanner"
  command "chmod +x #{install_dir}/embedded/bin/osv-scanner"
  link "#{install_dir}/embedded/bin/osv-scanner", "#{scripts_dir}/osv-scanner"
end
