module RubySMB
module SMB1
module Field
class  Leaf < Base
  attr_accessor :n_bytes, :value

  def child_initialize(options)
    @n_bytes = options[:n_bytes] ||= 0
    @value   = options[:value]   ||= ''
  end

  def build
  end

end
end
end
end
