json.array!(@users) do |user|
  json.type "Feature"

  json.geometry do |json|
    json.type "Point"
    json.coordinates [user.longitude, user.latitude]
  end

  json.properties do |json|
    json.(user, :name, :username)
    json.product user.products.first
    json.title "<a href='#{user.products.first.link}'>#{user.products.first.name}</a> by <a href='http://twitter.com/#{user.username}'>#{user.name}</a>"
  end
end

  