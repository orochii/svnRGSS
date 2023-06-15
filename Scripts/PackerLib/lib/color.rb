# Author:      Raku (rakudayo@gmail.com)
#              Haraberu
# Source:      https://github.com/rakudayo/rmxp-plugin-system

class Color
  def initialize(r, g, b, a = 255.0)
    self.red = r.to_f
    self.green = g.to_f
    self.blue = b.to_f
    self.alpha = a.to_f
  end
  def set(r, g, b, a = 255.0)
    self.red = r.to_f
    self.green = g.to_f
    self.blue = b.to_f
    self.alpha = a.to_f
  end
  attr_reader(:red, :green, :blue, :alpha)
  def red=(val)
    @red   = [[val.to_f, 0.0].max, 255.0].min
  end
  def green=(val)
    @green = [[val.to_f, 0.0].max, 255.0].min
  end
  def blue=(val)
    @blue  = [[val.to_f, 0.0].max, 255.0].min
  end
  def alpha=(val)
    @alpha = [[val.to_f, 0.0].max, 255.0].min
  end
  def color
    Color.new(@red, @green, @blue, @alpha)
  end
  def _dump(d = 0)
    [@red, @green, @blue, @alpha].pack('d4')
  end
  def self._load(s)
    Color.new(*s.unpack('d4'))
  end
end
$PERMIT_CLASS.push Color