SCRIPTS_FILENAMES = ["Data/Scripts.rxdata","Data/Scripts.rvdata","Data/Scripts.rvdata2"]
USE_SCRIPT_IDX = true

require 'zlib'

# =============================================================================================================================================================
# Utility tools
# =============================================================================================================================================================
def error(message)
	puts message
	%x[pause]
end

def save_file(name,contents)
	file = File.open(name,"w")
	file.print(contents)
	file.close
end

def get_script_filename
	SCRIPTS_FILENAMES.each {|fn|
		return fn if FileTest.exist?(fn)
	}
	return nil
end

# =============================================================================================================================================================
# Main
# =============================================================================================================================================================
def run
	# Get scripts filename
	_scriptFilename = get_script_filename
	if _scriptFilename==nil
		error("ERROR: Can't locate script file.\n")
		return
	else
		puts "Found script file: #{_scriptFilename}"
	end
	
	# Read scripts file
	file = File.open(_scriptFilename, "rb")
	scripts = Marshal.load(file)
	file.close
	# Ensure scripts are valid.
	if scripts.size < 1
		error("ERROR: Invalid script data.\n")
		return
	end
	if scripts[0][1]=="entrypoint"
		error("WARNING: Already processed, exiting.")
		return
	end
	
	# Make sure RPG folder exists
	Dir.mkdir("Scripts/RPG") unless File.directory?("Scripts/RPG")
	# Build contents for RPG.rb
	_rpgRB = "module RPG\n"

	# Process scripts, save as files
	scripts.each_with_index {|s,i|
		# num(?), name, contents(zlibed)
		_prefix = USE_SCRIPT_IDX ? sprintf("%04d-",i) : ""
		_name = "#{_prefix}#{s[1]}.rb"
		_newFile = "Scripts/RPG/#{_name}"
		# Write new file
		print "\nWriting #{s[0]} : #{s[1]}\n to #{_newFile}\n"
		s[2] = Zlib::Inflate.inflate(s[2])
		s[2] = s[2].gsub("\r\n") {
			"\n"
		}
		save_file(_newFile,s[2])
		# Add to RPG.rb
		_rpgRB += "\trequire \"#{_name}\"\n"
	}
	_rpgRB += "end"
	# Save RPG.rb
	save_file("Scripts/RPG.rb",_rpgRB)
	
	# Inject entrypoint.rb
	print "Injecting entry point to project to work with external scripts...\n"
	_entrypoint = File.read("Scripts/entrypoint.rb")
	_entrypointData = Zlib::Deflate.deflate(_entrypoint)
	newScripts = [[1,"entrypoint",_entrypointData]]
	file = File.open(_scriptFilename,"wb")
	Marshal.dump(newScripts, file)
	file.close

	print "Process has been finished successfully!\n"
	%x[pause]
end

run