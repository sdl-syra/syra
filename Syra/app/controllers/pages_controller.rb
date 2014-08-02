class PagesController < ApplicationController
  before_action :restrict_access_admin, only: [:admin]
  
  def accueil
  end
  
  def admin
  end
end
