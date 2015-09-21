module RubySMB
module SMB1
module RubySMB_Field
class  Leaf_Field < Field
  attr_accessor :value
  attr_writer   :n_bytes

  def initialize(&block)
    # defaults
    @name         = ''
    @value        = ''
    @n_bytes      = n_bytes

    yield self if block_given?
  end

  def n_bytes
    value.bytesize
  end

  def n_bytes_spec
    @n_bytes_spec ||= 0
  end

  def n_bytes_spec=(n_bytes)
    @n_bytes_spec ||= n_bytes
  end

  def to_binary_s
    value + padding
  end

  def padding
    if (n_bytes_spec - n_bytes) > 0
      padding = "\x00" * (n_bytes_spec - n_bytes)
    else
      padding = ''
    end

    padding
  end
end
end
end
