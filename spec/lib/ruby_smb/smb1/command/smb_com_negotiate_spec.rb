require 'spec_helper'

module RubySMB
module SMB1
module Command
RSpec.describe SMB_COM_NEGOTIATE do
  def normalize(string)
    string.bytes.pack('C*')
  end

  let(:packet_default_spec) do
    spec = {
             protocol: "\xFFSMB",
              command: "r",
               status: "\x00\x00\x00\x00",
                flags: "\x00",
               flags2: "\x00\x00",
             pid_high: "\x00\x00",
    security_features: "\x00\x00\x00\x00\x00\x00\x00\x00",
             reserved: "\x00\x00",
                  tid: "\x00\x00",
              pid_low: "\x00\x00",
                  uid: "\x00\x00",
                  mid: "\x00\x00",

           word_count: "\x00",
                words: "",

           byte_count: "\xA0\x00",
        buffer_format: "\x02",
       dialect_string: "NT LM 0.12",
     }.values.reduce(:+).bytes.pack('C*')

     normalize(spec)
  end

  context 'actual packet size is larger than the allocated size' do
    let(:smb_com_negotiate) { SMB_COM_NEGOTIATE.new(params: {dialect_string: { n_bytes:10, value: "NT LM 0.12 123" }}) }

    describe '#validate' do
      it 'returns false' do
        smb_com_negotiate.build
        expect{smb_com_negotiate.validate_actual_gt_allocated}.to \
          raise_error('Actual packet size is larger than the allocated size')      end
    end

    describe '#validate_actual_gt_allocated' do
      it('tested in #validate') { }
    end
  end

  #defaults
  context 'params NOT specified during SMB_COM_NEGOTIATE creation' do
    let(:smb_com_negotiate) { SMB_COM_NEGOTIATE.new }

    # WHAT IT DOES (use actual objects as fixtures
    #               to guarantee self-consistency)
      #build
    describe '#build' do
      it 'sets attr:packet to its binary_string representation' do
        smb_com_negotiate.build
        expect(smb_com_negotiate.packet).to eql packet_default_spec
                                                # top let(:packet_default_spec)
      end
    end

    #default_params (what is the impact of exposing default_params?)

    #field
    #  BEHAVIOR & STRUCTURE

    # SMB_Header
    describe '#field returns a field by name' do
      it 'includes the :protocol field' do
        field  = smb_com_negotiate.field(:protocol)
        expect(field[:name]).to eql :protocol
      end

      it 'includes the :command field' do
        field  = smb_com_negotiate.field(:command)
        expect(field[:name]).to eql :command
      end

      it 'includes the :status field' do
        field  = smb_com_negotiate.field(:status)
        expect(field[:name]).to eql :status
      end

      it 'includes the :flags field' do
        field  = smb_com_negotiate.field(:flags)
        expect(field[:name]).to eql :flags
      end

      it 'includes the :flags2 field' do
        field  = smb_com_negotiate.field(:flags2)
        expect(field[:name]).to eql :flags2
      end

      it 'includes the :pid_high field' do
        field  = smb_com_negotiate.field(:pid_high)
        expect(field[:name]).to eql :pid_high
      end

      it 'includes the :security_features field' do
        field  = smb_com_negotiate.field(:security_features)
        expect(field[:name]).to eql :security_features
      end

      it 'includes the :reserved field' do
        field  = smb_com_negotiate.field(:reserved)
        expect(field[:name]).to eql :reserved
      end

      it 'includes the :tid field' do
        field  = smb_com_negotiate.field(:tid)
        expect(field[:name]).to eql :tid
      end

      it 'includes the :pid_low field' do
        field  = smb_com_negotiate.field(:pid_low)
        expect(field[:name]).to eql :pid_low
      end

      it 'includes the :uid field' do
        field  = smb_com_negotiate.field(:uid)
        expect(field[:name]).to eql :uid
      end

      it 'includes the :mid field' do
        field  = smb_com_negotiate.field(:mid)
        expect(field[:name]).to eql :mid
      end

      # SMB_Parameters
      it 'includes the :word_count field' do
        field  = smb_com_negotiate.field(:word_count)
        expect(field[:name]).to eql :word_count
      end

      it 'includes the :words field' do
        field  = smb_com_negotiate.field(:words)
        expect(field[:name]).to eql :words
      end

      # SMB_Data
      it 'includes the :byte_count field' do
        field  = smb_com_negotiate.field(:byte_count)
        expect(field[:name]).to eql :byte_count
      end

      it 'includes the :buffer_format field' do
        field  = smb_com_negotiate.field(:buffer_format)
        expect(field[:name]).to eql :buffer_format
      end

      it 'includes the :dialect_string field' do
        field  = smb_com_negotiate.field(:dialect_string)
        expect(field[:name]).to eql :dialect_string
      end
    end

    describe '#fields' do
      it('is tested in #field') { }
    end

    #n_bytes_actual
    describe '#n_bytes_actual' do
      it 'sums the number of bytes of all the fields\' :value' do
        expect(smb_com_negotiate.n_bytes_actual).to \
          eql packet_default_spec.bytes.count # based on the packet_default_spec above
      end
    end

    #n_bytes_allocated
    describe '#n_bytes_allocated' do
      it 'sums the number of bytes of all the fields\' :n_byte' do
        expect(smb_com_negotiate.n_bytes_allocated).to \
          eql packet_default_spec.bytes.count # based on the packet_default_spec above
      end
    end

    #normalize - not tested for now.  may belong in a mixin

    #packet
    describe '#packet' do
      it 'returns a built packet' do
        expect(smb_com_negotiate.packet).to eql packet_default_spec
                                                # top let(:packet_default_spec)
      end
    end

    #params
    describe '#params' do
      let(:params) { smb_com_negotiate.params }

      #smb_header
      #protocol
      it 'includes the protocol n_bytes default' do
        n_bytes = params[:protocol][:n_bytes]
        default = 4

        expect(n_bytes).to eql default
       end

      it 'includes the protocol value default' do
        value   = normalize(params[:protocol][:value])
        default = normalize("\xFFSMB")

        expect(value).to eql default
      end

      #command
      it 'includes the command n_bytes default' do
        n_bytes = params[:command][:n_bytes]
        default = 1

        expect(n_bytes).to eql default
      end

      it 'includes the command value default' do
        value   = normalize(params[:command][:value])
        default = normalize("\x72")

        expect(value).to eql default
      end

      #status
      it 'includes the status n_bytes default' do
        n_bytes = params[:status][:n_bytes]
        default = 4

        expect(n_bytes).to eql default
      end

      it 'includes the status value default' do
        value   = normalize(params[:status][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #flags
      it 'includes the flags n_bytes default' do
        n_bytes = params[:flags][:n_bytes]
        default = 1

        expect(n_bytes).to eql default
      end

      it 'includes the flags value default' do
        value   = normalize(params[:flags][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #flags2
      it 'includes the flags2 n_bytes default' do
        n_bytes = params[:flags2][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the flags2 value default' do
        value   = normalize(params[:flags2][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #pid_high
      it 'includes the pid_high n_bytes default' do
        n_bytes = params[:pid_high][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the pid_high value default' do
        value   = normalize(params[:pid_high][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #security_features
      it 'includes the security_features n_bytes default' do
        n_bytes = params[:security_features][:n_bytes]
        default = 8

        expect(n_bytes).to eql default
      end

      it 'includes the security_features value default' do
        value   = normalize(params[:security_features][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #reserved
      it 'includes the reserved n_bytes default' do
        n_bytes = params[:reserved][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the reserved value default' do
        value   = normalize(params[:reserved][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #tid
      it 'includes the tid n_bytes default' do
        n_bytes = params[:tid][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the tid value default' do
        value   = normalize(params[:tid][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #pid_low
      it 'includes the pid_low n_bytes default' do
        n_bytes = params[:pid_low][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the pid_low value default' do
        value   = normalize(params[:pid_low][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #uid
      it 'includes the uid n_bytes default' do
        n_bytes = params[:uid][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the uid value default' do
        value   = normalize(params[:uid][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #mid
      it 'includes the mid n_bytes default' do
        n_bytes = params[:mid][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the mid value default' do
        value   = normalize(params[:mid][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #smb_paratemers
      #word_count
      it 'includes the word_count n_bytes default' do
        n_bytes = params[:word_count][:n_bytes]
        default = 1

        expect(n_bytes).to eql default
      end

      it 'includes the word_count value default' do
        value   = normalize(params[:word_count][:value])
        default = normalize("\x00")

        expect(value).to eql default
      end

      #words
      it 'includes the words n_bytes default' do
        n_bytes = params[:words][:n_bytes]
        default = 0

        expect(n_bytes).to eql default
      end

      it 'includes the words value default' do
        value   = normalize(params[:words][:value])
        default = normalize("")

        expect(value).to eql default
      end

      #smb_data
      #byte_count
      it 'includes the byte_count n_bytes default' do
        n_bytes = params[:byte_count][:n_bytes]
        default = 2

        expect(n_bytes).to eql default
      end

      it 'includes the byte_count value default' do
        value   = normalize(params[:byte_count][:value])
        default = normalize("\xA0")

        expect(value).to eql default
      end

      #buffer_format
      it 'includes the buffer_format n_bytes default' do
        n_bytes = params[:buffer_format][:n_bytes]
        default = 1

        expect(n_bytes).to eql default
      end

      it 'includes the buffer_format value default' do
        value   = normalize(params[:buffer_format][:value])
        default = normalize("\x02")

        expect(value).to eql default
      end

      #dialect_string
      it 'includes the dialect_string n_bytes default' do
        n_bytes = params[:dialect_string][:n_bytes]
        default = 10

        expect(n_bytes).to eql default
      end

      it 'includes the dialect_string value default' do
        value   = normalize(params[:dialect_string][:value])
        default = normalize("NT LM 0.12")

        expect(value).to eql default
      end

    end

    #structure
    describe '#structure' do
      it('is tested in #fields') { }
    end

    #to_binary_s
    describe '#to_binary_s' do
      it('is tested in #build') { }
    end
  end
end
end
end
end
