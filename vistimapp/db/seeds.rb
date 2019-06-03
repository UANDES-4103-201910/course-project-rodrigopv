User.create!([
  {name: "Rodrigo", username: "lrpena", password: "123456", password_confirmation: "123456", email: "lrpena@miuandes.cl", role: "superadmin"},
  {name: "Claudio", username: "calvarez1", password: "123456", password_confirmation: "123456" email: "calvarez1@miuandes.cl", role: "admin"}
  {name: "Claudigo", username: "claudigo", password: "123456", password_confirmation: "123456",  email: "claudigo@miuandes.cl", role: ""}
])

@rodrigo = User.find_by(username: "lrpena")
@rodrigo.add_role(:superadmin)

@claudio = User.find_by(username: "calvarez1")
@claudio.add_role(:admin)

@claudigo = User.find_by(username: "claudigo")
@claudigo.add_role(:registered)

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
