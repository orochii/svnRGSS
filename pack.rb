#!/usr/bin/env ruby
$LOAD_PATH << '.'
$LOAD_PATH << 'Scripts/PackerLib'

require 'config.rb'
require 'packlib.rb'

# Create Data directory if it doesn't exist.
ensure_folder(DATA_FOLDER)

# Get list of yaml files.
entries = get_files(YAML_FOLDER, "*.#{YAML_EXT}")

# Process each file, create an rxdata for each.
entries.each { |filename|
  yaml_to_data(YAML_FOLDER, DATA_FOLDER, filename, YAML_EXT)
}

puts "================="
puts "Process finished!"
%x[pause]