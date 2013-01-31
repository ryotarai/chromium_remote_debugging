require 'spec_helper'

module ChromiumRemoteDebugging
describe Connection do
  let(:url) { "ws://localhost:9222/devtools/page/1_1" }
  let(:instance) { described_class.new(url)}
end
end

