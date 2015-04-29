# == Class: st2
#
#  Base class for st2 module. Used as top-level to set parameters via Hiera
#  This class does not need to be called directly
#
# === Parameters
#
#  [*version*]            - Version of StackStorm to install
#  [*revision*]           - Revision of StackStorm to install
#  [*mistral_git_branch*] - Tagged branch of Mistral to download/install
#  [*auth*]               - Flag to enable/disable auth (disabled by default)
#  [*api_url*]            - URL/Port combination for StackStorm API
#  [*web_url*]            - URL/Port combination for StackStorm WebUI
#
#  Variables can be set in Hiera and take advantage of automatic data bindings:
#
#  Example:
#    st2::version: 0.6.0
#    st2::revison: 11
#
class st2(
  $version            = '0.8.3',
  $revision           = undef,
  $mistral_git_branch = 'st2-0.8.1',
  $auth               = false,
  $api_url            = undef,
  $web_url            = undef,
) { }
