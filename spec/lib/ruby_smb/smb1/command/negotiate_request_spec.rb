require 'spec_helper'

module RubySMB
module SMB1
module Command
RSpec.describe NegotiateRequest do
  context 'SMB Specification - Packet Structure & Defaults' do
    let(:command) { NegotiateRequest.new }

    describe '#field(:protocol)' do
      let(:field) { command.field(:protocol) }

      it 'has name :protocol' do
        expect(field.name).to eql :protocol
      end

      it 'has n_bytes_spec = 4' do
        expect(field.n_bytes_spec).to eql 4
      end

      it 'has default value = "\\xFFSMB"' do
        expect(field.value).to eql "\xFFSMB"
      end
    end


    describe '#field(:dialects)' do
      let(:field) { command.field(:dialects) }

      it 'has name :dialects' do
        expect(field.name).to eql :dialects
      end

      it 'has n_bytes_spec = 34' do
        expect(field.n_bytes_spec).to eql 34
      end

      it 'has default value = dialect string' do
        expect(field.value).to eql "\x02NT LM 0.12\x00\x02SMB 2.002\x00\x02SMB 2.???\x00"
      end
    end

  end



  it 'default values'

  it 'dialects attr'
  it '#add_dialect'
end
end
end
end
