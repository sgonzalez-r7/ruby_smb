require 'spec_helper'

module RubySMB
module SMB1
module Packet
RSpec.describe Field do
  describe '#n_bytes' do
    let(:field) { Field.new { |f| f.value = "of lavender" } }

    it 'returns the number of bytes of the attr:value' do
      expect(field.n_bytes).to eql 11
    end
  end

  context 'Field.new() - no args' do
    let(:field) { Field.new }

    describe '#name' do
      it 'returns the default name: nil' do
        expect(field.name).to eql ''
      end
    end

    describe '#n_bytes' do
      it 'returns the default n_bytes: nil' do
        expect(field.n_bytes).to eql 0
      end
    end

    describe '#type' do
      it 'returns the default type: nil' do
        expect(field.type).to eql nil
      end
    end

    describe '#value' do
      it 'returns the default value: nil' do
        expect(field.value).to eql ''
      end
    end
  end

  context 'Field.new { } - block given' do
    describe '#name=' do
      it 'sets attr:name' do
        field = Field.new { |f| f.name = 'of hemp' }
        expect(field.name).to eql 'of hemp'
      end
    end

    describe '#n_bytes=' do
      it 'sets attr:n_bytes' do
        field = Field.new { |f| f.n_bytes = 420 }
        expect(field.n_bytes).to eql 420
      end
    end

    describe '#type=' do
      it 'sets attr:type' do
        field = Field.new { |f| f.type = :uchar }
        expect(field.type).to eql :uchar
      end
    end

    describe '#value=' do
      it 'sets attr:value' do
        field = Field.new { |f| f.value = '$$$$' }
        expect(field.value).to eql '$$$$'
      end
    end
  end
end
end
end
end
