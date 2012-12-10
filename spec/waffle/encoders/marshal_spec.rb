require 'spec_helper'

describe Waffle::Encoders::Marshal do
  let(:message){{:data => 'message data', :occured_at => 'DateTime'}}
  let(:marshalized_message){Marshal.dump(message)}
  describe '.encode' do
    specify do
      Waffle::Encoders::Marshal.encode(message).should == marshalized_message
    end
  end

  describe '.decode' do
    specify do
      Waffle::Encoders::Marshal.decode(marshalized_message).should == message
    end
  end
end