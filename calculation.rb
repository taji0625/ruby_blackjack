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
def win_or_loss_decision(player, player_calc_number_sum, dealer_calc_number_sum, bet, is_blackjack)
  if player_calc_number_sum > dealer_calc_number_sum
    if is_blackjack === false
      puts ""
      puts "あなたの勝ち！！"
      puts "所持金が#{bet * 2}円増えた！！"
      player.tip += bet * 2
      puts "あなたの所持金、残り#{player.tip.floor}円"
      puts ""
    else
      puts ""
      puts "ブラックジャック！！"
      puts "あなたの勝ち！！"
      puts "ブラックジャックで勝ったため、リターンは2.5倍になります！"
      puts "所持金が#{(bet * 2.5).floor}円増えた！！"
      player.tip += bet * 2.5
      puts "あなたの所持金、残り#{player.tip.floor}円"
      puts ""
    end
  elsif player_calc_number_sum < dealer_calc_number_sum
    puts ""
    puts "あなたの負け..."
    puts "掛け金#{bet}円を失った。"
    puts "あなたの所持金、残り#{player.tip.floor}円"
    puts ""
  else
    puts ""
    puts "引き分け！"
    puts "掛け金#{bet}円が返ってきた。"
    player.tip += bet
    puts "あなたの所持金、残り#{player.tip.floor}円"
    puts ""
  end
end