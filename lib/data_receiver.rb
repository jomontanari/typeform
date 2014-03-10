# encoding: UTF-8

require 'faraday'

class DataReceiver

  def initialize config
    @config = config
  end

  def get
    conn = Faraday.new faraday_config
    conn.get url_params
  end

  private 

  def faraday_config
    {
      url: type_form_url,
      ssl: ssl_config
    }
  end

  def ssl_config
    if @config[:ssl]
      raise NotImplementedError
    else
      {
        verify: false
      }
    end
  end

  def url_params
    "/v0/form/#{@config[:form_id]}?key=#{@config[:api_key]}&completed=true"
  end

  def type_form_url
    'https://api.typeform.com'
  end

end