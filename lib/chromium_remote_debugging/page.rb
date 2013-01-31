module ChromiumRemoteDebugging
class Page
  attr_reader :devtools_frontend_url
  attr_reader :favicon_url
  attr_reader :thumbnail_url
  attr_reader :title
  attr_reader :url
  attr_reader :web_socket_debugger_url

  def initialize(opts)
    @devtools_frontend_url   = opts[:devtools_frontend_url]
    @favicon_url             = opts[:favicon_url]
    @thumbnail_url           = opts[:thumbnail_url]
    @title                   = opts[:title]
    @url                     = opts[:url]
    @web_socket_debugger_url = opts[:web_socket_debugger_url]
  end

  def em_run
    connection = Connection.new(@web_socket_debugger_url)
    yield connection
  end
end
end
