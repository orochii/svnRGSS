# Author:      Raku (rakudayo@gmail.com)
#              Haraberu
# Source:      https://github.com/rakudayo/rmxp-plugin-system

class Rect
  attr_accessor :x 
  attr_accessor :y 
  attr_accessor :width 
  attr_accessor :height 
  def initialize(x, y, width, height) 
    @x=x
    @y=y
    @width=width
    @height=height
  end
  def set(x, y, width, height) 
    @x=x
    @y=y
    @width=width
    @height=height
  end
  def _dump(d = 0)
    [@x, @y, @width, @height].pack('i4')
  end
  def self._load(s)
    Rect.new(*s.unpack('i4'))
  end
end