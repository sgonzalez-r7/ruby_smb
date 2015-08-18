module RubySMB
module SMB1
module Field
class  Composite < Base
  attr_accessor :sub_fields

  def initialize(n_bytes: 0)
    super(n_bytes: n_bytes)
    @sub_fields = []
  end

  def add(field)
    sub_fields << field
  end

  def build
    binary_string = ''
    sub_fields.each do |sub_field|
      binary_string += sub_field.build
    end
    binary_string
  end

end
end
end
end
