# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


User.delete_all
Address.delete_all
Level.delete_all
Service.delete_all
Category.delete_all
Proposition.delete_all


c1 = Category.create(name: 'informatique')
c2 = Category.create(name: 'jardinage')
c3 = Category.create(name: 'aide a domicile')
c4 = Category.create(name: 'musique')

a1 = Address.create(label:'185 Residence Sophora 59283 Moncheaux', y: 50.4528437, x: 3.0832348999999795,region:'Nord-Pas-de-Calais', ville: 'Moncheaux')
l1 = Level.create(levelUser:1,XPUser:0)


user1 = User.create!(name: 'Maxime', lastName: 'Prudhomme', password:'12345678', email:'prudhommemaxime@gmail.com', money: '12',
           phone:'0601280156',biography:'Bla Bla Biographie',isPremium:false,level_id:l1.id,address_id:a1.id,
           email_confirmation:'prudhommemaxime@gmail.com',password_confirmation:'12345678',accept_conditions:true, isAdmin:true)


a2 = Address.create(label:'rue Nationale Lille 59000', y: 50.6328407, x: 3.0527592999999342,region:'Nord-Pas-de-Calais', ville: 'Lille')
l2 = Level.create(levelUser:1,XPUser:0)


user2 = User.create!(name: 'Maxime', lastName: 'Boutrouille', password:'12345678', email:'boutrouillemaxime@gmail.com', money: '12',
           phone:'0601280156',biography:'Bla Bla Biographie',isPremium:false,level_id:l2.id,address_id:a2.id,
           email_confirmation:'boutrouillemaxime@gmail.com',password_confirmation:'12345678',accept_conditions:true, isAdmin:true)

a3 = Address.create(label:'83 rue Jacquemars gielee', y: 50.6341846, x: 3.054211699999996,region:'Nord-Pas-de-Calais', ville: 'Lille')
l3 = Level.create(levelUser:1,XPUser:0)


user3 = User.create!(name: 'Xavier', lastName: 'Koma', password:'12345678', email:'xavierkoma@gmail.com', money: '12',
           phone:'0601280156',biography:'Bla Bla Biographie',isPremium:false,level_id:l3.id,address_id:a3.id,
           email_confirmation:'xavierkoma@gmail.com',password_confirmation:'12345678',accept_conditions:true, isAdmin:true)

a4 = Address.create(label:'25 rue Royale', y: 50.6394923, x: 3.0580426000000216,region:'Nord-Pas-de-Calais', ville: 'Lille')
l4 = Level.create(levelUser:1,XPUser:0)


user4 = User.create!(name: 'Julien', lastName: 'Duquesnoy', password:'12345678', email:'djulien59@hotmail.fr', money: '9999',
           phone:'0619333333',biography:'Bla Bla Biographie',isPremium:true,level_id:l4.id,address_id:a4.id,
           email_confirmation:'djulien59@hotmail.fr',password_confirmation:'12345678',accept_conditions:true, isAdmin:true)

a5 = Address.create(label:'25 rue de Calais', y: 50.634398, x: 3.044907500000022, region:'Nord-Pas-de-Calais', ville: 'Lille')
l5 = Level.create(levelUser:1,XPUser:0)


#user5 = User.create!(name: 'Terry', lastName: 'Mainvis', password:'12345678', email:'terry.mainvis@gmail.com', money: '12',
 #          phone:'0600000000',biography:'Bla Bla Biographie',isPremium:false,level_id:l5.id,address_id:a5.id,
#           email_confirmation:'terry.mainvis@gmail.com',password_confirmation:'12345678',accept_conditions:true)
           
Hobby.create(label:'Informatique')
Hobby.create(label:'Natation')
Hobby.create(label:'MANGER')
Hobby.create(label:'Les légendes de la ligue')
Hobby.create(label:'Champs de bataille 4')
Hobby.create(label:'Mécanique')
Hobby.create(label:'Lecture')


s1 = Service.create(title: 'cours informatique',price: 20,description: 'JE SUIS UN GEEK',disponibility: 'quand tu veux bb',
               isGiven: true, isFinished: true,
               address_id: a1.id,category_id: c1.id,user_id:user2.id)


s2 = Service.create(title: 'cours Rails',price: 30,description: 'Ruby !!',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: a2.id,category_id: c1.id,user_id:user2.id)


s3 = Service.create(title: 'Jardinage',price: 30,description: 'surtout les fleurs',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: a3.id,category_id: c2.id,user_id:user1.id)


Service.create(title: 'BabySitting',price: 40,description: 'serieux et disponible',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: a4.id,category_id: c3.id,user_id:user1.id)


Service.create(title: 'cours BDD',price: 30,description: 'Love Francis',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: a4.id,category_id: c1.id,user_id:user1.id)


Service.create(title: 'Coupe de cheveux',price: 30,description: 'Etudiant',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: a5.id,category_id: c3.id,user_id:user1.id)


Service.create(title: 'cours de piano',price: 30,description: 'medaille dor',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: a1.id,category_id: c4.id,user_id:user1.id)

Proposition.create(isPaid: false, isAccepted: false, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s1.id, price:1)
Proposition.create(isPaid: false, isAccepted: false, motifCancelled: 'Je ne suis pas dispo ce jour là.', proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: true, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: true, isAccepted: true, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: false, isAccepted: true, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
