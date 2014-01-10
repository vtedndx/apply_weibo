class ApplyElement < ActiveRecord::Base
  attr_accessible :apply_info_id, :config_hash, :element_id, :partial_name, :status
  belongs_to	:apply_infos 
  serialize :config_hash

  def self.result(apply)
    apply_elements = []
    form_css = apply.get_config(:form_css)
    word_css = apply.get_config(:word_css)
    button_css = apply.get_config(:button_css)
    transparency = apply.get_config(:transparency)
    tran_num = (apply.get_config(:transparency).to_f*100).to_i.to_s+"%"
    form_site_left = apply.get_config(:form_site,:left)
    form_site_top = apply.get_config(:form_site,:top)
    img_type = apply.get_config(:img_show)
    img_height = apply.get_config(:img_height)
    count_init = ApplyElement.where(["apply_info_id = ?", apply.id]).count
    elements_ids = apply.get_config(:elements_ids).to_a
    apply_elements = ApplyElement.where(["apply_info_id = ? AND element_id in (?) AND status = 1", apply.id, elements_ids]).order("find_in_set(element_id, '#{elements_ids.join(",")}')")

    [form_css,word_css,button_css,transparency , tran_num, form_site_left, form_site_top,
      img_type , img_height , count_init,apply_elements]
  end
  
  def set_config(key, value)
    self.config_hash ||= {}
    self.config_hash[key] ||= {}
    self.config_hash[key] = value
    self.save
  end

  def get_config(key)
    return nil if self.config_hash.blank?
    return self.config_hash[key]
  end

  def self.save_element(key,lists,apply)
    apply_element = ApplyElement.where(["apply_info_id = ? AND element_id = ? and status = 1", apply.id, key.to_i]).last
		apply_element ||= ApplyElement.new()
    apply_element.apply_info_id = apply.id
    apply_element.element_id = key.to_i
    apply_element.partial_name = lists[key][:partial_name]
    apply_element.status = 1
    apply_element.config_hash = {}
#    lists[key].delete_if {|key, value| key == "partial_name" || key == "status"}
    apply_element.config_hash[key] = lists[key]
    apply_element.save
    return apply_element
  end
end
