# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article, :class => 'Article' do
    name "Article 1"
  end
end
