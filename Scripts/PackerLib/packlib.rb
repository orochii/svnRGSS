require 'utils.rb'
secure_require 'yaml'
#-------------------------------------------------------------------------------------
# RGSS3 Module, courtesy of bluepixelmike
# https://github.com/bluepixelmike/rpg-maker-rgss
# Some parts of the code modified by using Rakudayo's code (see below link).
#-------------------------------------------------------------------------------------
require_relative "lib/rpg_maker_rgss3.rb"

#-------------------------------------------------------------------------------------
# Taken from https://github.com/rakudayo/rmxp-plugin-system
# Barely modified just out of my own pet peeves.
#-------------------------------------------------------------------------------------
class Hash
    # Replacing the to_yaml function so it'll serializes hashes sorted (by their keys)
    def to_yaml( opts = {} )
        YAML::quick_emit( object_id, opts ) { |out|
            out.map( taguri, to_yaml_style ) { |map|
                sort.each {|k, v| map.add( k, v ) }
            }
        }
    end
end

#-------------------------------------------------------------------------------------
# Common library
#-------------------------------------------------------------------------------------
def ensure_folder(name)
    if File.directory?(name)
        puts "Found #{name} folder."
    else
        Dir.mkdir(name)
        puts "#{name} folder not found. Creating an empty one."
    end
end

def get_files(path, pattern)
    if File.directory?(path)
        return Dir.glob("#{path}/#{pattern}")
    end
    return []
end

# Packing
def yaml_to_data(srcfolder, dstfolder, filename, ext="yaml")
    return if (filename["Scripts"] != nil)
    data = nil
    # Open YAML file
    begin
        File.open( filename, "r+" ) do |yamlfile|
            if YAML::respond_to?(:load_file)
                data = YAML::load_file(yamlfile, 
                permitted_classes: $PERMIT_CLASS)
            else
                data = YAML::load(yamlfile)
            end
        end
    rescue
        puts "Failed when opening file #{filename.red}!"
        puts $!.message
        return
    end
    # Save as data file
    start = srcfolder.size
    len = filename.size - srcfolder.size - ext.size - 1
    dataName = dstfolder + filename[start, len]
    puts "Packing #{filename.green} into #{dataName.green}"
    File.open( dataName, "w+" ) do |datafile|
        Marshal.dump( data['root'], datafile)
    end
end

# Unpacking
def data_to_yaml(srcfolder, dstfolder, filename, ext="yaml")
    return if (filename["Scripts"] != nil)
    data = nil
    # Open data file
    begin
        File.open( filename, "r+" ) do |datafile|
            data = Marshal.load(datafile)
        end
    rescue
        puts "Failed when opening file #{filename}!"
        return
    end
    # Fix conficts on System
    if filename["System"] != nil
        data.magic_number = MAGIC_NUMBER unless MAGIC_NUMBER == -1
        data.edit_map_id = DEFAULT_STARTUP_MAP unless DEFAULT_STARTUP_MAP == -1
    end
    # Save as YAML file
    start = srcfolder.size
    len = filename.size - srcfolder.size
    yamlFile = dstfolder + "#{filename[start, len]}.#{ext}";
    puts "Unpacking #{filename.green} as #{yamlFile.green}"
    File.open(yamlFile, File::WRONLY|File::CREAT|File::TRUNC|File::BINARY) do |outfile|
        YAML::dump({'root' => data}, outfile )
    end
end