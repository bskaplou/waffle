require 'spec_helper'

describe Waffle::Event do
  describe '.occured' do
    let(:flow){'event'}
    let(:now){Time.now}
    
    before do
      Time.stub(:now => now)
      Waffle.should_receive(:publish).with(flow, message)
    end
    
    context do
      let(:message){{"key1" => "value1", "key2" => "value2", "occured_at" => now}}
      specify{Waffle::Event.occured(flow, {'key1' => 'value1', 'key2' => 'value2'})}
    end
    
    context do
      let(:message){{"body" => "message data", "occured_at" => now}}
      specify{Waffle::Event.occured(flow, 'message data')}
    end
  end
end
