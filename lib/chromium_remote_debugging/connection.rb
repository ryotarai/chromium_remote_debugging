require 'faye/websocket'

module ChromiumRemoteDebugging
class Connection
  def initialize(ws_url)
    @ws = ::Faye::WebSocket::Client.new(ws_url)

    set_handers

    @request_id = 1
    @callbacks = {}
    @callbacks_to_notify = {}
    @enabled_domains = []
    @send_buffer = []

    @onopen_handler = nil
    @onclose_handler = nil
    @onmessage_handler = nil
  end

  def set_handers
    @ws.onopen = lambda do |event|
      handle_onopen event
    end
    @ws.onmessage = lambda do |event|
      handle_onmessage event
    end
    @ws.onclose = lambda do |event|
      handle_onclose event
    end
  end

  def onopen(&blk)
    @onopen_handler = blk
  end
  def onclose(&blk)
    @onclose_handler = blk
  end
  def onmessage(&blk)
    @onmessage_handler = blk
  end
  def onnotification(method, &blk)
    @callbacks_to_notify[method] = blk

    domain = parse_method(method)[:domain]
    enable_notification(domain) unless @enabled_domains.include?(domain)
  end

  def enable_notification(domain)
    send_command "#{domain}.enable", {} do |result|
      @enabled_domains << domain unless @enabled_domains.include?(domain)
    end
  end

  def parse_method(method)
    splited = method.split('.')
    raise "Invalid method name" unless splited.size == 2
    {domain: splited.first, command: splited.last}
  end


  def handle_onopen(event)
    @onopen_handler.call(event) if @onopen_handler
    @send_buffer.each do |content|
      # @logger.info "send from buffer"
      send content
    end
  end
  def handle_onclose(event)
    @onclose_handler.call(event) if @onclose_handler
  end
  def handle_onmessage(event)
    @onmessage_handler.call(event) if @onmessage_handler

    parsed = JSON.parse(event.data)

    if parsed.has_key?('id')
      # response for command
      callback = @callbacks[parsed['id']]
      if parsed['error']
        callback.call(parsed['error'])
      else
        callback.call(parsed['result'] || nil)
      end
    else
      # receive notification
      callback = @callbacks_to_notify[parsed['method']]
      callback.call(parsed['params']) if callback
    end
  end


  def send(content)
    if @ws.ready_state == ::Faye::WebSocket::API::ReadyStates::CONNECTING
      @send_buffer << content
      # @logger.info "added to buffer because the socket is now connecting"
      return
    end
    @ws.send content
  end
  def send_as_json(obj)
    send JSON.generate(obj)
  end
  def send_command(method, params, &callback)
    send_as_json("method" => method, "id" => @request_id, "params" => params)
    @callbacks[@request_id] = callback
    @request_id += 1
  end

end
end
