json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :profile_pic
  json.favorite contact.favorite ? true : false
  json.url contact_url(contact, format: :json)
end
