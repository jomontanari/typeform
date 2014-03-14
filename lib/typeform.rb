# encoding: UTF-8

require 'typeform/data_receiver'
require 'typeform/data_mapper'

module TypeForm

  def self.retrieve_responses form_id, api_key, since, object_template, ssl_location=false
    config = {
      form_id: form_id, 
      api_key: api_key,
      ssl: ssl_location
    }
    data_receiver = DataReceiver.new config
    data_receiver.get(since) do |response_json|
      mapper = DataMapper.new response_json, object_template
      mapper.map
    end

  end    

end