require './deck'
require './dealer'
require './player'
require './calculation'



# プレイヤーの所持金
POSSESSION_MONEY = 10000
tip = POSSESSION_MONEY


# ディーラーインスタンスの生成
dealer = Dealer.new()

# プレイヤーインスタンスの生成
player = Player.new(tip)

loop do
  # デッキの生成
  deck = [];
  mk = ["♠️", "♡", "♦︎", "♣︎"];
  num = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q" ,"K"];
  mk.each do |mark|
    num.each do |number|
      deck << Deck.new(mark, number)
    end
  end
  deck.shuffle!


  # プレイヤーが掛け金を決める
  bet = player.decide_premium()

  # ディーラーにカードが配られる
  dealer_hand = dealer.dealer_card_distribute(deck)

  # プレイヤーにカードが配られる
  player_hand = player.player_card_distribute(deck)

  # ブラックジャックか判定
  is_blackjack = player.is_blackjack?(player_hand)

  # プレイヤーのカードの合計値の計算
  player_calc_number_sum = calculation(player_hand)

  while true
    # プレイヤーがヒットかスタンドを選択する
    selection_number = player.select_act(deck)

    case selection_number
    when 1 then
      # カードのヒット
      new_player_hand = player.hit(deck, player_hand)


      # プレイヤーのカードの合計値の計算
      player_calc_number_sum = calculation(new_player_hand)
      if player_calc_number_sum >= 22
        puts ""
        puts "バースト！！"
        puts ""
        puts "あなたの負け..."
        puts "掛け金を#{bet}円を失った。"
        puts "あなたの所持金、残り#{player.tip}円"
        break
      end
    when 2 then
      # スタンド
      player.stand(player_hand)

      # ディーラーの二枚目のカードがオープン
      dealer.card_open(dealer_hand)

      # ディーラーのカードの合計値の計算
      dealer_calc_number_sum = calculation(dealer_hand)

      if dealer_calc_number_sum <= 16
        while true
          #ディーラーがはカードの合計値が17以上になるまでヒット
          new_dealer_hand = dealer.hit(deck, dealer_hand)

          # ディーラーのカードの合計値の計算
          dealer_calc_number_sum = calculation(new_dealer_hand)

          if dealer_calc_number_sum >= 17 && dealer_calc_number_sum <= 21

            # 勝敗判定
            win_or_loss_decision(player, player_calc_number_sum, dealer_calc_number_sum, bet, is_blackjack)
            break
          end

          if dealer_calc_number_sum >= 22
            if is_blackjack === false
              puts ""
              puts "ディーラーはバースト！！"
              puts "あなたの勝ち！！"
              puts "所持金が#{bet * 2}円増えた！！"
              player.tip += bet * 2
              puts "あなたの所持金、残り#{player.tip}円"
              puts ""
              break
            else
              puts ""
              puts "ディーラーはバースト！！"
              puts "あなたの勝ち！！"
              puts "ブラックジャックなので、リターンは2.5倍になります！"
              puts "所持金が#{bet * 2.5}円増えた！！"
              player.tip += bet * 2.5
              puts "あなたの所持金、残り#{player.tip}円"
              puts ""
              break
            end
          end
        end
        break
      else
        # 勝敗判定
        win_or_loss_decision(player, player_calc_number_sum, dealer_calc_number_sum, bet, is_blackjack)
        break
      end
    end
  end

  if player.tip === 0
    puts "チップがなくなった。。。"
    puts "また遊びに来てね！"
    puts ""
    break
  end

  while true
    puts <<-EOS

    -----------------------------------
    ゲームを続けますか？

    ヒットかスタンドを数字で選択してください。
    1. 続ける
    2. やめる
    -----------------------------------

    EOS

    print "数字を入力 > "
    continue_number = gets.to_i
    break if (1..2).include?(continue_number)
    puts ""
    puts "1か2の番号を入力して下さい！"
  end

  if continue_number === 2
    puts "また遊びにきてね！！"
    break
  end
end



