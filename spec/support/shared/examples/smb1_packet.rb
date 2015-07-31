RSpec.shared_examples 'smb1_packet' do

  it { is_expected.to respond_to :smb_header }
  it { is_expected.to respond_to :smb_parameters }
  it { is_expected.to respond_to :smb_data }

end
