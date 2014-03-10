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
        self.send type(key), key
      end

      private

      def textfield key
        @answers[key]
      end

      def list key
        "#{@answers[key + "_choice"]}#{@answers[key + "_other"]}"
      end

      def type key
        key.split("_").first
      end

    end

  end

end