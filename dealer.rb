class Dealer
  # ディーラーにカードが配られる
  def dealer_card_distribute(deck)
    puts "ディーラーにカードが配られた。"
    card1 = deck.shift
    card2 = deck.shift
    dealer_hand = []
    dealer_hand.push(card1, card2)
    open_card = dealer_hand[0]



    puts <<-EOS

    ---------------------
    ディーラーのカード
    [#{open_card.show}]
    [???]
    ---------------------

    EOS
  end
end