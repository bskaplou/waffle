require 'spec_helper'

class Waffle::Transports::Redis
  def initialize
  end
end

describe Waffle::Transports::Redis do
  subject{Waffle::Transports::Redis.new}

  let(:redis){mock(:redis)}

  before do
    subject.stub(:db => redis)
  end

  describe '.publish' do
    before{redis.should_receive(:publish).with('events', '"message"')}
    specify{subject.publish('events', 'message')}
  end

  describe '.subscribe' do
    before{redis.should_receive(:subscribe).with('events').and_yield('event', '{"data":"message"}')}
    specify{subject.subscribe('events'){}}
  end
end
