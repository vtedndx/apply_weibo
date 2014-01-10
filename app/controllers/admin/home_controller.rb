class Admin::HomeController < ApplicationController
	layout "manager"
	include ApplicationHelper

  def add_company;end

  def test
    b = Backdrop.new
    b.avatar = params[:pic]
    b.save
  end

  def submit_company_info
    @company.set_config("company_name", params[:companyName])
    @company.set_config("name", params[:name])
    @company.set_config("email", params[:email])
    @company.set_config("tel", params[:tel])
    SinaClient.add_focus("2627647487", @company.sns_token) if params[:fans_luopan]
  end

  def abc
    @aes = ApplyElement.where("apply_info_id is null")
  end

  def submit_page
    array = params[:array]
    array.each do |ar|
      items = params[:items]["#{ar}"]
      ae = items["id"].blank? ? ApplyElement.new : ApplyElement.find(items["id"])
      ae.element_id = ar
      ae.partial_name = items["name"] 
      ae.set_config(ar, items)
      ae.status = 0
      ae.save
    end
    redirect_to manager_link("/admin/home/abc")
  end

  def index
  	@applys = ApplyInfo.page(params[:page]).per(20).get_apply(@company.id, [0,2]).order("created_at desc")
  end

  def add_apply;end

  def submit_apply
  	@apply = ApplyInfo.save_apply(@company, params[:title], params[:share])
  end

  def edit_apply
    @apply = ApplyInfo.get_id(@company, params[:id]).first
  end

  def add_opinion;end

  def del_apply
    @apply = ApplyInfo.get_id(@company, params[:id]).first
    @apply.del_apply
  end

  def submit_opinion
    if params[:content]
      @info = Opinion.save_opinion(@company, params[:content])
    end
  end

  def close_apply
    @apply_id = params[:id]
    @company.set_config("apply_id", nil)
  end

  def open_apply
    @apply_id = params[:id].to_i
    @old_id = @company.get_config("apply_id")
    @company.set_config("apply_id", @apply_id)
  end

  def show_apply
    @apply_id = params[:id].to_i
    @old_id = @company.get_config("apply_id")
    @company.set_config("apply_id", @apply_id)
  end

  def submit_edit_apply
    @apply = ApplyInfo.get_id(@company, params[:id]).first
    @apply.edit_apply(params[:title]);
  end
end
