require 'spec_helper'

module RubySMB
module SMB1
module Field

RSpec.describe Leaf do
  describe '#new' do
    context 'no parameters given' do
      let(:leaf) { Leaf.new }
      it 'sets n_bytes to 0 (default)' do
        expect(leaf.n_bytes).to eql 0
      end

      it 'sets value to empty string (default)' do
        expect(leaf.value).to eql ''
      end
    end

    context 'parameters given' do
      let(:leaf) { Leaf.new n_bytes: 2, value: 'falls' }
      it 'sets n_bytes to 2' do
        expect(leaf.n_bytes).to eql 2
      end

      it 'sets "value" to "falls"' do
        expect(leaf.value).to eql 'falls'
      end
    end
  end
end

end
end
end
