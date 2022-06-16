# == Schema Information
#
# Table name: games
#
#  id             :uuid             not null, primary key
#  state          :json
#  current_symbol :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Game < ApplicationRecord
  before_validation(on: :create) do
    self.state = {
      0 => {
        0 => nil,
        1 => nil,
        2 => nil
      },
      1 => {
        0 => nil,
        1 => nil,
        2 => nil
      },
      2 => {
        0 => nil,
        1 => nil,
        2 => nil
      }
    }

    self.current_symbol = %i[x o].sample
  end

  after_update_commit { broadcast_update }

  def move!(row, col)
    self.state[row.to_s][col.to_s] = current_symbol
    self.current_symbol = current_symbol == "x" ? "o" : "x"
    self.save!
  end

  def [](row, col)
    state[row.to_s][col.to_s]
  end

  def valid_move?(row, col)
    state.key?(row.to_s) && state[row.to_s].key?(col.to_s) &&
      state[row.to_s][col.to_s].nil?
  end
end
