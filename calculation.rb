def calculation(cards)
  calc_num = []
  cards.each do |card|
    case card.number
    when "J" || "Q" || "K" then
      calc_card_num = 10
      calc_num << calc_card_num.to_i
    when "A" then
      calc_card_num = 11
      calc_num << calc_card_num.to_i
    else
      calc_num << card.number.to_i
    end
  end

  calc_number_sum = calc_num.sum

  puts <<-EOS
  -----------------------------
  カードの合計値：#{calc_number_sum}
  -----------------------------
  EOS
end