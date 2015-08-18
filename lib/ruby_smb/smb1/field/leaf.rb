module RubySMB
module SMB1
module Field
class  Leaf < Base
  attr_accessor :value

  def initialize(n_bytes: 0, value: '')
    super(n_bytes: n_bytes)
    @value = value
  end

  def build
  end

end
end
end
end
