json.extract! user, :id, :name, :username, :password, :email, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
json.avatar_url polymorphic_url(user.avatar)
