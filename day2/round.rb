class Round
  CHOICES = { 'A' => 1, 'B' => 2, 'C' => 3, 'X' => 1, 'Y' => 2, 'Z' => 3 }

  def initialize(encoded_round)
    opponent, response = encoded_round.split(' ')
    @opponent = CHOICES[opponent]
    @response = CHOICES[response]
  end

  def score
    result_score = case (@response - @opponent) % 3
                   when 0
                     3
                   when 1
                     6
                   when 2
                     0
                   end
    result_score + @response
  end
end
