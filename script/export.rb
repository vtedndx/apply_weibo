#coding: utf-8
require 'spreadsheet'
book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet

sheet1.row(0).push "cid"
sheet1.row(0).push "企业名"
sheet1.row(0).push "安装时间"

coms = Company.order("id asc")
coms.each_with_index do |com, index|
	sheet1.row(index + 1).push com.cid
	sheet1.row(index + 1).push com.sns_uname
	sheet1.row(index + 1).push com.created_at.strftime("%Y-%m-%d %H:%M")
end

book.write "申请单_#{Time.now.strftime("%m月%d日")}.xls"


