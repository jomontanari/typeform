# encoding: UTF-8

require 'data_receiver'

class TypeForm

  def initialize form_id, api_key
    @form_id = form_id
    @api_key = api_key
  end

  def get since, ssl_location=false
    config = {
      form_id: @form_id, 
      api_key: @api_key,
      ssl: ssl_location
    }
    data_receiver = DataReceiver.new config
    data_receiver.get since
  end    

end