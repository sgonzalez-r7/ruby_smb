require 'spec_helper'

module RubySMB
module SMB1
module Field

RSpec.describe Base do
  describe '#build' do
    it 'raises an error if #build is called on Base' do
      field = Base.new
      expect{field.build}.to \
        raise_error StandardError,
                    'Method build not implemented for abstract class'
    end
  end

  describe '#child_initialize' do
    it 'returns nil' do
      field = Base.new
      expect(field.child_initialize).to be_nil
    end
  end

end

end
end
end
