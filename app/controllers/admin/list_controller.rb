class Admin::ListController < ApplicationController
	before_filter :apply_manager
	layout "manager"
  def index
  	@lists = List.page(params[:page]).per(12).get_list(@company.id, @apply.id).get_status([0, 2]).order("created_at desc")
  end

  def del_list
  	@list = List.get_id(@company, @apply.id, params[:id]).get_status([0, 2]).first
    @list.del_list
  end

  def release
  	List.release_list(@company, @apply)
  end
end
