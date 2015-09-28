module RubySMB
module SMB1
module Command
class  NegotiateRequest < RubySMB::SMB_Field::Composite_Field

  def initialize(dialects:[], params:{})
    super()

    add_field( RubySMB::SMB_Field::SMB_Header.new (
      protocol: "\xFFSMB",
       command: "\x72"
        status: "\x00"
      .
      .
      mid: "\x00"))


    add_field( RubySMB::SMB_Field::Leaf_Field.new do |f|
                 f.name         = :protocol
                 f.n_bytes_spec = 4
                 f.value        = header_params[protocol]
               end )

    add_field( RubySMB::SMB_Field::Leaf_Field.new do |f|
                 f.name         = :dialects
                 f.n_bytes_spec = 34
                 f.value        = "\x02NT LM 0.12\x00\x02SMB 2.002\x00\x02SMB 2.???\x00"
               end )



    add_field( RubySMB::SMB_Field::Leaf_Field.new do |f|
                 f.name         = :dialects
                 f.n_bytes_spec = 34
                 f.dialects = RubySMB::SMB_Field::Composite_Field.new do |d|
                     d.add_field(RubySMB::SMB_Field::Leaf_Field.new do |df|
                      df.name   = :d1
                      df.n_bytes_spec = 12
                      df.value  = "\x02NT LM 0.12\x00"
                     end)

                     d.add_field()



                 f.value        = "\x02NT LM 0.12\x00\x02SMB 2.002\x00\x02SMB 2.???\x00"
               end )


  end

  def build

  end

  def field(name)
    fields.select { |f| f.name == name }.first
  end

end
end
end
end
