FactoryBot.define do
  factory :address do
    street { "MyString" }
    suburb { "MyString" }
    postcode { "MyString" }
    state { "MyString" }
    gig { nil }
  end
end
