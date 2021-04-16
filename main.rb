require './deck'
require './dealer'
require './player'
require './calculation'

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

POSSESSION_MONEY = 10000

# ディーラーインスタンスの生成
dealer = Dealer.new()

# プレイヤーインスタンスの生成
player = Player.new(POSSESSION_MONEY)

# プレイヤーが掛け金を決める
bet = player.decide_premium()

# ディーラーにカードが配られる
dealer.dealer_card_distribute(deck)

# プレイヤーにカードが配られる
player_hand = player.player_card_distribute(deck)
calculation(player_hand)

while true
  # プレイヤーがヒットかスタンドを選択する
  selection_number = player.select_act(deck)

  case selection_number
  when 1 then
    # カードのヒット
    new_player_hand = player.hit(deck, player_hand)
    calc_number_sum = calculation(new_player_hand)
    if calc_number_sum >= 22
      puts ""
      puts "バースト！！"
      puts ""
      break
    end
  when 2 then
    # スタンド
    player.stand(player_hand)
    calculation(player_hand)
    break
  end
end



