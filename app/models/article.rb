class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  
  before_save :update_article_name
  private
    def update_article_name
      self.title.upcase!
      self.body.downcase!
    end

end
