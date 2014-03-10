# encoding: UTF-8

require 'typeform/data_mapper'

module TypeForm

  describe 'DataMapper' do

    # input from typeform: questions: [ { id: "field_id", question: "question text" } ]
    # input from client: {  property_key: "typeform question text" }

    let(:typeform_response) do
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

    let(:question_mapper) do 
      question_mapper = double('QuestionMapper')
      allow(question_mapper).to receive(:find).and_return "textfield_1"
      question_mapper
    end

    it 'maps text fields to simple properties' do
      mapped_object = DataMapper.new(question_mapper).map typeform_response, object_template
      expect(mapped_object[:name]).to eq "Joanne"
    end

  end

end