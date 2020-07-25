FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"1234567"}
    password_confirmation {"1234567"}
    family_name           {"阿部"}
    first_name            {"晋三"}
    kana_family_name      {"あべ"}
    kana_first_name       {"しんぞう"}
    birth_year            {"2011"}
    birth_month           {"1"}
    birth_day             {"1"}
  end

end