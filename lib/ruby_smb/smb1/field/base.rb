module RubySMB
module SMB1
module Field
class  Base
  def initialize(options={})
    child_initialize(options)
  end

  def build
    raise StandardError,
          'Method build not implemented for abstract class'
  end

  def child_initialize(options={})
    nil
  end
end
end
end
end
