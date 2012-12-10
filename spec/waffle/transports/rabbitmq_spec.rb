require 'spec_helper'

#class Waffle::Transports::Rabbitmq
#end

describe Waffle::Transports::Rabbitmq do
  subject{Waffle::Transports::Rabbitmq.new(config)}

  let(:exchange){mock(:exchange)}
  let(:config){Waffle::Config::Node.new({})}

  before do
    subject.stub(:exchange => exchange)
  end

  describe '.publish' do
    before{exchange.should_receive(:publish).with('"message"', :key => 'events')}
    specify{subject.publish('events', 'message')}
  end

  describe '.subscribe' do
    let(:queue){mock(:queue, :bind => nil)}

    before do
      subject.stub(:queue => queue)
      queue.should_receive(:subscribe).and_yield({
        :payload => '{"data":"message"}',
        :delivery_details => {:routing_key => 'event'}
      })
    end

    specify{subject.subscribe('events'){}}
  end
end
