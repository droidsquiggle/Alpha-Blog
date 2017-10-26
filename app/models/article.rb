class Article < ActiveRecord::Base
  validates :title, prescense: true, length: {minimum: 3, maximum: 50}
  validates :description, prescense: true, length: {minimum: 10, maximum: 100}
end