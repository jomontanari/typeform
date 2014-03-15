# encoding: UTF-8

module TypeForm

  class QuestionMapper

    def initialize typeform_questions
      @questions = typeform_questions.map do |question_properties|
        [ clean_question(question_properties["question"]), clean_id(question_properties["id"])]
      end.to_h
    end

    def find question_text
      @questions.fetch(clean_question(question_text), "")
    end

    private

    def clean_id id
      id.split("_").take(2).join("_")
    end

    def clean_question text
      text.upcase.strip.gsub("?", "")
    end

  end

end