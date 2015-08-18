module RubySMB
module SMB1
module Field
class  Leaf < Base
  attr_accessor :n_bytes, :value

  def initialize_field(params)
    @n_bytes = params[:n_bytes] ||= 0
    @value   = params[:value]   ||= ''
  end

  def build
  end

end
end
end
end
