class Game

    attr_reader :answer_results

    def initialize

        @questions_administered = []
        @answer_results = []

    end 

    def random_question

        if  @questions_administered.length < 6          

            max_id = Question.maximum(:id)
            min_id = Question.minimum(:id)


            while true do                   #keep choosing random IDs until the question exists AND it has not been given already

                random_q_id = Random.new.rand(min_id..max_id)
                break if Question.exists?(random_q_id) && !@questions_administered.include?(random_q_id)

            end

            @questions_administered << random_q_id

            @current_question = Question.find(random_q_id)  #captured in an instance variable so that it can be used by the evaluate_question method

            @current_question

        else

            # self.initialize
            false

        end
        

    end 


    def evaluate_answer(choice)

        @answer_results << (@current_question.correct_choice.to_s == choice.to_s) if @answer_results.length < @questions_administered.length    #the if statement is to prevent submitting the same answer twice accidentally by clicking the submit button twice
        
        @current_question.correct_choice.to_s == choice.to_s

    end 



end