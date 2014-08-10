class Article < ActiveRecord::Base
  attr_accessible :author_id, :content, :name
end
