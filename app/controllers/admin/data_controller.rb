#coding: utf-8
class Admin::DataController < ApplicationController
	before_filter :apply_manager
	layout "manager"
  include ApplicationHelper

  def index
    @fans_type = params[:fans_type].to_i
    @create_type = params[:create_type].to_i
    user_ids = RedisClient.get_apply_to_user_array(@apply.id)
    @pis =  unless user_ids.blank?
              @v = params[:v]
              @sex = params[:sex]
              @pro = params[:pro]
              @city = params[:city]
              hash = {:verified_type => is_v(@v),
              :gender => is_girl_boy(@sex),
              :location => is_pro_city(@pro, @city)}

              @user_ids = if @create_type == 1
                            user_ids = RedisClient.get_apply_to_user_array_order(@apply.id)
                            User.select("id").where("id in(?)", user_ids).where(hash).order("find_in_set(id, '#{user_ids.join(",")}')").page(params[:page]).per(12)
                          else
                            User.select("id").where("id in(?)", user_ids).where(hash).order("fans #{["asc", "desc"][@fans_type]}").page(params[:page]).per(12)
                          end
              PostInfo.get_list_users(@company.id, @apply.id, @user_ids.collect(&:id)).order("find_in_set(user_id, '#{@user_ids.collect(&:id).join(",")}')").includes(:user)
            end
  end

  def out_xls
    user_array = RedisClient.get_apply_to_user_array(@apply.id)
    @pis =  if user_array.blank?
              PostInfo.get_list(@company.id, @apply.id).includes(:user)
            else
              PostInfo.get_list_users(@company.id, @apply.id, user_array).order("find_in_set(user_id, '#{user_array.join(",")}')").includes(:user)
            end
  end

  def cancellist
    @user = User.find(params[:id])
    @list = List.get_u_id(@company, @apply.id, params[:id]).first
    @list.del_list unless @list.blank?
  end

  def addlist
    @user = User.find(params[:id]) 
    @list = List.get_u_id(@company.id, @apply.id, params[:id].to_i).first

    if @list.blank?  
      List.save_list(@company.id, @apply.id, params[:id].to_i)
    else
      @list.add_list
    end
  end

  def send_data
    a = Attach.where("id = ?", params[:link].to_i).first
    link = a.avatar.url.gsub(/\?.*/, "")    
    link = "public" + link
    send_file "#{link}"
  end
end
