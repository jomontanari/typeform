# encoding: UTF-8

require 'typeform/data_receiver'

module TypeForm

  def self.retrieve_responses form_id, api_key, since, ssl_location=false
    config = {
      form_id: form_id, 
      api_key: api_key,
      ssl: ssl_location
    }
    data_receiver = DataReceiver.new config
    data_receiver.get since
  end    

end