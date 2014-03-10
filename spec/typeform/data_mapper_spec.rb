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

    context 'with a single single_response' do

      let(:responses) do
        [{
          answers: {
            "textfield_1" => "Joanne"
          }
        }]
      end

      let(:mapped_results) do
        allow(question_mapper).to receive(:find).and_return "textfield_1"
        DataMapper.new(typeform_response, object_template).map
      end


      it 'returns a single result' do
        expect(mapped_results.size).to be 1
      end

      it 'maps text fields to simple properties' do
        expect(mapped_results.first[:name]).to eq "Joanne"
      end

    end

  end

end