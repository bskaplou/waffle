require 'spec_helper'

#class Waffle::Transports::Redis
#end

describe Waffle::Transports::Redis do
  subject{Waffle::Transports::Redis.new(config)}

  let(:config){Waffle::Config::Node.new({})}
  let(:redis){mock(:redis)}
  let(:subscription){mock(:subscription)}

  before do
    subject.stub(:db => redis)
  end

  describe '.publish' do
    before{redis.should_receive(:publish).with('events', '"message"')}
    specify{subject.publish('events', 'message')}
  end

  describe '.subscribe' do
    before do
      redis.should_receive(:subscribe).with('events').and_yield(subscription)
      subscription.should_receive(:message).and_yield('event', '{"data":"message"}')
    end
    specify{subject.subscribe('events'){}}
  end
end
