require 'spec_helper'

module ChromiumRemoteDebugging
describe Client do
  let(:page_info_json) do
    <<-EOS
[ {
   "devtoolsFrontendUrl": "/devtools/devtools.html?ws=localhost:9222/devtools/page/15_1",
   "faviconUrl": "http://www.bing.com/s/wlflag.ico",
   "thumbnailUrl": "/thumb/http://www.bing.com/",
   "title": "Bing",
   "url": "http://www.bing.com/",
   "webSocketDebuggerUrl": "ws://localhost:9222/devtools/page/15_1"
}, {
   "devtoolsFrontendUrl": "/devtools/devtools.html?ws=localhost:9222/devtools/page/13_1",
   "faviconUrl": "http://www.google.co.jp/favicon.ico",
   "thumbnailUrl": "/thumb/http://www.google.co.jp/",
   "title": "Google",
   "url": "http://www.google.co.jp/",
   "webSocketDebuggerUrl": "ws://localhost:9222/devtools/page/13_1"
} ]
EOS
    end
  let(:host) { "localhost" }
  let(:port) { 9222 }
  let(:instance) { described_class.new(host, port)}
  before do
    Net::HTTP.stub(start: stub(body: page_info_json))
  end
  describe '#pages' do
    subject {instance.pages}
    it "returns an array" do
      should be_an_instance_of Array
    end
    it "returns an array of Page" do
      subject.each{|page| page.should be_an_instance_of Page}
    end
  end
  describe '#pages' do
    subject {instance.pages_info}
    it "returns pages information" do
      should == JSON.parse(page_info_json)
    end
  end
end
end

