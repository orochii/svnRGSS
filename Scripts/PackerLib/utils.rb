# Check
def check_rgssver
    if $RGSS_VER != nil && $RGSS_VER < 1
        puts "Preconfigured $RGSS_VER = #{$RGSS_VER}".green
        return
    end
    $RGSS_VER = 3
    entries = Dir.glob("*.r*proj*")
    if entries.size != 0
        puts "Found project files:".yellow
        entries.each {|e|
            puts e
        }
        puts "--------------------".yellow
        entries.each {|fname|
            fname.sub(".rxproj") { $RGSS_VER = 1 }
            fname.sub(".rvproj") { $RGSS_VER = 2 }
            fname.sub(".rvproj2") { $RGSS_VER = 3 }
        }
    end
    puts "Auto RGSS version: = #{$RGSS_VER}".green
end
# I made this dumb so yeah.
def secure_require(lib)
    begin
        require lib
    rescue
        puts "#{lib} not found!".red + " Attempting to install dependency..."
        %x[gem install #{lib}]
        begin
            require lib
        rescue
            puts "Failed to load #{lib}, aborting.".red
            sleep(1)
            exit
        end
    end
end

#-------------------------------------------------------------------------------------
# Text coloring - For spicy color output!
# Taken from https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
#-------------------------------------------------------------------------------------
class String
    def colorize(color_code)
        "\e[#{color_code}m#{self}\e[0m"
    end

    def red
        colorize(31)
    end

    def green
        colorize(32)
    end

    def yellow
        colorize(33)
    end

    def blue
        colorize(34)
    end

    def pink
        colorize(35)
    end

    def light_blue
        colorize(36)
    end
end