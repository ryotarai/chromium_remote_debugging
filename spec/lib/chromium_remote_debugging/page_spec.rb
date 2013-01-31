require 'spec_helper'

module ChromiumRemoteDebugging
describe Page do
  let(:devtools_frontend_url) {"devtoolsFrontendUrl"}
  let(:favicon_url) {"faviconUrl"}
  let(:thumbnail_url) {"thumbnailUrl"}
  let(:title) {"title"}
  let(:url) {"url"}
  let(:web_socket_debugger_url) {"webSocketDebuggerUrl"}
  let(:opts) do
    {
      devtools_frontend_url: devtools_frontend_url,
      favicon_url: favicon_url,
      thumbnail_url: thumbnail_url,
      title: title,
      url: url,
      web_socket_debugger_url: web_socket_debugger_url,
    }
  end
  let(:instance) {described_class.new(opts)}
  describe "properties" do
    subject {instance}
    its(:devtools_frontend_url) { should == devtools_frontend_url }
    its(:favicon_url) { should == favicon_url }
    its(:thumbnail_url) { should == thumbnail_url }
    its(:title) { should == title }
    its(:url) { should == url }
    its(:web_socket_debugger_url) { should == web_socket_debugger_url }
  end
end
end

