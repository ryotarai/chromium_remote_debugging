require 'faye/websocket'
require 'forwardable'

module ChromiumRemoteDebugging
class Connection
  extend Forwardable

  # def_delegators :@ws, :onopen=
  # def_delegators :@ws, :onclose=
  # def_delegators :@ws, :onmessage=
  def_delegators :@ws, :send

  def initialize(ws_url)
    @ws = ::Faye::WebSocket::Client.new(ws_url)
    @request_id = 1
  end

  def onopen(&blk)
    @ws.onopen = blk
  end
  def onclose(&blk)
    @ws.onclose = blk
  end
  def onmessage(&blk)
    @ws.onmessage = blk
  end

  def send_as_json(obj)
    @ws.send JSON.generate(obj)
  end

  def send_command(method, params)
    send_as_json("method" => method, "id" => @request_id, "params" => params)
    @request_id += 1
  end

end
end
