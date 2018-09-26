module ApplicationHelper
  def breed_name_options_for_select(names, selected_value)
    options_for_select(names.map { |e| [e.split('/').reverse.join(' ').titleize, e] }, selected_value)
  end
end
