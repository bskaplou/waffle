require 'spec_helper'

describe Waffle::Encoders::Marshal do
  let(:message){{:data => 'message data', :occured_at => 'DateTime'}}
  describe '.encode' do
    specify do
      Waffle::Encoders::Marshal.encode(message).should == 
        "\x04\b{\a:\tdataI\"\x11message data\x06:\x06ET:\x0Foccured_atI\"\rDateTime\x06;\x06T"
    end
  end

  describe '.decode' do
    specify do
      Waffle::Encoders::Marshal.decode(
        "\x04\b{\a:\tdataI\"\x11message data\x06:\x06ET:\x0Foccured_atI\"\rDateTime\x06;\x06T"
      ).should == message
    end
  end
end