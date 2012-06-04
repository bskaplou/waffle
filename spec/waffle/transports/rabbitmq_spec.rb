require 'spec_helper'

class Waffle::Transports::Rabbitmq
  def initialize
  end
end

describe Waffle::Transports::Rabbitmq do
  subject{Waffle::Transports::Rabbitmq.new}

  let(:exchange){mock(:exchange)}

  before do
    subject.stub(:exchange => exchange)
  end

  describe '.publish' do
    before{exchange.should_receive(:publish)}
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
