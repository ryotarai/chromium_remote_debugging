require 'spec_helper'

module ChromiumRemoteDebugging
describe Connection do
  include EventedSpec::SpecHelper

  let(:wait) {0.2}
  let(:port) {9999}
  let(:url) { "ws://localhost:#{port}/devtools/page/4_1" }
  let(:instance) { described_class.new(url)}
  let(:server) {DebuggingMockServer.new(port: port)}
  describe '#onopen' do
    it "yields with Event object" do
      open_event = nil
      em do
        server.start
        instance.onopen {|event| open_event = event}
        done wait
      end
      open_event.should be_an_instance_of Faye::WebSocket::Event
    end
  end
  describe '#send' do
    let(:content) {"content"}
    it "sends text to server" do
      em do
        server.start
        instance.send content
        done wait
      end
      server.messages.last.should == content
    end
  end
  describe '#send_as_json' do
    let(:content) {{"this" => "content"}}
    it "sends a message to #send" do
      em do
        instance.should_receive(:send).with('{"this":"content"}')
        instance.send_as_json content
        done
      end
    end
  end
  describe '#send_command' do
    let(:method) {"method"}
    let(:params) {{"param1" => "value1"}}
    it "sends a message to #send_as_json" do
      em do
        instance.should_receive(:send_as_json)
          .with({"method" => method, "id" => 1, "params" => params})
        instance.send_command method, params
        done
      end
    end
    it "receives a response to callback"
  end
end
end

