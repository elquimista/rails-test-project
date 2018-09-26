module ApplicationHelper
  def breed_name_options_for_select(names)
    options_for_select(names.map { |e| [e.titleize, e.gsub(' ', '/')] })
  end
end
