require 'net/http'
require 'json'

module ChromiumRemoteDebugging
class Client
  def initialize(host, port)
    @host = host
    @port = port
  end

  def pages
    pages_info.map do |page_info|
      Page.new(
        devtoolsFrontendUrl: page_info["devtoolsFrontendUrl"],
        faviconUrl: page_info["faviconUrl"],
        thumbnailUrl: page_info["thumbnailUrl"],
        title: page_info["title"],
        url: page_info["url"],
        webSocketDebuggerUrl: page_info["webSocketDebuggerUrl"],
      )
    end
  end

  def pages_info
    res = Net::HTTP.start(@host, @port) {|http|
      http.get('/json')
    }
    JSON.parse(res.body)
  end
end
end

