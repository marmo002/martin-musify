FactoryBot.define do
    factory :venue do
        venue_tm_id "test"
        name "test venue"
        address_1 "place at place"
        address_2 "place at place"
        city "toronto"
        province "ontario"
        postal_code "l1l1l1"
        country "canada"
        phone_number "1800-000-000"
        created_at Time.now
        updated_at Time.now
        latitude 27.089798
        longitude -27.089798
        full_address "place at place toronto"
   end
end
