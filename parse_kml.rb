#!/usr/bin/env ruby
require 'rubygems'
require 'active_support/core_ext'
require 'json'

# =========================================================================== #
# parse_kml.rb                                                                #
# ------------------                                                          #
#                                                                             #
# Script to generate list of dates and points from KML (XML) files            #
# Stores the list of dates and points in alex.rb                              #
# TODO: hardcoded names of files since we're just using 1 file right now      #
# Warning: this will take a while. The XML is huge.                           #
#                                                                             #
# Example Usage                                                               #
# -------------                                                               #
# bundle install                                                              #
# chmod 775 parse_kml.rb                                                      #
# ./parse_kml.rb                                                              #
#                                                                             #
# =========================================================================== #

xml = File.open('alex.xml').read
xml_data = Hash.from_xml(xml)

tracking_data = xml_data['kml']['Document']['Placemark']['Track']

# Create a list of timestamps and locations
check_ins = tracking_data['when'].zip(tracking_data['coord'])

# Write hash to file for further parsing
File.open('alex.rb', 'w+').write check_ins
