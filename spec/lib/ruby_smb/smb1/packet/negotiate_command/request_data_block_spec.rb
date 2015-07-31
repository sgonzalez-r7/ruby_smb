require 'spec_helper'

RSpec.describe RubySMB::SMB1::Packet::NegotiateCommand::RequestDataBlock do

  subject(:data_block) { described_class.new(2) }

  describe 'a dialect instance' do
    subject(:dialect) { data_block[0] }

    it { is_expected.to respond_to :buffer_format }
    it { is_expected.to respond_to :dialect_string }

    describe '#buffer_format' do
      it 'should be an 8-bit field per the SMB spec' do
        buffer_format_field = dialect.fields.detect { |f| f.name == :buffer_format }
        expect(buffer_format_field.length).to eq 8
      end
    end

    describe '#dialect_string' do
      it 'should be a 40-byte field' do
        dialect_string_field = dialect.fields.detect { |f| f.name == :dialect_string }
        expect(dialect_string_field.length).to eq 320
      end
    end
  end
end