
User.create!([
    {name: "Rodrigo", username: "lrpena", password: "123456", password_confirmation: "123456", email: "lrpena@miuandes.cl", role: "superadmin"},
    {name: "Claudigo", username: "claudigo", password: "123456", password_confirmation: "123456",  email: "claudigo@miuandes.cl", role: ""}
  ])

claudio = User.create!({name: "Claudio", username: "calvarez1", password: "123456", password_confirmation: "123456", email: "calvarez1@miuandes.cl", role: "admin"})
claudio.bio = "
Professor Claudio Álvarez is a Civil Engineer from the Pontificia Universidad Católica de Chile (2008), with a Master's degree in Engineering Science (2008) and a PhD in Engineering Sciences from the same university (2011). He carried out his doctoral research under the supervision of Miguel Nussbaum. He joined the Universidad de los Andes in 2012 and since 2015 he is the coordinator of the specialty of Civil Engineering in Computer Science.

His research is focused on the design, implementation and evaluation of educational technology in large classrooms. It has focused on the implementation of interactive learning environments using mobile devices, to support the development of problem solving activities."
claudio.save

cgarcia = User.create!({name: "Cristian Garcia", username: "cgarcia7", password: "123456", password_confirmation: "123456", 
                         email: "lrpena+cgarcia7@miuandes.cl", role: ""
                        })

cgarcia.avatar.attach(
    io: File.open('seed_imgs/douche.jpg'),
    filename: 'douche.jpg'
)
cgarcia.bio = "I don't care about this site at all"
cgarcia.save

claudio.avatar.attach(
    io: File.open('seed_imgs/claudio.jpg'),
    filename: 'klauss.jpg'

)

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
  { user_id: 1, category_id: 1, entity_id: 1, title: "My spaghetti not likey", 
    content: "please fixx thx", dumpster: false,
    lat: "-33.4043009", lng: "-70.50640820000001" 
  },
  {user_id: User.last.id, category_id: 1, entity_id: 1, title: "Fuck this site", content: "i don't care about the terms of use, please delete me", dumpster: true },
])

cristian_complaint = Complaint.find_by(id: 2)
cristian_complaint.main_image.attach(
    io: File.open('seed_imgs/elmo.jpg'),
    filename: 'elmo.jpg'
)
cristian_complaint.media.attach(
    io: File.open('seed_imgs/elmo.jpg'),
    filename: 'elmo.jpg'
)
cristian_complaint.media.attach(
    io: File.open('seed_imgs/elmo.jpg'),
    filename: 'elmo.jpg'
)
cristian_complaint.media.attach(
    io: File.open('seed_imgs/elmo.jpg'),
    filename: 'elmo.jpg'
)
cristian_complaint.media.attach(
    io: File.open('seed_imgs/elmo.jpg'),
    filename: 'elmo.jpg'
)


Comment.create!({"user_id": 1, "content": "I agree.", "complaint_id": 1 })

puts "Rude comment insert"

Comment.create!({"user_id": 2, "content": "How rude! I've flagged this post", "complaint_id": 2 })

#<Complaint id: 4, user_id: 1, category_id: 1, entity_id: 1, title: "Rancagua doesn't exists!!", content: "Hi,\r\n\r\nI'm very angry because Google says that Ran...", created_at: "2019-06-10 04:28:15", updated_at: "2019-06-10 04:28:15", likers_count: 1, 
# dumpster: nil, lat: "-34.17013240000001", lng: "-70.7406259"> 
puts "Rancagua complaint insert"


claudio_complaint = Complaint.create!(
   { user_id: claudio.id, category_id: 1, entity_id: 1,
     title: "Computers are slow!",
     content: "Hi, my students are having a lot of issues with computers located at the main building of the university. Python would take even 5 minutes to load, or also might don't have Python installed at all, please help",
     dumpster: false,
     lat: "-33.4043009",
     lng: "-70.50640820000001", 
   
})

claudio_complaint.main_image.attach(
    io: File.open('seed_imgs/louvre.jpg'),
    filename: 'louvre.jpg'
)

claudio_complaint.media.attach(
    io: File.open('seed_imgs/computer.jpg'),
    filename: 'computer.jpg'

)
claudio_complaint.media.attach(
    io: File.open('seed_imgs/waiting.jpg'),
    filename: 'waiting.jpg'

)
rancagua_complaint = Complaint.create!(
   {  user_id: 1, category_id: 1, entity_id: 1, 
        title: "Rancagua doesn't exists!", 
      content: "Hi, I'm very angry because Google says that Rancagua has an actual coordinate on the world map. If you don't believe me, i'm putting the location of this complaint right at the fake location of the city.", 
     dumpster: false,
          lat: "-34.17013240000001",
          lng: "-70.7406259"  
   })

rancagua_complaint.main_image.attach(
    io: File.open('seed_imgs/rancagua.jpg'),
    filename: 'rancagua.jpg'
  )
rancagua_complaint.media.attach(
    io: File.open('seed_imgs/klauss.jpg'),
    filename: 'klauss.jpg'
  )
Comment.create!({ user_id: 2, content: "Please call the NSA, this is a serious issue.", 
                  complaint_id: rancagua_complaint.id })
Comment.create!({ user_id: cgarcia.id, content: "I don't care at all.", 
                  complaint_id: rancagua_complaint.id })

