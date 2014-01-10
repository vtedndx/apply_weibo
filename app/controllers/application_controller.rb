class ApplicationController < ActionController::Base
  before_filter :detection_url, :only => [:index]
  before_filter :check_and_switch_and_find
  protect_from_forgery

  private
	def detection_url
    redirect_to "http://www.iluopan.com" if controller_name == "apply" && params["cid"].blank? && params["esvd"].blank?
  end
  
  def check_and_switch_and_find
    if (request.env['HTTP_REFERER'].to_s =~ /e\.weibo\.com/ || request.env['HTTP_REFERER'].to_s =~ /weibo\.com/) && !params[:cid].blank?
      if params[:cid] == params[:viewer]
        @esvd = Security.encrypt(params[:cid])
      elsif !params[:viewer].blank?
        @esvud = Security.encrypt_uid(params[:viewer])
      end
    end

    if !params[:key].blank?
      target_url = params[:key].gsub(/^list/,"").gsub(/_/,"/").gsub(/\./,"_").gsub(/:/,"?").gsub(/\|/,"&")
      and_sym = target_url =~ /\?/ ? "&" : "?"
      target_url += and_sym + "viewer=#{params[:viewer]}&cid=#{params[:cid]}"
      target_url += "&esvd=#{@esvd}" if @esvd
      target_url += "&esvud=#{@esvud}" if @esvud
      redirect_to target_url
    end


    if !params[:cid].blank?
      @company = Company.find_or_create(params[:cid])
      @company.update_attribute(:sub_appkey, params[:sub_appkey]) if !params[:sub_appkey].blank? && @company.sub_appkey != params[:sub_appkey]

      @esvd = params[:esvd].to_s unless params[:esvd].blank?
      if Security.check(@esvd, params[:cid])
        @com = @company
        @user = @com.gen_installer
      end
      
      if @company && !params[:viewer].blank? 
        Visitor.add_record(@company.id, params[:viewer])
      end

    end
    
    if !params[:viewer].blank?
      if params[:viewer] == params[:cid] && request.env['HTTP_REFERER'].to_s.start_with?("http://e.weibo.com/thirdapp")
        @user = User.find_or_create(params[:viewer])
      elsif !params[:tokenString].blank?
        @user = User.save_user_oauth(@company, params[:viewer], params[:tokenString])
      elsif !params[:esvud].blank?
        @esvud = params[:esvud].to_s 
        @user = User.find_or_create(params[:viewer]) if Security.check_uid(@esvud, params[:viewer])
      end
    end
    @weibo_root = "http://e.weibo.com/#{@company.cid}/app_#{SNS["appkey"]}"
  end

  def find_apply
    @source = params[:source]
    apply_id = @source.blank? ? @company.get_config("apply_id") : params[:apply_id]
    @apply = ApplyInfo.get_id(@company.id, apply_id).get_status(0).first
  end

  def apply_manager
    # if @company.cid == ""
    #   @apply = ApplyInfo.where("id = ?", 874).first
    # else
      @apply = ApplyInfo.where("company_id = ? and id = ?", @company.id, params[:apply_id].to_i).first
    # end
  end
end
