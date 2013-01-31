# ChromiumRemoteDebugging

**This gem is under development and doesn't work yet.**

A library for ruby to manipulate [Chromium Remote Debugging API](https://developers.google.com/chrome-developer-tools/docs/debugger-protocol)

## Objective
```
client = ChromiumRemoteDebugging::Client.new('localhost', 9222)
EM.run do
  Client.pages.each do |page|
    page.em_run do |socket|
      socket.onopen do |handshake|
        puts "onopen"
      end
      socket.onclose
        puts "onclose"
      end
      socket.onnotification "Network.dataReceived" do
        puts "received Network.dataReceived notification"
      end
      socket.send_command "Network.getResponseBody", {request_id: 1} do |response|
        puts response
      end
      socket.get_har do |har|
        puts har
      end
    end
  end
end
```
<!--
## Installation

Add this line to your application's Gemfile:

    gem 'chromium_remote_debugging'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chromium_remote_debugging

-->

## Usage
```bash
# on Mac OSX
$ "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --user-data-dir=/tmp/google_chrome --remote-debugging-port=9222
```

```ruby
[1] pry(main)> require 'chromium_remote_debugging'
=> true
[2] pry(main)> client = ChromiumRemoteDebugging::Client.new('localhost', 9222)

=> #<ChromiumRemoteDebugging::Client:0x007febab5b3b48
 @host="localhost",
 @port=9222>
[3] pry(main)> client.pages
=> [#<ChromiumRemoteDebugging::Page:0x007febab10c590
  @devtoolsFrontendUrl=
   "/devtools/devtools.html?ws=localhost:9222/devtools/page/4_1",
  @faviconUrl="http://localhost:9222/favicon.ico",
  @thumbnailUrl="/thumb/http://localhost:9222/json",
  @title="localhost:9222/json",
  @url="http://localhost:9222/json",
  @webSocketDebuggerUrl="ws://localhost:9222/devtools/page/4_1">,
 #<ChromiumRemoteDebugging::Page:0x007febab10c3d8
  @devtoolsFrontendUrl=
   "/devtools/devtools.html?ws=localhost:9222/devtools/page/15_1",
  @faviconUrl="http://www.bing.com/s/wlflag.ico",
  @thumbnailUrl="/thumb/http://www.bing.com/",
  @title="Bing",
  @url="http://www.bing.com/",
  @webSocketDebuggerUrl="ws://localhost:9222/devtools/page/15_1">,
 #<ChromiumRemoteDebugging::Page:0x007febab10c270
  @devtoolsFrontendUrl=
   "/devtools/devtools.html?ws=localhost:9222/devtools/page/13_1",
  @faviconUrl="http://www.google.co.jp/favicon.ico",
  @thumbnailUrl="/thumb/http://www.google.co.jp/",
  @title="Google",
  @url="http://www.google.co.jp/",
  @webSocketDebuggerUrl="ws://localhost:9222/devtools/page/13_1">]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
