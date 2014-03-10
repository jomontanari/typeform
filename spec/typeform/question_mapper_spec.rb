# encoding: UTF-8

require 'typeform/question_mapper'

module TypeForm

  describe QuestionMapper do

    let(:typeform_questions) do
      [
        { id: 'textfield1', question: 'what is your name?' },
        { id: 'textfield2', question: 'what is your company?' }
      ]
    end

    let(:question_mapper) { QuestionMapper.new(typeform_questions) }

    it 'determines the field reference given the question text' do
      expect(question_mapper.find "what is your name?").to eq "textfield1"
    end

    it 'ignores case' do
      expect(question_mapper.find "WhAt is your COMPanY?").to eq "textfield2"
    end

    it 'ignores leading and trailing spaces' do
      expect(question_mapper.find "   what is your name?   ").to eq "textfield1"
    end

    it 'ignores trailing question marks' do
      expect(question_mapper.find "what is your company").to eq "textfield2"
    end
    
  end

end