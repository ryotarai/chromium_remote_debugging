require 'spec_helper'

module ChromiumRemoteDebugging
describe Page do
  let(:devtoolsFrontendUrl) {"devtoolsFrontendUrl"}
  let(:faviconUrl) {"faviconUrl"}
  let(:thumbnailUrl) {"thumbnailUrl"}
  let(:title) {"title"}
  let(:url) {"url"}
  let(:webSocketDebuggerUrl) {"webSocketDebuggerUrl"}
  let(:opts) do
    {
      devtoolsFrontendUrl: devtoolsFrontendUrl,
      faviconUrl: faviconUrl,
      thumbnailUrl: thumbnailUrl,
      title: title,
      url: url,
      webSocketDebuggerUrl: webSocketDebuggerUrl,
    }
  end
  let(:instance) {described_class.new(opts)}
  describe "properties" do
    subject {instance}
    its(:devtoolsFrontendUrl) { should == devtoolsFrontendUrl }
    its(:faviconUrl) { should == faviconUrl }
    its(:thumbnailUrl) { should == thumbnailUrl }
    its(:title) { should == title }
    its(:url) { should == url }
    its(:webSocketDebuggerUrl) { should == webSocketDebuggerUrl }
  end
end
end

