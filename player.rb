class Player
  def initialize(tip)
    @tip = tip
  end


  def decide_premium()
    while true
      puts <<-EOS

      --------------------------
      ブラックジャックを始めます。
      あなたは#{@tip}円持っています。
      いくら掛けますか？
      掛け金を決めてください。
      --------------------------

      EOS
      print "掛け金を入力 > "
      bet = gets.to_i
      break if bet <= @tip
      puts "所持金以下で入力してください！"
    end
    puts ""
    puts "#{bet}円を掛けます。"
    puts ""
    return bet
  end

  # プレイヤーにカードが配られる
  def player_card_distribute(deck)
    puts "プレイヤーにカードが配られた。"
    card1 = deck.shift
    card2 = deck.shift
    player_hand = []
    player_hand.push(card1, card2)
    open_card1 = player_hand[0]
    open_card2 = player_hand[1]

    puts <<-EOS

    ---------------------
    あなたのカード
    [#{open_card1.show}]
    [#{open_card2.show}]
    ---------------------

    EOS

    return player_hand
  end

  # ヒットかスタンドを選択
  def select_act(deck)
    while true
      puts <<-EOS

      ヒットかスタンドを数字で選択してください。
      1. ヒット
      2. スタンド

      EOS

      print "数字を入力 > "
      selection_number = gets.to_i
      break if (1..2).include?(selection_number)
      puts ""
      puts "1か2の番号を入力して下さい！"
    end
    return selection_number
  end

  # カードのヒット
  def hit(deck, player_hand)
    card = deck.shift
    player_hand.push(card)
    puts <<-EOS
    ---------------------
    あなたのカード
    EOS
    player_hand.each_with_index do |p_hand, i|
      puts <<-EOS
        [#{p_hand.mark}の#{p_hand.number}]
      EOS
    end
    puts <<-EOS
    ---------------------
    EOS
    return player_hand
  end

  def stand(player_hand)
    puts ""
    puts "スタンド！！"
    puts ""
  end
end