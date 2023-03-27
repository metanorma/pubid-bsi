module Pubid::Bsi
  class Parser < Pubid::Core::Parser
    rule(:type) do
      array_to_str(Identifier.config.types.map { |type| type.type[:short] }.compact).as(:type)
    end

    rule(:part) do
      str("-") >> digits.as(:part)
    end

    rule(:edition) do
      str("v") >> (digits >> dot >> digits).as(:edition)
    end

    rule(:supplement) do
      (str("+") >> match("[AC]").as(:type) >> digits.as(:number) >> str(":") >> year).as(:supplement)
    end

    rule(:expert_commentary) do
      space >> str("ExComm").as(:expert_commentary)
    end

    rule(:identifier) do
      str("BSI ").maybe >> type >> space >>
        (
          (digits.as(:number) >> part.maybe >> (space >> edition).maybe >>
            (space? >> str(":") >> year >> (dash >> month_digits.as(:month)).maybe).maybe)  |
            (match("[^+]").repeat(1).as(:adopted))
        ) >> supplement.maybe >> expert_commentary.maybe
    end

    rule(:root) { identifier }
  end
end
