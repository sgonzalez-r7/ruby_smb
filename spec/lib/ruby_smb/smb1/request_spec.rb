require 'spec_helper'

module RubySMB
module SMB1

RSpec.describe Request do
end

end
end


packet = Request.for(:SMB_COM_NEG, dialects: [])
