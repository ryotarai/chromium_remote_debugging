require 'chromium_remote_debugging'
require 'pp'

client = ChromiumRemoteDebugging::Client.new('localhost', 9222)
EM.run do
  client.pages.each do |page|
    page.em_run do |conn|
      conn.onopen do |event|
        puts "onopen"
        conn.navigate(url: "http://google.com") do |result|
#          p result
          conn.evaluate(expression: "alert('hello');") do |result|
            p result
          end
        end
      end
      conn.onclose do
        puts "onclose"
      end
      conn.on_response_recieved do |params|
#        p params
      end
    end
  end
end
