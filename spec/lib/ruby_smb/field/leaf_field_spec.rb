require 'spec_helper'

module RubySMB
module SMB_Field
RSpec.describe Leaf_Field do

  describe 'INHERITANCE' do
    let(:leaf_field) { Leaf_Field.new }
    describe '#kind_of?' do
      it 'is a Field' do
        expect(leaf_field.kind_of? Field).to eql true
      end
    end
  end

  describe 'CONSTRUCTION' do
    context '#new() DEFAULTS' do
      let(:leaf_field) { Leaf_Field.new }

      it 'sets n_bytes_allocated' do
        expect(leaf_field.n_bytes_allocated).to eql 0
      end

      it 'sets value to an empty string' do
        expect(leaf_field.value).to eql ''
      end
    end

    context '#new(args)' do
      let(:leaf_field) { Leaf_Field.new(name: :of_glory,
                           n_bytes_allocated: 2,
                                       value: "\x02HOOrah\x00") }
      it 'sets name' do
        expect(leaf_field.name).to eql :of_glory
      end

      it 'sets n_bytes_allocated' do
        expect(leaf_field.n_bytes_allocated).to eql 2
      end

      it 'sets value' do
        expect(leaf_field.value).to eql "\x02HOOrah\x00"
      end
    end
  end

  describe 'WRITERS' do
    describe '#n_bytes=' do
      it 'sets n_bytes'
      it 'updates value'
    end

    describe '#value=' do
      it 'sets value'
      it 'updates n_bytes'
    end
  end


  describe 'READERS' do
    describe '#binary_s' do
      context 'allocated > value' do
        let(:leaf_field) { Leaf_Field.new(n_bytes_allocated: 8,
                                                      value: "\x02YOLO\x00") }
        it 'adds NULL padding'
      end

      context 'allocated = value' do
        let(:leaf_field) { Leaf_Field.new(n_bytes_allocated: 6,
                                                      value: "\x02YOLO\x00") }
        it 'does NOT add NULL padding'
      end

      context 'allocated < value' do
         let(:leaf_field) { Leaf_Field.new(n_bytes_allocated: 4,
                                                      value: "\x02YOLO\x00") }

         it 'truncates the value'
      end
    end
  end




end
end
end
