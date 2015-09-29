module RubySMB
module SMB_Field
class  Field
  def initialize(args={})
    @name = args.fetch(:name, nil)
    initialize_field(args)
  end

  def initialize_field
    nil
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end
end
end
end
