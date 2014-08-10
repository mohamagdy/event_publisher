require 'rails_helper'

RSpec.describe "articles/edit", :type => :view do
  before(:each) do
    @article = assign(:article, Article.create!(
      :name => "MyString",
      :content => "MyText",
      :author_id => 1
    ))
  end

  it "renders the edit article form" do
    render

    assert_select "form[action=?][method=?]", article_path(@article), "post" do

      assert_select "input#article_name[name=?]", "article[name]"

      assert_select "textarea#article_content[name=?]", "article[content]"

      assert_select "input#article_author_id[name=?]", "article[author_id]"
    end
  end
end
