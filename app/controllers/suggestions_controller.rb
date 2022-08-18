class SuggestionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @suggestion = Suggestion.new(suggestion_params)

    if !current_user.you_tube_video_ids.include?(@suggestion.you_tube_video_id)
      redirect_to sources_path
      return
    end

    @suggestion.save!

    redirect_to you_tube_video_path(@suggestion.you_tube_video.you_tube_id)
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(
      :destination_id,
      :you_tube_video_id,
    )
  end
end
