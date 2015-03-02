# == Class: nodejs
#
# Full description of class nodejs here.
#
# === Parameters
#
# Document parameters here.
#
# [*node_url*]
#   The URL where Node.js will be downloaded.
#   Defaulted to http://nodejs.org/dist/latest
#
# [*node_filename*]
#   The filne name that will be downloaded.
#   Defaulted to node-v0.12.0-linux-x64.tar.gz
#
# [*download_dir*]
#   Where the file will be downloaded to.
#   Defaulted to /tmp/node
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'nodejs':
#    node_filename => 'node-v0.12.0-linux-x64.tar.gz',
#  }
#
# === Authors
#
# Author Travis N. Thomsen <tthomsen@binaryvoid.com>
#
# === Copyright
#
# Copyright 2015 Travis N. Thomsen, unless otherwise noted.
#
class nodejs (
  $node_url      = $nodejs::params::node_url,
  $node_filename = $nodejs::params::node_filename,
  $download_dir  = $nodejs::params::download_dir,
) inherits nodejs::params {

  $downlaod_url = "$node_url/$node_filename"

  Exec {
		path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
	}

  exec { 'create-download-dir':
    command => "mkdir -p $download_dir",
    creates => $download_dir,
  } ->

	exec { 'download-nodejs':
		command => "wget $downlaod_url",
		cwd => $download_dir,
	} ->

	exec { 'install-nodejs':
		command => './configure && make && make install',
		cwd => $download_dir,
    timeout => 1800,
	}
}
