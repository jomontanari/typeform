# encoding: UTF-8

require 'typeform'
require 'integration/data'

describe 'Typeform gem end-to-end functionality' do
  
  let!(:faraday_double) do
    faraday_double = double(Faraday)
    allow(faraday_double).to receive(:get).and_return response_double
    allow(Faraday).to receive(:new).and_return faraday_double
    faraday_double
  end
  let(:response_double) do
    response_double = double("response")
    allow(response_double).to receive(:body).and_return response_body
    response_double
  end

  let(:response_body) { MultiJson.dump(TypeForm::RESPONSE_DATA) }
  let(:object_template) do 
    {
      name_and_company: "What's your name and company name?",
      telephone: "What's your phone number",
      colour: "What's your favourite colour?",
      weather: {
        sun: "What weather do you like?_Sunshine",
        cloud: "What weather do you like?_Clouds",
        rain: "What weather do you like?_Rain",
        snow: "What weather do you like?_Snow"
      }
    }
  end

  it 'should get the expected response' do
    mapped_objects = TypeForm.retrieve_responses "some form id", "some api key", nil, object_template
    expect(mapped_objects).to eq TypeForm::EXPECTED_MAPPED_OBJECTS
  end
end
