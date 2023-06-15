# Author:      Raku (rakudayo@gmail.com)
#              Haraberu
# Source:      https://github.com/rakudayo/rmxp-plugin-system

class Tone
  def initialize(r, g, b, a = 0.0)
    self.red = r.to_f
    self.green = g.to_f
    self.blue = b.to_f
    self.gray = a.to_f
  end
  def set(r, g, b, a = 0.0)
    self.red = r.to_f
    self.green = g.to_f
    self.blue = b.to_f
    self.gray = a.to_f
  end
  def color
    Color.new(@red, @green, @blue, @gray)
  end
  def _dump(d = 0)
    [@red, @green, @blue, @gray].pack('d4')
  end
  def self._load(s)
    Tone.new(*s.unpack('d4'))
  end
  attr_reader(:red, :green, :blue, :gray)
  def red=(val)
    @red   = [[val.to_f, -255.0].max, 255.0].min
  end
  def green=(val)
    @green = [[val.to_f, -255.0].max, 255.0].min
  end
  def blue=(val)
    @blue  = [[val.to_f, -255.0].max, 255.0].min
  end
  def gray=(val)
    @gray  = [[val.to_f, 0.0].max, 255.0].min
  end
end
$PERMIT_CLASS.push Tone