class Admin::VisitorController < ApplicationController
	
	
	layout "manager"
	
	def index
		@visitors  = Visitor.where(:company_id => @company.id).order("id DESC").page(params[:page]).per(60)
		
	end
	

end
