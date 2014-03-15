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

      it 'sends an empty string if the answer does not exist' do
        answer = Responses.new(typeform_answers).first
        expect(answer["textfield_2"]).to eq ""
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
 
        it 'sends back an empty array if the answer does not exist' do
          expect(answer["list_2"]).to eq []
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

        it 'sends back an empty array if the answer does not exist' do
          expect(answer["list_2"]).to eq []
        end
      end

      context 'with multiple answers' do
        let(:typeform_answers) do
          [{
            "answers" => {
              "list_1_choice_1" => "Sunshine",
              "list_1_choice_2" => "Rain",
              "list_1_choice_3" => "",
            }
          }]
        end

        it 'retrieves the chosen responses in an array' do
          expect(answer["list_1"]).to eq ["Sunshine", "Rain"]
        end

        it 'sends back an empty array if the answer does not exist' do
          expect(answer["list_2"]).to eq []
        end
      end

      context 'with multiple answers or other option' do
        let(:typeform_answers) do
          [{
            "answers" => {
              "list_1_choice_1" => "",
              "list_1_choice_2" => "Rain",
              "list_1_choice_3" => "",
              "list_1_other" => "Cloudy"
            }
          }]
        end

        it 'retrieves the chosen responses including the other choice' do
          expect(answer["list_1"]).to eq ["Rain", "Cloudy"]
        end

        it 'sends back an empty array if the answer does not exist' do
          expect(answer["list_2"]).to eq []
        end
      end

    end

  end

end