FactoryBot.define do
  factory :user do
    name       { Faker::Name.unique.name }
    username   { name.gsub(' ', '-') }
    password   { Faker::Internet.password }
    email      { Faker::Internet.safe_email(name.gsub(' ', '.')) }
    ip_address { Faker::Internet.public_ip_v4_address }

    factory :staff do
      role 'staff'
    end

    factory :admin do
      role 'admin'
    end

    factory :teacher do
      role 'teacher'

      trait :signed_up_with_google do
        signed_up_with_google true
        google_id { (1..21).map{(1..9).to_a.sample}.join } # mock a google id
        password { nil }
        username { nil }
      end

      trait :signed_up_with_clever do
        password { nil }
        username { nil }
        clever_id { (1..24).map{(('a'..'f').to_a + (1..9).to_a).sample}.join } # mock a clever id
      end

      trait :with_classrooms_students_and_activities do
        classrooms_i_teach { create_pair(:classroom_with_students_and_activities) }
      end
    end

    factory :student do
      role 'student'

      trait :signed_up_with_google do
        signed_up_with_google true
        google_id { (1..21).map{(1..9).to_a.sample}.join }
        password { nil }
        username { "#{name}@student" }
      end

      trait :signed_up_with_clever do
        password { nil }
        username { "#{name}@student" }
        clever_id { (1..24).map{(('a'..'f').to_a + (1..9).to_a).sample}.join } # mock a clever id
      end

      trait :in_one_classroom do
        classrooms { [FactoryBot.create(:classroom)] }
      end

      factory :student_with_many_activities do
        classrooms { [FactoryBot.create(:classroom)] }
        transient do
          activity_count 5
        end
        after(:create) do |user, evaluator|
          create_list(:activity_session, evaluator.activity_count, user: user)
        end
      end
    end
  end
end
