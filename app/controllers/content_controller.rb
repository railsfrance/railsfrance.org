class ContentController < ApplicationController
  include ContentHelper

  def preview
    render text: markdown(params["content"])
  end
end
