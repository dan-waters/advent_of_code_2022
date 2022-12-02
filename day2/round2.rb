class Round2
  CHOICES = { 'A' => 1, 'B' => 2, 'C' => 3, 'X' => 0, 'Y' => 3, 'Z' => 6 }

  def initialize(encoded_round)
    opponent, result = encoded_round.split(' ')
    @opponent = CHOICES[opponent]
    @result = CHOICES[result]
  end

  def score
    response_score = case @result
                     when 0
                       (@opponent + 2) % 3
                     when 3
                       @opponent
                     when 6
                       (@opponent + 1) % 3
                     end
    if response_score == 0
      response_score = 3
    end
    response_score + @result
  end
end
