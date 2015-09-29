module RubySMB
module SMB_Field
class  Leaf_Field < Field
  def initialize_field(args={})
    @n_bytes_allocated = args.fetch(:n_bytes_allocated, 0)
    @value             = args.fetch(:value, '')
  end

  def n_bytes
    value.bytesize
  end

  def n_bytes=(n)
    n_bytes = n
  end

  def n_bytes_allocated
    @n_bytes_allocated
  end

  def n_bytes_allocated=(n)
    @n_bytes_allocated = n
  end

  def padding
    if (n_bytes_allocated - n_bytes) > 0
      padding = "\x00" * (n_bytes_allocated - n_bytes)
    else
      padding = ''
    end

    padding
  end

  def to_binary_s
    value + padding
  end

  def value
    @value
  end

  def value=(value)
    @value = value
  end
end
end
end
