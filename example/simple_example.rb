require 'chromium_remote_debugging'
require 'pp'

client = ChromiumRemoteDebugging::Client.new('localhost', 9222)
EM.run do
  client.pages.each do |page|
    page.em_run do |socket|
      socket.onopen do |event|
        puts "onopen"
        socket.send_command("Page.navigate", "url" => "http://google.com") do |result|
          p result
        end
      end
      socket.onclose do
        puts "onclose"
      end
      socket.onnotification "Network.responseReceived" do |params|
        p params
      end
    end
  end
end
