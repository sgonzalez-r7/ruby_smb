require 'spec_helper'

module RubySMB
class  Field
RSpec.describe Composite do
  describe 'INHERITANCE' do
    let(:composite) { Composite.new }
    describe '#kind_of?' do
      it 'is a Field' do
        expect(composite.kind_of? Field).to eql true
      end
    end
  end

  describe 'READERS' do

      let(:leaf_1)   {  instance_double('leaf_1', binary_s: "\xFFleaf1",
                                                      name: :leaf_1) }
      let(:leaf_2)   {  instance_double('leaf_2', binary_s: "\xFFleaf2",
                                                      name: :leaf_2) }

      let(:comp_1) { instance_double('comp_1', name: :double_2,
                                               children: [leaf_1, leaf_2] ) }

      let(:leaf_3)   {  instance_double('leaf_3', binary_s: "\xFFleaf3",
                                                      name: :leaf_3) }
      let(:leaf_4)   {  instance_double('leaf_4', binary_s: "\xFFleaf4",
                                                      name: :leaf_4) }

      let(:comp_2) { instance_double('comp_2', name: :double_2,
                                               children: [leaf_3, leaf_4] ) }



      let(:composite) { Composite.new(children:  [comp_1, comp_2],
                                          name:  :abstract,
                                       n_bytes:  5) }
    describe '#binary_s' do
      it 'recurses (in order) the tree to build the binary string' do
        expect(composite.binary_s).to \
          eql "\xFFleaf1\xFFleaf2\xFFleaf3\xFFleaf4"
      end
    end

    describe '#descendants' do
      it 'recurses (in order) the tree to find all the descendants' do
        expect(composite.descendants).to \
          eql [leaf_1, leaf_2, leaf_3, leaf_4]
      end
    end

    describe '#n_bytes_value' do
      it 'recurses (in order) the tree to add up descendants\' b_bytes' do
        expect(composite.n_bytes_value).to eql 24
      end
    end
  end
end
end
end
