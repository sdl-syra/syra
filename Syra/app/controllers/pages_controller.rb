class PagesController < ApplicationController
  before_action :restrict_access_admin, only: [:administrator]
  
  def accueil
  end
  
  def administrator
  end
end
