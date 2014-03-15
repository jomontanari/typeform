# encoding: UTF-8

module TypeForm

  class Responses

    include Enumerable

    def initialize typeform_responses
      @responses = typeform_responses
    end

    def each(&block)
      @responses.each do |response|
        answers = Answers.new(response["answers"])
        block.call(answers)
      end
    end

    class Answers

      def initialize answers
        @answers = answers
      end

      def [] key
        begin
          self.send type(key), key
        rescue TypeError, NoMethodError
          ""
        end
      end

      private

      def textfield key
        @answers.fetch(key, "")
      end

      def list key
        if @answers.has_key? "#{key}_choice"
          "#{@answers[key + "_choice"]}#{@answers[key + "_other"]}"  
        else
          get_all_choices key
        end        
      end

      def get_all_choices key
        @answers.select {|field_id, value| field_id.include? key}.values.reject(&:empty?)
      end

      def type key
        key.split("_").first
      end

    end

  end

end