#!/usr/bin/env ruby
require 'rubygems'
require 'active_support/core_ext'
require 'json'
require 'date'

# =========================================================================== #
# generate_json.rb                                                            #
# ------------------                                                          #
#                                                                             #
# Script to generate list of points for a given date range                    #
# Takes the name of a file containing a list of checkins,                     #
# and a start and end date.                                                   #
#                                                                             #
# Example Usage                                                               #
# -------------                                                               #
# bundle install                                                              #
# chmod 775 generate_json.rb                                                  #
# bundle exec ./generate_json.rb points.rb 2014-03-15 2014-03-18              #
#                                                                             #
# =========================================================================== #

# Arguments
src_file   = ARGV[0] # points.rb
start_date = ARGV[1] # YYYY-MM-DD
end_date   = ARGV[2] # YYYY-MM-DD

# Load the list of dates and locations
data = File.open(src_file).read
# Not technically json, still works
points = JSON.parse(data)

points_for_range = points.select { |item|
  date = Date.parse(item[0]).strftime("%F")

  date >= start_date && date <= end_date
}

# Write JSON response object
response = points_for_range.map { |item|
  {
    date: item[0],
    location: item[1].split(" ")
  }
}

json_response = JSON.generate response

File.open("#{start_date}-#{end_date}.json", 'w+').write json_response
