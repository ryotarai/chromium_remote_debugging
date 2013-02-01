require 'em-websocket'

class DebuggingMockServer
  class << self
    def start(opts)
      self.new(opts).start
    end
  end

  attr_reader :messages

  def initialize(opts)
    @port = opts[:port]
    @messages = []
  end

  def start
    EM::WebSocket.run(:host => "0.0.0.0", :port => @port) do |ws|
      ws.onopen do |handshake|
        @handshake = handshake
      end

      ws.onclose do
        @ws = nil
        @handshake = nil
      end

      ws.onmessage do |msg|
        messages << msg
      end
    end
  end
end
