require 'minitest/autorun'
require 'lumpi'

class TestHttpRequest < MiniTest::Test
    def test_that_method_is_parsed
        request = Lumpi::HttpServer::Request.new("GET /resources/grzl?foo=bar&fooid=22 HTTP/1.1\n" +
            "Host: localhost:80\n\n")
        assert_equal('GET', request.method)
    end

    def test_that_path_is_parsed
        request = Lumpi::HttpServer::Request.new("GET /resources/grzl?foo=bar&fooid=22 HTTP/1.1\n" +
            "Host: localhost:80\n\n")
        assert_equal('/resources/grzl', request.path)
    end

    def test_that_parameters_are_parsed
        request = Lumpi::HttpServer::Request.new("POST /path/to/resource.html?foo=bar&fooid=22 HTTP/1.1\n" +
            "Host: localhost:80\n\n")
        assert_equal(2, request.parameters.length)
        assert_equal('bar', request.parameters['foo'])
        assert_equal('22', request.parameters['fooid'])
    end

    def test_that_parameters_are_empty_if_omitted
        request = Lumpi::HttpServer::Request.new("POST /path/to/resource.html HTTP/1.1\n" +
            "Host: localhost:80\n\n")
        assert_equal(0, request.parameters.length)
    end

    def test_raise_for_invalid_method
        assert_raises(Lumpi::HttpErrors::BadRequestError) { Lumpi::HttpServer::Request.new("SCHRUBBLE /path/to/resource.html HTTP/1.1\n") }
    end

    def test_raise_for_invalid_path
        assert_raises(Lumpi::HttpErrors::BadRequestError) { Lumpi::HttpServer::Request.new("PUT /path/to/resou-rce.html HTTP/1.1\n")}
    end

    def test_raise_for_missing_version
        assert_raises(Lumpi::HttpErrors::BadRequestError) { Lumpi::HttpServer::Request.new("POST /path/to/resource.html\n") }
    end

    def test_that_headers_are_parsed
        request = Lumpi::HttpServer::Request.new("GET /resources/grzl HTTP/1.1\n" +
            "Host: localhost:80\n" +
            "Accept-Encoding: gzip, deflate, br\n\n")

        assert_equal('localhost:80', request.headers['Host'])
        assert_equal('gzip, deflate, br', request.headers['Accept-Encoding'])
    end

    def test_that_body_is_parsed
        content = "{ \"key1\": \"foo\", \"key2\": []}"
        request = Lumpi::HttpServer::Request.new("GET /resources/grzl HTTP/1.1\n" +
            "Host: localhost:80\n" +
            "Content-Length: #{content.length}\n" +
            "Accept-Encoding: gzip, deflate, br\n\n" +
            "#{content}")

        assert_equal(content, request.body)
    end
end