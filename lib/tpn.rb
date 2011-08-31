require "tpn/version"

module Tpn
  
  class Request
    
    attr_accessor :module_id
    
    def initialize
      # @module_id = "TPN"
    end
    
  end
  
  class Request::ConsumerRequest < Request
    
    attr_accessor :params, :consumer, :enquirer
    
    def initialize
      @module_id = "TPN"
    end
    
    def action
      :consumer_enquiry
    end
    
    def body
      {"ModuleList" => {:string => @module_id},
       "ConsumerBlock" => @consumer,
       "EnquiryBlock" => @enquirer }
    end
    
  end
  
  class Client
    
    attr_accessor :url, :security_block, :enquirer, :consumer
    attr_accessor :soap_client, :soap_request 
    
    def initialize(url, security_block = {})
      @url = url
      @security_block = security_block
      
      @soap_client = ::Savon::Client.new(@url)
    end
    
    def actions
      ["consumer_enquiry", "consumer_id_verification", "get_consumer_modules", "consumer_trace"]
    end
    
    def request
      @soap_request = Request.new
      yield @soap_request
      process_request
    end
    
    def consumer_enquiry
      @soap_request = Request::ConsumerRequest.new
      yield @soap_request
      process_request
    end
    
    def process_request
      request = @soap_request
      security_block = @security_block
      
      response = @soap_client.request(@soap_request.action) do
        soap.body = {
          "SecurityBlock" => security_block
        }.merge(request.body)
      end
      
      return response.to_hash
    end
  end
end
