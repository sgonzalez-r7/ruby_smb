require 'spec_helper'

module RubySMB
module SMB1
module SMB_Field
RSpec.describe Leaf_Field do

  describe 'Leaf_Field' do
    leaf_field = Leaf_Field.new

    it 'is a kind of Field' do
      expect(leaf_field.kind_of? Field).to eql true
    end
  end

  context 'Leaf_Field.new() - no args' do
    let(:leaf_field) { Leaf_Field.new }

    # attr
    describe '#name' do
      it 'returns the default name: empty string' do
        expect(leaf_field.name).to eql ''
      end
    end

    # attr
    describe '#n_bytes' do
      it 'calculates :n_bytes from padded default value: empty string' do
        expect(leaf_field.n_bytes).to eql 0
      end
    end

    # attr
    describe '#n_bytes_spec' do
      it 'returns the default n_bytes_spec: 0' do
        expect(leaf_field.n_bytes).to eql 0
      end
    end

    # attr
    describe '#value' do
      it 'returns default value: empty string' do
        expect(leaf_field.value).to eql ''
      end
    end

    # behavior
    describe '#to_binary_s' do
      it 'calculates binary string from padded default value: empty string' do
        expect(leaf_field.to_binary_s).to eql ''
      end
    end
  end

  context 'Leaf_Field.new { } - block given' do
    describe '#name=' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.name = :of_hemp
                         end }

      it 'sets attr:name' do
        expect(leaf_field.name).to eql :of_hemp
      end
    end

    describe '#n_bytes' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.value = "1234"
                         end }

      it 'returns the number of bytes of attr:value' do
        expect(leaf_field.n_bytes).to eql 4
      end
    end

    describe '#n_bytes_spec' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.n_bytes_spec = 2
                         end }

      it 'returns the number of bytes of attr:value' do
        expect(leaf_field.n_bytes_spec).to eql 2
      end
    end

    describe '#to_binary_s' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.n_bytes_spec = 8
                           f.value        = "\x02Foo\x00"
                         end }

      it 'renders :value to a padded binary string' do
        expect(leaf_field.to_binary_s).to eql "\x02Foo\x00\x00\x00\x00"
      end
    end

    describe '#padding' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.n_bytes_spec = 8
                           f.value        = "\x02Foo\x00"
                         end }

      it 'string of p null bytes, where p is n_bytes_spec - n_bytes' do
        expect(leaf_field.padding).to eql "\x00\x00\x00"
      end
    end

    describe '#value=' do
      let(:leaf_field) { Leaf_Field.new do |f|
                           f.value = "\x02Foo\x00"
                         end }

      it 'sets attr:value' do
        expect(leaf_field.value).to eql "\x02Foo\x00"
      end
    end

  end
end
end
end
end
