# カードの合計値の計算
def calculation(cards)
  calc_num = []
  cards.each do |card|
    case card.number
    when "J", "Q", "K" then
      calc_card_num = 10
      calc_num << calc_card_num.to_i
    when "A" then
      calc_card_num = 11
      calc_num << calc_card_num.to_i
    else
      calc_num << card.number.to_i
    end
  end

  # Aはバーストしないなら11で計算、バーストするなら1で計算
  calc_number_sum = calc_num.sum
  if calc_num.include?(11)
    if calc_number_sum >= 22
      calc_number_sum -= 10
    end
  end

  puts <<-EOS

  -----------------------------
  カードの合計値：#{calc_number_sum}
  -----------------------------

  EOS
  return calc_number_sum
end

# 勝敗判定
def win_or_loss_decision(player, player_calc_number_sum, dealer_calc_number_sum, bet)
  if player_calc_number_sum > dealer_calc_number_sum
    puts ""
    puts "あなたの勝ち！！"
    puts "所持金が#{bet}円増えた！！"
    player.tip += bet
    puts "あなたの所持金、残り#{player.tip}円"
    puts ""
  elsif player_calc_number_sum < dealer_calc_number_sum
    puts ""
    puts "あなたの負け..."
    puts "所持金を#{bet}円を失った。"
    player.tip -= bet
    puts "あなたの所持金、残り#{player.tip}円"
    puts ""
  else
    puts ""
    puts "引き分け！"
    puts "あなたの所持金、残り#{player.tip}円"
    puts ""
  end
end