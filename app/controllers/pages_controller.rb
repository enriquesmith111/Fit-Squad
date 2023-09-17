class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def about
  end

  def tandc
  end

  def private
  end

  def contact
  end

  def cookies
  end
end
