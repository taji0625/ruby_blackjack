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
    return dealer_hand
  end

  def card_open(dealer_hand)
    open_card1 = dealer_hand[0]
    open_card2 = dealer_hand[1]
    puts <<-EOS
    ディーラーのカードがオープン！

    ---------------------
    ディーラーのカード
    [#{open_card1.show}]
    [#{open_card2.show}]
    ---------------------
    EOS
  end

  #ディーラーはカードの合計値が17以上になるまでヒット
  def hit(deck, dealer_hand)
    card = deck.shift
    dealer_hand.push(card)
    puts <<-EOS
    ディーラーはカードを1枚ヒット！！

    ---------------------
    ディーラーのカード
    EOS
    dealer_hand.each_with_index do |d_hand, i|
      puts <<-EOS
        [#{d_hand.mark}の#{d_hand.number}]
      EOS
    end
    puts <<-EOS
    ---------------------
    EOS
    return dealer_hand
  end
end