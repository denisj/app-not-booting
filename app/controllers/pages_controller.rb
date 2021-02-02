class PagesController < ApplicationController

  def show
    respond_to do |format|
      format.html do
        template_path = "pages/#{params[:page]}"

        if template_exists?(template_path)
          render template: template_path
        else
          not_found
        end
      end
    end
  end
end
