FactoryGirl.define do
  factory :bird, class: Bird do
    name 'Bird1' #+ rand(1..100).to_s
    family 'Family1' #+ rand(1..100).to_s
    continents ['asia', 'africa']
    added Time.now.utc.strftime('%Y-%m-%d')

    trait :invisible do
      visible false
    end

    trait :visible do
      visible true
    end

    factory :invisible_bird, traits: [:invisible]
    factory :visible_bird, traits: [:visible]
  end
end
