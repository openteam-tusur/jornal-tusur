class ArticleAuthor < ActiveRecord::Base
  belongs_to :article
  belongs_to :author
end

# == Schema Information
#
# Table name: article_authors
#
#  id         :integer          not null, primary key
#  article_id :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_article_authors_on_article_id  (article_id)
#  index_article_authors_on_author_id   (author_id)
#
# Foreign Keys
#
#  fk_rails_1b41504f0f  (article_id => articles.id)
#  fk_rails_88fdd15289  (author_id => authors.id)
#
