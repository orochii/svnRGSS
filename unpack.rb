#!/usr/bin/env ruby
$LOAD_PATH << '.'
$LOAD_PATH << 'Scripts/PackerLib'

require 'config.rb'
require 'packlib.rb'

# Create Data directory if it doesn't exist.
ensure_folder(YAML_FOLDER)

# Get list of data files.
entries = get_files(DATA_FOLDER, "*.{rxdata,rvdata,rvdata2}")

# Process each file, create a YAML.
entries.each { |filename|
  data_to_yaml(DATA_FOLDER, YAML_FOLDER, filename, YAML_EXT)
}

puts "================="
puts "Process finished!"
%x[pause]