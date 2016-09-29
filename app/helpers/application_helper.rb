module ApplicationHelper
  def full_title page_title = ""
    base_title = t "footer.page_name"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def current_user? user
    current_user == user
  end
end
