# encoding: UTF-8

require 'data_receiver'

class TypeForm

  def get form_id, api_key, ssl_location=false
    config = {
      form_id: form_id, 
      api_key: api_key,
      ssl: ssl_location
    }
    DataReceiver.new config
  end    

end