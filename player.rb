class Player
  attr_accessor :tip
  def initialize(tip)
    @tip = tip
  end


  def decide_premium()
    while true
      puts <<-EOS

      --------------------------
      ブラックジャックを始めます。
      あなたは#{@tip.floor}円持っています。
      いくら掛けますか？
      掛け金を決めてください。
      --------------------------

      EOS
      print "掛け金を入力 > "
      bet = gets.to_i
      break if bet <= @tip && bet >= 1
      puts "1円以上、且つ所持金以下で入力してください！"
    end
    if bet === @tip
      puts ""
      puts "オールイン！！！"
      @tip -= bet
      puts "あなたの所持金、残り#{@tip.floor}円"
      puts ""
    else
      puts ""
      puts "#{bet}円を掛けます。"
      @tip -= bet
      puts "あなたの所持金、残り#{@tip.floor}円"
      puts ""
    end
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
    [#{open_card1.mark}の#{open_card1.number}]
    [#{open_card2.mark}の#{open_card2.number}]
    ---------------------

    EOS

    return player_hand
  end

  # ブラックジャックか判定
  def is_blackjack?(player_hand)
    if player_hand[0].number === "A" || player_hand[1].number === "A"
      if player_hand[0].number === "10" || player_hand[1].number === "10" ||
      player_hand[0].number === "J" || player_hand[1].number === "J" ||
      player_hand[0].number === "Q" || player_hand[1].number === "Q" ||
      player_hand[0].number === "K" || player_hand[1].number === "K"
        return true
      end
    end
    return false
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
    カードを1枚ヒット！！

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