$PERMIT_CLASS = []

# Built-in functions
require_relative 'functions'

# Built-in classes
require_relative 'bitmap'
require_relative 'color'
require_relative 'font'
require_relative 'plane'
require_relative 'rect'
require_relative 'sprite'
require_relative 'table'
require_relative 'tilemap'
require_relative 'tone'
require_relative 'viewport'
require_relative 'window'
require_relative 'rgss_error'
require_relative 'rgss_reset'

# Built-in modules
require_relative 'audio'
require_relative 'graphics'
require_relative 'input'

if $RGSS_VER==nil || $RGSS_VER > 1
    # RPG VX Ace data structures
    require_relative 'rpg3'
else
    require_relative 'rpg1'
end