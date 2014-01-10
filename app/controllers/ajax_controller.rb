#coding: utf-8
class AjaxController < ApplicationController
  before_filter :find_apply
  include ApplicationHelper
  def test
  end

	def share
    @share_content = "我##{@apply.name}#申请已经成功提交啦！想申请的同学请抓紧了哦！现在申请还有好礼哟，童鞋们，走过路过不要错过哦、详情戳我：http://e.weibo.com/#{@company.cid}/app_#{SNS['appkey']}"
	end 

	def submit_share
    begin
      @e = false
      desp = params[:share_content]
      SinaClient.add_focus(@company.cid, @user.sns_token) if params[:share_checkbox]
      SinaClient.put_url(desp, nil, @user.sns_token)
    rescue Exception => e
      @e = true
    end

	end

end

