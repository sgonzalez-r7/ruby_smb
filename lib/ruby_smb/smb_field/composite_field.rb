module RubySMB
module SMB_Field
class  Composite_Field < Field
  def initialize_field(args={})
    @fields = args.fetch(:fields, [])
  end

  def add_field(field)
    @fields << field
  end

  def n_bytes
    fields.map{ |f| f.value }.reduce(:+).bytesize
  end

  def n_bytes_spec
    fields.map{ |f| f.n_bytes_spec }.reduce(:+)
  end

  def to_binary_s
    fields.map{ |f| f.value }.reduce(:+)
  end

  def <<(field)
    @fields << field
  end

end
end
end
