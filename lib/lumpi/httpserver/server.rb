module Lumpi
  module HttpServer
    class Server
      attr_reader :tcpserver, :socket, :delegator

      def initialize(tcpserver, options = {})
        @tcpserver = tcpserver
        @socket = nil
        @delegator = Delegator.new
      end

      def listen
        @socket = @tcpserver.accept
        
        return if @socket.eof?

        request = @socket.readpartial(1024)

        @socket.puts "Http/1.1 200"
      end
    end
  end
end