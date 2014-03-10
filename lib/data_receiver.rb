# encoding: UTF-8

require 'faraday'

class DataReceiver

  def initialize config
    @config = config
  end

  def get
    get_since nil
  end

  def get_since since
    conn = Faraday.new faraday_config
    conn.get url_params(since)
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

  def url_params since
    last_run_param = "&since=#{since.to_i}" unless since.nil?
    "/v0/form/#{@config[:form_id]}?key=#{@config[:api_key]}&completed=true#{last_run_param}"
  end

  def type_form_url
    'https://api.typeform.com'
  end

end