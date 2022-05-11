#!/bin/sh
#

ruby --version

gem uninstall json --version '> 1.8.3'
gem list json

ruby test_pretty_generate.rb

gem install json --version '2.1.0'
gem list json

ruby test_pretty_generate.rb
