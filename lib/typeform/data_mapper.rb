# encoding: UTF-8

require 'typeform/question_mapper'
require 'typeform/responses'

module TypeForm
  
  class DataMapper

    def initialize typeform_response, object_template
      @question_mapper = QuestionMapper.new typeform_response["questions"]
      @responses = Responses.new typeform_response["responses"]
      @object_template = object_template
    end

    def map 
      @responses.map do |response|
        map_answers response, @object_template
      end
    end

    private 

    def map_answers answers, template
      template.map do |key, value|
        if value.is_a? Hash
          [ key, map_answers(answers, value) ]
        else 
          [key, map_field(value, answers) ]
        end
      end.to_h
    end

    def map_field value, answers
      question, choice = value.split("_")
      field = @question_mapper.find question

      if choice.nil?
        answers[field]
      else
        answers[field].map(&:upcase).include? choice.upcase
      end
    end
  end

end