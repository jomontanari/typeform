# encoding: UTF-8

require 'typeform/data_mapper'

module TypeForm

  describe 'DataMapper' do

    let!(:question_mapper) do 
      question_mapper = double('QuestionMapper')
      allow(QuestionMapper).to receive(:new).and_return question_mapper
      question_mapper
    end

    let(:questions) do
      [
        "id" => 'textfield_1',
        "question" => 'what is your name?'
      ]
    end
    let(:responses) do
      []
    end

    let(:typeform_response) do
      {
        "questions" => questions,
        "responses" => responses
      }
    end
    let(:object_template) do
      {
        name: "what is your name?"
      }
    end

    describe '#initialize' do
      
      it 'creates a question mapper from the typeform response' do
        DataMapper.new typeform_response, object_template
        expect(QuestionMapper).to have_received(:new).with questions
      end    

    end

    context 'with text fields' do

      let(:mapped_results) do
        allow(question_mapper).to receive(:find).and_return "textfield_1"
        DataMapper.new(typeform_response, object_template).map
      end

      context 'single response with single field' do

        let(:responses) do
          [{
            answers: {
              "textfield_1" => "Joanne"
            }
          }]
        end

        it 'returns a single result' do
          expect(mapped_results.size).to be 1
        end

        it 'maps text fields to simple properties' do
          expect(mapped_results.first[:name]).to eq "Joanne"
        end

      end

      context 'multiple responses' do
        let(:responses) do
          [{
            answers: {
              "textfield_1" => "Joanne"
            }
          },
          {
            answers: {
              "textfield_1" => "John"
            }
          }
        ]
        end

        it 'returns the correct number of results' do
          expect(mapped_results.size).to be 2
        end

        it 'maps text fields correctly for each result' do
          expect(mapped_results.first[:name]).to eq "Joanne"
          expect(mapped_results[1][:name]).to eq "John"
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
            answers: {
              "textfield_1" => "Joanne",
              "textfield_2" => "A company",
              "textfield_3" => "Somewhere"
            }
          }
        ]
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

      

    end


    context 'with list selection fields' do

      context 'simple properties'

      context 'nested properties'

    end

  end

end