require 'rubygems'
require 'rack'
require 'socket'

# This is client app which makes your windows friendly
#
# On init it sends local IP to sever 
#
# API
# /?text=YOUR_TEXT_HERE&lang=en - text to speech


ip = Socket::getaddrinfo(Socket.gethostname, "echo",  Socket::AF_INET)[0][3]

puts "My IP #{ip}"
Dir.chdir File.dirname($0)

system %Q| wget.exe http://10.1.13.132:9292?ip=#{ip} |


Rack::Server.start :Port=> 9292, :app => lambda { |env|
  req = Rack::Request.new(env)
  text = req.params['text']
  lang = req.params['lang'] || 'en'

  if text  
     system %Q| wget.exe "http://translate.google.com/translate_tts?ie=UTF-8&tl=#{lang}&q=#{text}" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:12.0) Gecko/20100101 Firefox/12.0" -O play.mp3 |
     system %Q| madplay.exe play.mp3 |
  end
  text ||= "Hello from #{ip}"
  [200, {"Content-Type" => "text/plain"}, [text]]
}
