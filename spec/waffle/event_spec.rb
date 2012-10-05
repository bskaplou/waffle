require 'spec_helper'

describe Waffle::Event do
  describe '.occured' do
    let(:flow){'event name'}
    let(:now){Time.now}
    let(:options){{:event_name => flow, :queue => :default}}
    let(:transport){double(:transport)}
    
    before do
      Time.stub(:now => now)
      Waffle.should_receive(:queue).with(:default).and_return(transport)
      transport.should_receive(:publish).with(flow, message)
    end
    
    context do
      let(:message){{"key1" => "value1", "key2" => "value2", "occured_at" => now}}
      specify{Waffle::Event.occured(message, {:event_name => flow})}
    end
    
    context do
      let(:message){{"body" => "message data", "occured_at" => now}}
      specify{Waffle::Event.occured('message data', {:event_name => flow})}
    end
  end
end
