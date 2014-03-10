# encoding: UTF-8

require 'typeform'

describe TypeForm do
  let(:form_id) { '1234' }
  let(:api_key) { 'some api key' }

  let(:results) { ["some", "results"]}

  let!(:data_receiver) do
    data_receiver = double(DataReceiver)
    allow(data_receiver).to receive(:get).and_return results
    allow(DataReceiver).to receive(:new).and_return data_receiver
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

    it 'returns the results from the DataReceiver' do
      typeform_results = TypeForm.new.get form_id, api_key
      expect(typeform_results).to eq(results)
    end

  end

  context 'with SSL config' do
    let(:ssl_location) { 'somewhere' }
    it 'passes SSL to the data receiver config if it is passed in' do
      TypeForm.new.get form_id, api_key, ssl_location
      expect(DataReceiver).to have_received(:new).with hash_including(ssl: ssl_location)
    end
  end

end