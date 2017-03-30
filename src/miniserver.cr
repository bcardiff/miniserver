require "http"

# Handle Ctrl+C and kill signal.
# Needed for hosting this process in a docker
# as the entry point command
Signal::INT.trap { puts "Caught Ctrl+C..."; exit }
Signal::TERM.trap { puts "Caught kill..."; exit }

port = (ENV["PORT"]? || "80").to_i
server = HTTP::Server.new "0.0.0.0", port, [
  HTTP::ErrorHandler.new,
  HTTP::LogHandler.new,
  HTTP::StaticFileHandler.new(ENV["WWW"]? || "/www"),
]

puts "Listening on http://0.0.0.0:#{port}"
server.listen
