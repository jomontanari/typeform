# encoding: UTF-8

require 'typeform/data_mapper'

module TypeForm

  describe 'DataMapper' do

    let(:questions) { [ "questions" ] }
    let(:typeform_answers) { [ "answers" ] }
    let(:typeform_response) do
      {
        "questions" => questions,
        "responses" => typeform_answers
      }
    end

    let!(:question_mapper) do 
      question_mapper = double(QuestionMapper)
      allow(QuestionMapper).to receive(:new).and_return question_mapper
      question_mapper
    end

    let(:responses) { [] }

    let(:object_template) do
      {
        name: "what is your name?"
      }
    end

    before do
      allow(Responses).to receive(:new).and_return responses
    end

    describe '#initialize' do
      
      it 'creates a question mapper from the typeform questions' do
        DataMapper.new typeform_response, object_template
        expect(QuestionMapper).to have_received(:new).with questions
      end    

      it 'creates a Responses object from the type form responses' do
        DataMapper.new typeform_response, object_template
        expect(Responses).to have_received(:new).with typeform_answers
      end

    end

    context 'with a single field' do

      let(:mapped_results) do
        allow(question_mapper).to receive(:find).and_return "textfield_1"
        DataMapper.new(typeform_response, object_template).map
      end

      context 'with a single response' do
        let(:responses) { [ { "textfield_1" => "Joanne" } ] }

        it 'returns a single result' do
          expect(mapped_results.size).to be 1
        end

        it 'maps text fields to simple properties' do
          expect(mapped_results.first[:name]).to eq "Joanne"
        end

      end


      context 'with multiple responses' do
        let(:responses) do
          [{
              "textfield_1" => "Joanne"
          },
          {
              "textfield_1" => "John"
          }]
        end

        it 'returns the correct number of results' do
          expect(mapped_results.size).to be 2
        end

        it 'maps text fields correctly for each result' do
          expect(mapped_results.first[:name]).to eq "Joanne"
          expect(mapped_results[1][:name]).to eq "John"
        end
      end

    end

    context 'with multiple fields' do
      let(:mapped_results) do
        allow(question_mapper).to receive(:find).with("what is your name?").and_return "textfield_1"
        allow(question_mapper).to receive(:find).with("what is your company?").and_return "textfield_2"
        allow(question_mapper).to receive(:find).with("what is your address?").and_return "textfield_3"
        DataMapper.new(typeform_response, object_template).map
      end
      let(:responses) do
        [{
          "textfield_1" => "Joanne",
          "textfield_2" => "A company",
          "textfield_3" => "Somewhere"
        }]
      end
      let(:object_template) do
        {
          name: "what is your name?",
          company: "what is your company?",
          address: "what is your address?"
        }
      end

      it 'maps multiple text fields' do
        expect(mapped_results.first[:name]).to eq "Joanne"
        expect(mapped_results.first[:company]).to eq "A company"
        expect(mapped_results.first[:address]).to eq "Somewhere"
      end

      context 'nested properties' do
        let(:object_template) do
          {
            contact_details: {
              name: "what is your name?",
              address: {
                company: "what is your company?",
                location: "what is your address?"
              }
            }
          }
        end

        it 'maps nested properties' do
          expect(mapped_results.first[:contact_details]).to eq({ name: "Joanne", address: { company: "A company", location: "Somewhere" } })
        end

      end

    end

    context 'with multiple choice lists' do
      let(:mapped_results) do
        allow(question_mapper).to receive(:find).with("what weather do you like").and_return "list_1"
        DataMapper.new(typeform_response, object_template).map
      end
      let(:responses) do
        [{
          "list_1" => ["Rain","Sunshine"]
        }]
      end

      context 'with a template requiring a list' do
        let(:object_template) do
          {
            weather: "what weather do you like",
          }
        end

        it 'sets the property to a list' do
          expect(mapped_results.first[:weather]).to eq ["Rain","Sunshine"]
        end
      end

      context 'with a template requiring boolean values' do
        let(:object_template) do
          {
            weather: {
              rain: "what weather do you like_Rain",
              sun: "what weather do you like_Sunshine",
              cloud: "what weather do you like_Cloud",
            }
          }
        end

        it 'sets properties that are present to true' do
          expect(mapped_results.first[:weather][:sun]).to be true
          expect(mapped_results.first[:weather][:rain]).to be true
        end

        it 'sets properties that are not present to false' do
          expect(mapped_results.first[:weather][:cloud]).to be false
        end
      end

      context 'with different case between template and answers' do
        let(:object_template) do
          {
            weather: {
              rain: "what weather do you like_RAIN",
              sun: "what weather do you like_SUNSHINE",
              cloud: "what weather do you like_CLOUD",
            }
          }
        end

        it 'is case insensitive' do
          expect(mapped_results.first[:weather][:sun]).to be true
          expect(mapped_results.first[:weather][:rain]).to be true
        end

      end


    end 

  end

end