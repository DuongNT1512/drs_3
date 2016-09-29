module ApplicationHelper
  def full_title page_title = ""
    base_title = t "footer.page_name"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def current_user? user
    current_user == user
  end

  def index_for_pages index, page
    index = index + 1 + (page ? (page.to_i - 1) * Settings.page : 0)
  end
end
