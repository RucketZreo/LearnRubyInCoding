json.array!(@users) do |user|
  json.extract! user, :id, :UserName, :EMail, :TelPhoneNo
  json.url user_url(user, format: :json)
end
