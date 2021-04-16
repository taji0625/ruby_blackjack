
class Deck
  attr_reader :mark, :number
  def initialize(mark, number)
    @mark = mark
    @number = number
  end

  def show
    "#{@mark}の#{@number}"
  end

end