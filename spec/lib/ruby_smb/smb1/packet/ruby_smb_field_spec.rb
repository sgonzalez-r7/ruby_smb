require 'spec_helper'

module RubySMB
module SMB1
module Packet
RSpec.describe RubySMB_Field do
  describe '#n_bytes' do
    let(:field) { RubySMB_Field.new { |f| f.value = "1234" } }

    it 'returns the number of bytes of attr:value' do
      expect(field.n_bytes).to eql 4
    end
  end

  describe '#n_bytes=' do
    it 'updates attr:value padding'
    it 'validates allocated v. actual'
  end

  context 'RubySMB_Field.new() - no args' do
    let(:field) { RubySMB_Field.new }

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

  context 'RubySMB_Field.new { } - block given' do
    describe '#name=' do
      it 'sets attr:name' do
        field = RubySMB_Field.new { |f| f.name = 'of hemp' }
        expect(field.name).to eql 'of hemp'
      end
    end

    describe '#type=' do
      it 'sets attr:type' do
        field = RubySMB_Field.new { |f| f.type = :uchar }
        expect(field.type).to eql :uchar
      end
    end

    describe '#value=' do
      it 'sets attr:value' do
        field = RubySMB_Field.new { |f| f.value = '$$$$' }
        expect(field.value).to eql '$$$$'
      end
    end
  end
end
end
end
end
