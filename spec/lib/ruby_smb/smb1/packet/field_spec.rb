require 'spec_helper'

module RubySMB
module SMB1
module Packet

RSpec.describe Field do
  describe '#build' do
    it 'raises an error if #build is called on Field' do
      field = Field.new
      expect{field.build}.to \
        raise_error StandardError,
                    'Method build not implemented for abstract class'
    end
  end
end

end
end
end
