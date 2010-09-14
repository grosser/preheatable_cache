require 'rubygems'

$LOAD_PATH << 'lib'
require 'active_support/all' # very messy to get working with 2.3 otherwise
require 'action_controller'
require 'preheatable_cache'

module Rails
  require 'action_pack'
  VERSION = ActionPack::VERSION
end

describe PreheatableCache do
  let(:cache){ ActiveSupport::Cache::MemCacheStore.new }
  let(:store){ cache.instance_variable_get '@data' }

  describe :read do
    before do
      store.set('xxx', nil)
    end

    it "reads nil as usual" do
      cache.read('xxx').should == nil
    end

    it "reads as usual" do
      store.set('xxx', 1)
      cache.read('xxx').should == 1
    end

    it "uses get when reading" do
      cache.write('xxx', 1)
      store.should_receive(:get).and_return 2
      cache.read('xxx').should == 2
    end

    it "does not use get when it is preheated" do
      cache.write('xxx', 1)
      cache.preheat ['xxx']
      store.should_not_receive(:get)
      cache.read('xxx')
    end

    it "does not use get when it is preheated with nil" do
      cache.preheat ['xxx']
      store.should_not_receive(:get)
      cache.read('xxx').should == nil
    end

    it "uses get when preheated cache was cleared" do
      cache.write('xxx', 1)
      cache.preheat ['xxx']
      cache.clear_preheatable_cache
      store.should_receive(:get).and_return 2
      cache.read('xxx').should == 2
    end
  end

  it "has a VERSION" do
    PreheatableCache::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end