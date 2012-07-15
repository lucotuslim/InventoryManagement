class HomeController < ApplicationController
  skip_before_filter :require_user, :only => [:index]

  def index
  end
end
