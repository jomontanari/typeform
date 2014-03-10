# encoding: UTF-8

module TypeForm

  class QuestionMapper

    def initialize typeform_questions
      @questions = typeform_questions.map do |question_properties|
        [ normalize(question_properties[:question]), question_properties[:id]]
      end.to_h
    end

    def find question_text
      @questions[normalize(question_text)]
    end

    private

    def normalize text
      text.upcase.strip.gsub("?", "")
    end

  end

end