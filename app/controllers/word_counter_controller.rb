class WordCounterController < ApplicationController
  def show
    @text = ''
    @word_count = 0
    @character_count = 0
  end

  def create
    @text = params[:text] || ''
    @word_count = count_words(@text)
    @character_count = @text.length

    respond_to do |format|
      format.turbo_stream
      format.html { render :show }
    end
  end

  private

  def count_words(text)
    return 0 if text.blank?

    text.split(/\s+/).compact_blank.count
  end
end
