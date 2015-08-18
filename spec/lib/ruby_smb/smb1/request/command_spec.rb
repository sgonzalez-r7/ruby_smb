require 'spec_helper'

module RubySMB
module SMB1
module Request

RSpec.describe Command do

  describe '#child_initialize' do
    it 'returns nil' do
      command = Command.new
      expect(command.child_initialize).to be_nil
    end
  end

end

end
end
end
