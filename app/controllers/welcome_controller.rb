#encoding: utf-8
class WelcomeController < ApplicationController

  include ApplicationHelper
  skip_before_filter :check_and_switch_and_find

  def index
  end

  def callback
    # begin
      @token = client.auth_code.get_token(params["code"], :parse => :json,:redirect_uri =>"#{SNS['re_url']}")
      oauth = WeiboV3::OAuth2.new.authorize_from_access(@token.token,SNS['re_url'],SNS['appkey'], SNS['appsecret'])
      uid = JSON.parse(WeiboV3::Base.new(oauth).user_uid(@token.token).body)["uid"]
      sina_user = SinaClient.merge_info(JSON.parse(WeiboV3::Base.new(oauth).user(uid).body))
      @user = User.save_or_update_user(sina_user,@token.token)
      Company.save_user_company(@user, @token.token)
    # rescue Exception => e
    #   @token_error = true
    # end
    render :layout => nil
  end

  def canceltoken
    render :layout => nil
  end

private
  def client
    client ||= OAuth2::Client.new(
                               SNS['appkey'], SNS['appsecret'],
                               :site => 'https://api.weibo.com',
                               :token_url => '/2/oauth2/access_token',
                               :authorize_url => '/2/oauth2/authorize')
  end

end
