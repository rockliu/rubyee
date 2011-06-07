module EntriesHelper
  def blog_title(user)
    if user.blog_title?
      user.blog_title
    else
      user.username + "的技术博客"
    end
  end
end
