require 'rails_helper'

RSpec.describe Article, type: :model do
  it "使用者可以新增文章" do
    article = create(:article)

    p article
  end
end
