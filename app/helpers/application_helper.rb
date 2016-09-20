module ApplicationHelper
  def full_title page_title = ""
    base_title = t "footer.page_name"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
