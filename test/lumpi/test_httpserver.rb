require 'minitest/autorun'
require 'lumpi'

class TestHttpServer < Minitest::Test
  def setup
    @request = "GET / HTTP/1.1"

    @socket = MiniTest::Mock.new

    @tcpserver = MiniTest::Mock.new
    @tcpserver.expect(:accept, @socket)
  end

  def test_that_server_accepts_request
    @socket.expect(:eof?, false)
    @socket.expect(:puts, nil, [String])
    @socket.expect(:readpartial, @request) do |arg|
      arg.kind_of?(Integer) && arg > 0
    end

    server = Lumpi::HttpServer::Server.new(@tcpserver)
    server.listen

    @socket.verify
    @tcpserver.verify
  end

  def test_that_empty_request_is_ignored
    @socket.expect(:eof?, true)

    server = Lumpi::HttpServer::Server.new(@tcpserver)
    server.listen

    @socket.verify
  end
end