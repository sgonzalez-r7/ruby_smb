module RubySMB
module SMB1
module Field
class  Composite < Base
  attr_accessor :n_bytes, :sub_fields

  def child_initialize(options)
    @n_bytes =    options[:n_bytes] ||= 0
    @sub_fields = []
  end

  def add(field)
    sub_fields << field
  end

  def build
    binary_string = ""
    sub_fields.each do |sub_field|
      binary_string += sub_field.build
    end
    binary_string
  end

end
end
end
end
