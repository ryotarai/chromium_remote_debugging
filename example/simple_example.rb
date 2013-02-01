require 'chromium_remote_debugging'
require 'pp'

client = ChromiumRemoteDebugging::Client.new('localhost', 9222)
EM.run do
  client.pages.each do |page|
    pp page
    page.em_run do |socket|
      socket.onopen do |event|
        puts "onopen"
        p event
        socket.send_command("Page.navigate", "url" => "http://google.com")
      end
      socket.onclose do
        puts "onclose"
      end
      socket.onmessage do |event|
        puts "onclose"
        p message
      end
    end
  end
end
