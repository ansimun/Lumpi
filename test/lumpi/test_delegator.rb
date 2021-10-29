require 'minitest/autorun'
require 'lumpi'

class TestDelegator < MiniTest::Test
  def test_that_get_is_delegated
    delegator = Lumpi::HttpServer::Delegator.new

    delegator.get('/path/to/resource') do |request|
      request.path
    end

    response = delegator.delegate(Lumpi::HttpServer::Request.new("GET /Path/To/Resource HTTP/1.1\n"))

    assert_equal('/path/to/resource', response)
  end

  def test_raise_method_not_supported
    delegator = Lumpi::HttpServer::Delegator.new

    delegator.get('/') do |request|
    end

    assert_raises(Lumpi::HttpErrors::MethodNotSupportedError) { delegator.delegate(Lumpi::HttpServer::Request.new("POST / HTTP/1.1\n")) }
  end

  def test_raise_resource_not_found
    delegator = Lumpi::HttpServer::Delegator.new

    delegator.get('/path/to/resource/index.html') {|request| return request.path}

    assert_raises(Lumpi::HttpErrors::ResourceNotFoundError) { delegator.delegate(Lumpi::HttpServer::Request.new("GET /index.html HTTP/1.1\n")) }
  end
end