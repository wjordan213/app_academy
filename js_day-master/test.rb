#
# // amount = 25, coins = [25, 10, 5, 1]
# // amount 50, coins = [25, 10, 5, 1]
#
# // amount = 35, coins = [25, 10, 5, 1]
#
# // amount = 14, coins = [10, 7, 1]


def make_change(amount, coins)
  best_coins = []

  return [] if amount == 0

  i = 0

  while i < coins.length
    current_largest = coins[i]

    if current_largest <= amount
      new_amount = amount - current_largest

      coins_array = [current_largest] + make_change(new_amount, coins[i..-1])

      if best_coins.empty? || coins_array.length < best_coins.length
        best_coins = coins_array
      end
    end

    i += 1
  end

  best_coins


end
