require_relative "../../framework"

SCORES = { rock: 1, paper: 2, scissors: 3 }

WIN = 6
DRAW = 3
LOSS = 0

PLAYS = {
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors,
  "X" => :rock,
  "Y" => :paper,
  "Z" => :scissors,
}

# Your move then opponent move
OUTCOMES = {
  rock: { rock: DRAW, paper: LOSS, scissors: WIN },
  paper: { rock: WIN, paper: DRAW, scissors: LOSS },
  scissors: { rock: LOSS, paper: WIN, scissors: DRAW },
}

part_1 example: 15 do |input|
  input
    .split("\n")
    .map { |line| line.split(" ") }
    .map { |(opponent, you)|
      opponent_play = PLAYS[opponent]
      your_play = PLAYS[you]

      SCORES[your_play] + OUTCOMES.dig(your_play, opponent_play)
    }
    .sum
end

DESIRED_OUTCOME_PLAYS = {
  "X" => LOSS,
  "Y" => DRAW,
  "Z" => WIN,
}

# Opponent move then outcome
DESIRED_OUTCOMES = {
  rock: { WIN => :paper, DRAW => :rock, LOSS => :scissors },
  paper: { WIN => :scissors, DRAW => :paper, LOSS => :rock },
  scissors: { WIN => :rock, DRAW => :scissors, LOSS => :paper },
}

part_2 example: 12 do |input|
  input
    .split("\n")
    .map { |line| line.split(" ") }
    .map { |(opponent, outcome)|
      opponent_play = PLAYS[opponent]
      desired_outcome = DESIRED_OUTCOME_PLAYS[outcome]

      your_play = DESIRED_OUTCOMES.dig(opponent_play, desired_outcome)

      SCORES[your_play] + desired_outcome
    }
    .sum
end
