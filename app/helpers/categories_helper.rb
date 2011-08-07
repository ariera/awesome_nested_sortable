module CategoriesHelper
  def nested_list(categories, &block)
    return "" if categories.blank?
    html = "<ul>"
    categories.each do |cat|
      html << "<li id='category_#{cat.id}'>"
      html << capture(cat,&block)
      html << nested_list(cat.children, &block)
      html << "</li>"
    end
    html << "</ul>"
    html.html_safe
  end
end
