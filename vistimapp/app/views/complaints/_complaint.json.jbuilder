json.extract! complaint, :id, :user_id, :category_id, :entity_id, :title, :content, :created_at, :updated_at
json.url complaint_url(complaint, format: :json)
