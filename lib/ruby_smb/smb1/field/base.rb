module RubySMB
module SMB1
module Field
class  Base
  def initialize(params={})
    initialize_field(options)
    initialize_block(params)
  end

  def build
    raise StandardError,
          'Method build not implemented for abstract class'
  end

  def initialize_field(options={})
    nil
  end
end
end
end
end
