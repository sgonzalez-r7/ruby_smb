require 'spec_helper'

module RubySMB
module SMB1
module SMB_Field
RSpec.describe Field do

  context 'attrs NOT specified during Field creation' do
    let(:field) { Field.new }

    describe '#name' do
      it 'returns the default name: nil' do
        expect(field.name).to be_nil
      end
    end
  end

  context 'attrs specified during Field creation' do
    describe '#name' do
      let(:field) { Field.new do |f|
                      f.name = :magnetic
                    end }

      it 'returns the specified :name' do
        expect(field.name).to eql :magnetic
      end
    end
  end

end
end
end
end
