# encoding: UTF-8

module TypeForm
  
  # maps a single response on to the object template
  class DataMapper

    def initialize question_mapper
      @question_mapper = question_mapper
    end

    def map typeform_response, object_template
      map_answers typeform_response[:answers], object_template
    end

    private 

    def map_answers answers, template
      template.map do |key, value|
        field_id = @question_mapper.find value
        [ key, answers[field_id] ]
      end.to_h
    end
  end

end