User.create!([
  {name: "Rodrigo", username: "lrpena", password: "lala", email: "lrpena@miuandes.cl", role: "superadmin"},
  {name: "Claudio", username: "calvarez1", password: "lala", email: "calvarez1@miuandes.cl", role: "user"}
])

Category.create!([
  {name: "Comida"}
])

EntityType.create!([
  {name: "Universidad"}
])

Entity.create!([
  {entity_type_id: 1, name: "Universidad de los Andes", description: nil}
])
Complaint.create!([
  {user_id: 1, category_id: 1, entity_id: 1, title: "My spaghetti not likey", content: "please fixx thx"}
])

Comment.create!({"user_id": 1, "content": "I agree.", "complaint_id": 1 })
