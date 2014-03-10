# encoding: UTF-8

require 'typeform/responses'

module TypeForm

  describe Responses do
    
    context 'text field' do

      let(:typeform_answers) do
        [{
          "answers" => {
            "textfield_1" => "Joanne"
          }
        }]
      end

      it 'allows enumeration through the individual answers' do
        answers = Responses.new(typeform_answers).each {|answer| answer}
        expect(answers.size).to be 1
      end

      it 'retrieves the response from an answer as text' do
        answer = Responses.new(typeform_answers).first
        expect(answer["textfield_1"]).to eq "Joanne"
      end

    end

    context 'multiple choice field' do
      let(:answer) { Responses.new(typeform_answers).first }

      context 'with single answer' do
        let(:typeform_answers) do
          [{
            "answers" => {
              "list_1_choice" => "Sunshine"
            }
          }]
        end

        it 'retrieves the response as text' do
          expect(answer["list_1"]).to eq "Sunshine"
        end

      end

      context 'with single answer or other option' do
        let(:typeform_answers) do
          [{
            "answers" => {
              "list_1_choice" => "",
              "list_1_other" => "Rain"
            }
          }]
        end

        it 'retrieves the response as text' do
          expect(answer["list_1"]).to eq "Rain"
        end
      end

      context 'with multiple answers' do
      end

      context 'with multiple answers or other option' do
      end

    end

  end

end