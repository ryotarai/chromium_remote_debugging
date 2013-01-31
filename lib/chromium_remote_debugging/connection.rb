require 'faye/websocket'

module ChromiumRemoteDebugging
class Connection
  def initialize(ws_url)
    @ws = ::Faye::WebSocket::Client.new(ws_url)
  end
end
end
