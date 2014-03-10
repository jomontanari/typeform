# encoding: UTF-8

require 'typeform'

describe TypeForm do
  let(:form_id) { '1234' }
  let(:api_key) { 'some api key' }

  let!(:data_receiver) do
    data_receiver = double(DataReceiver)
    allow(DataReceiver).to receive(:new).and_return(data_receiver)
    data_receiver
  end

  context 'no SSL config' do
  
    it 'creates a new DataReceiver with the correct form_id and api_key' do
      TypeForm.new.get form_id, api_key
      expect(DataReceiver).to have_received(:new).with hash_including(form_id: form_id, api_key: api_key)
    end

    it 'sets SSL to false if it is not passed in' do
      TypeForm.new.get form_id, api_key
      expect(DataReceiver).to have_received(:new).with hash_including(ssl: false)
    end

  end

  context 'with SSL config' do
    xit 'passes SSL to the data receiver config if it is passed in' do
    end
  end

  xit 'returns the results from the DataReceiver' do
  end

end