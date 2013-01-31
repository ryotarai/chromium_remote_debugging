module ChromiumRemoteDebugging
class Page
  attr_reader :devtoolsFrontendUrl
  attr_reader :faviconUrl
  attr_reader :thumbnailUrl
  attr_reader :title
  attr_reader :url
  attr_reader :webSocketDebuggerUrl

  def initialize(opts)
    @devtoolsFrontendUrl  = opts[:devtoolsFrontendUrl]
    @faviconUrl           = opts[:faviconUrl]
    @thumbnailUrl         = opts[:thumbnailUrl]
    @title                = opts[:title]
    @url                  = opts[:url]
    @webSocketDebuggerUrl = opts[:webSocketDebuggerUrl]
  end
end
end
