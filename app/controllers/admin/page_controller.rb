#coding:utf-8
class Admin::PageController < ApplicationController
  include ApplicationHelper
	before_filter :apply_manager
	layout "manager"
  def index
  end

  def add_element
    id = RedisClient.update_or_get_apply_id(@company.id)
    render :partial => "/admin/page/#{params[:id]}", :locals => {:id => id, :hash => {}}
  end

  def edit_must
    @id = params[:id]
    @type = if params[:type] == "name"
              "姓名"
            elsif params[:type] == "sex"
              "性别"
            elsif params[:type] == "age"
              "年龄"
            elsif params[:type] == "birthday"
              "生日"
            elsif params[:type] == "region"
              "地区"
            elsif params[:type] == "card"
              "身份证"
            elsif params[:type] == "email"
              "邮箱"
            elsif params[:type] == "tel"
              "手机"
            elsif params[:type] == "attention"
              "关注"
            else
              "文字"
            end
    @must = params[:must]
  end

  def edit_attention
    @id = params[:id]
    @checked = params[:checked]
    @text = params[:text]
  end

  def edit_writing
    @id = params[:id]
    @text = params[:text]
  end

  def edit_text
    @id = params[:id]
    @must = params[:must]
  end

  def edit_checkbox
    @id = params[:id]
    @must = params[:must]
  end

  def edit_radio
    @id = params[:id]
    @must = params[:must]
  end

  def edit_select
    @id = params[:id]
    @must = params[:must]
  end

  def edit_date
    @id = params[:id]
    @must = params[:must]
  end

  def edit_file
    @id = params[:id]
    @must = params[:must]
  end

  def submit_page
    @apply.save_config(params[:form_color], params[:writing_color], params[:button_color], params[:opacity], params[:height], params[:top_left], params[:list])
    redirect_to manager_link("/admin/page/index")
  end

  def bg_images
    
  end

  def save_bg_images
    image = Backdrop.save_back_image(params[:back_file])
    render :json => {:id => image.id, :url => image.get_image("back"), :img_show => @apply.get_config("img_show")}
  end

  def submit_back_img
    @apply.save_back(Backdrop.find params[:file_id]) if !params[:file_id].blank?
    @apply.set_config("img_show", params[:imgshowstyle])
    redirect_to manager_link("/admin/page/index?apply_id=#{@apply.id}")
  end

  def up_bg_images
    tt = ''
    tt = "<img src=\"#{@apply.img_url}\" />"
    render :text => tt
  end

end
