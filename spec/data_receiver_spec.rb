# encoding: UTF-8

require 'typeform'

describe DataReceiver do

  let(:data_receiver) { DataReceiver.new config }
  
  context 'no SSL verification' do
    let(:config) do
      {
        ssl: false,
        form_id: '1234',
        api_key: '5678'
      }
    end
    let(:response_body) { "body text" }
    let(:response_double) do
      response_double = double("response")
      allow(response_double).to receive(:body).and_return response_body
      response_double
    end

    let!(:faraday_double) do
      faraday_double = double(Faraday)
      allow(faraday_double).to receive(:get).and_return response_double
      allow(Faraday).to receive(:new).and_return faraday_double
      faraday_double
    end

    context 'no time since specified' do

      it 'sends the typeform URL to faraday' do
        data_receiver.get nil
        expect(Faraday).to have_received(:new).with hash_including(url: 'https://api.typeform.com')
      end

      it 'sets Faraday to not verify SSL certs' do
        data_receiver.get nil
        expect(Faraday).to have_received(:new).with hash_including(ssl: { verify: false })
      end

      it 'sends a request to the correct URL with form ID and API key' do
        data_receiver.get nil
        expect(faraday_double).to have_received(:get).with "/v0/form/#{config[:form_id]}?key=#{config[:api_key]}&completed=true"
      end

      it 'returns the response body' do
        result_string = data_receiver.get nil
        expect(result_string).to eq response_body
      end

    end

    context 'time since specified' do

      it 'sends a request to the correct URL with form ID, API key and since parameter' do
        time = Time.now
        time_value = time.to_i
        data_receiver.get time
        expect(faraday_double).to have_received(:get).with "/v0/form/#{config[:form_id]}?key=#{config[:api_key]}&completed=true&since=#{time_value}"
      end

      it 'returns the response body' do
        result_string = data_receiver.get Time.now
        expect(result_string).to eq response_body
      end

    end
  end

  context 'with SSL verification' do
    let(:config) do
      {
        url: 'https://api.typeform.com',
        ssl: "/usr/lib/ssl/certs",
        form_id: '1234',
        api_key: '5678'
      }
    end

    it 'raises an exception as it is not implemented' do
      expect { data_receiver.get(nil) }.to raise_error(NotImplementedError)
    end

  end

end