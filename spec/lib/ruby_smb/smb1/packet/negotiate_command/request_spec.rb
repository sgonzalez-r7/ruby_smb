RSpec.describe RubySMB::SMB1::Packet::NegotiateCommand::Request do

  subject(:negotiate_request) { described_class.new }

  it_behaves_like 'smb1_packet'

end