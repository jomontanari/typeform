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

    let(:typeform_response) do
      {
        "questions" => questions,
        "responses" => []
      }
    end

    describe '#initialize' do
      
      it 'creates a question mapper from the typeform response' do
        DataMapper.new typeform_response
        expect(QuestionMapper).to have_received(:new).with questions
      end    

    end


    describe 'mapping a single set of answers' do

      let(:single_response) do
        {
          answers: {
            "textfield_1" => "Joanne"
          }
        }
      end

      let(:object_template) do
        {
          name: "what is your name?"
        }
      end

      it 'maps text fields to simple properties' do
        allow(question_mapper).to receive(:find).and_return "textfield_1"
        mapped_object = DataMapper.new(typeform_response).map single_response, object_template
        expect(mapped_object[:name]).to eq "Joanne"
      end

    end

  end

end