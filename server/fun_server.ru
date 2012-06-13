require 'rack'

# This is simple rack app for storing ips from clients
# 
# Run server with command:
#
# $ rackup fun_server.ru 
#
# API:
#
# /?ip=127.0.0.1 - register new IP
# /?clean=true   - clean all data
# 
run lambda{|env|
 req = Rack::Request.new(env)
 ip = req.params['ip']
 open('ips', 'a'){|f|  f.puts ip } if ip
 open('ips', 'w'){} if req.params['clean']
 [200, {"Content-Type" =>"text/plain"}, File.open('ips', 'r') ]
}
