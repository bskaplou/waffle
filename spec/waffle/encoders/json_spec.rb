require 'spec_helper'

describe Waffle::Encoders::Json do
  let(:message){{"data" => 'message data', "occured_at" => 'DateTime'}}
  describe '.encode' do
    specify{Waffle::Encoders::Json.encode(message).should == '{"data":"message data","occured_at":"DateTime"}'}
  end

  describe '.decode' do
    specify{Waffle::Encoders::Json.decode('{"data":"message data","occured_at":"DateTime"}').should == message}
  end
end
