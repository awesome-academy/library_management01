module BooksHelper
  def get_authors name
    Author.order name
  end

  def get_categories name
    Category.order name
  end

  def get_publishers name
    Publisher.order name
  end

  def find_users id
    User.find_by id: id
  end
end
