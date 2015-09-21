require 'spec_helper'

module RubySMB
module SMB1
module SMB_Field
RSpec.describe Composite_Field do

  describe 'Composite_Field' do
    composite = Composite_Field.new

    it 'is a kind of Field' do
      expect(composite.kind_of? Field).to eql true
    end
  end

  context 'attrs NOT specified during Field creation' do
    let(:composite) { Composite_Field.new }

    describe '#fields' do
      it 'returns :fields default: empty collection' do
        expect(composite.fields).to be_empty
      end
    end
  end

  context 'attrs specified during Field creation' do
    describe '#add_field' do
      let(:field_1)   { double('field_1') }
      let(:field_2)   { double('field_2') }
      let(:field_3)   { double('field_3') }
      let(:composite) { Composite_Field.new do |c|
                          c.add_field field_1
                          c.add_field field_2
                          c.add_field field_3
                        end }

      it 'adds a field' do
        expect(composite.fields).to eql [field_1, field_2, field_3]
      end
    end

    describe '#name=' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.name = :of_hemp
                         end }

      it 'sets attr:name' do
        expect(leaf_field.name).to eql :of_hemp
      end
    end

    describe '#n_bytes' do
      let(:field_1)   { instance_double('field_1', value: "\xFF234") }
      let(:field_2)   { instance_double('field_2', value: "\xFF2345") }
      let(:field_3)   { instance_double('field_3', value: "\xFF23456") }
      let(:composite) { Composite_Field.new do |c|
                          c.add_field field_1
                          c.add_field field_2
                          c.add_field field_3
                        end }

      it 'sums all nested field values' do
        expect(composite.n_bytes).to eql 15
      end
    end

    describe '#n_bytes_spec' do
      let(:field_1)   { instance_double('field_1', n_bytes_spec: 1) }
      let(:field_2)   { instance_double('field_2', n_bytes_spec: 2) }
      let(:field_3)   { instance_double('field_3', n_bytes_spec: 3) }
      let(:composite) { Composite_Field.new do |c|
                          c << field_1
                          c << field_2
                          c << field_3
                        end }

      it 'sums all nested field values' do
        expect(composite.n_bytes_spec).to eql 6
      end
    end

    describe '#to_binary_s' do
      let(:field_1)   { instance_double('field_1', value: "\xFF234") }
      let(:field_2)   { instance_double('field_2', value: "\xFF2345") }
      let(:field_3)   { instance_double('field_3', value: "\xFF23456") }
      let(:composite) { Composite_Field.new do |c|
                          c << field_1
                          c << field_2
                          c << field_3
                        end }

      it 'concatinates all nested field values' do
        expect(composite.to_binary_s).to eql "\xFF234\xFF2345\xFF23456"
      end
    end

    describe '#<<' do
      let(:field_1)   { double('field_1') }
      let(:field_2)   { double('field_2') }
      let(:field_3)   { double('field_3') }
      let(:composite) { Composite_Field.new do |c|
                          c << field_1
                          c << field_2
                          c << field_3
                        end }

      it 'adds a field to the composite' do
        expect(composite.fields).to eql [field_1, field_2, field_3]
      end
    end

  end
end
end
end
end
