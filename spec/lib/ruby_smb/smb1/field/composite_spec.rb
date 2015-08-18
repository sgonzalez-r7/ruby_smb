require 'spec_helper'

module RubySMB
module SMB1
module Field

RSpec.describe Composite do
  describe '#new' do
    it 'sets sub_fields to empty array' do
      composite = Composite.new
      expect(composite.sub_fields).to eql []
    end
  end

  describe '#add' do
    it 'adds an an element to sub_fields' do
      composite = Composite.new
      composite.add 'field'
      expect(composite.sub_fields.first).to eql 'field'
    end
  end

end

end
end
end
