class MovesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    if @game.valid_move?(params[:row], params[:col])
      @game.move!(params[:row], params[:col])

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @game }
      end
    else
      flash[:alert].now = "Invalid move"
      render "games/show"
    end
  end
end
