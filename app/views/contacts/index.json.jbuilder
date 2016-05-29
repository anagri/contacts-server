json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :profile_pic
  json.url contact_url(contact, format: :json)
end
