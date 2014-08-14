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


user1 = User.create!(name: 'Maxime', lastName: 'Prudhomme', password:'12345678', email:'prudhommemaxime@gmail.com', money: '20',
           phone:'0601280156',biography:'Bla Bla Biographie',isPremium:false,level_id:l1.id,address_id:a1.id,
           email_confirmation:'prudhommemaxime@gmail.com',password_confirmation:'12345678',accept_conditions:true, isAdmin:true, isBanned:false)


a2 = Address.create(label:'rue Nationale Lille 59000', y: 50.6328407, x: 3.0527592999999342,region:'Nord-Pas-de-Calais', ville: 'Lille')
l2 = Level.create(levelUser:1,XPUser:0)


user2 = User.create!(name: 'Maxime', lastName: 'Boutrouille', password:'12345678', email:'maxime.boutrouille@gmail.com', money: '1337',
           phone:'0601280156',biography:'Bla Bla Biographie',isPremium:false,level_id:l2.id,address_id:a2.id,
           email_confirmation:'maxime.boutrouille@gmail.com',password_confirmation:'12345678',accept_conditions:true, isAdmin:true, isBanned:false)

a3 = Address.create(label:'83 rue Jacquemars gielee', y: 50.6341846, x: 3.054211699999996,region:'Nord-Pas-de-Calais', ville: 'Lille')
l3 = Level.create(levelUser:1,XPUser:0)


user3 = User.create!(name: 'Xavier', lastName: 'Koma', password:'12345678', email:'xavier.koma@gmail.com', money: '20',
           phone:'0601280156',biography:'Bla Bla Biographie',isPremium:false,level_id:l3.id,address_id:a3.id,
           email_confirmation:'xavier.koma@gmail.com',password_confirmation:'12345678',accept_conditions:true, isAdmin:true, isBanned:false)

a4 = Address.create(label:'25 rue Royale 59150 Wattrelos', y: 50.6394923, x: 3.0580426000000216,region:'Nord-Pas-de-Calais', ville: 'Wattrelos')
l4 = Level.create(levelUser:1,XPUser:0)


user4 = User.create!(name: 'Julien', lastName: 'Duquesnoy', password:'12345678', email:'djulien59@hotmail.fr', money: '9999',
           phone:'0619333333',biography:'Bla Bla Biographie',isPremium:true,level_id:l4.id,address_id:a4.id,
           email_confirmation:'djulien59@hotmail.fr',password_confirmation:'12345678',accept_conditions:true, isAdmin:true, isBanned:false)

a5 = Address.create(label:'25 rue de Calais', y: 50.634398, x: 3.044907500000022, region:'Nord-Pas-de-Calais', ville: 'Lille')
l5 = Level.create(levelUser:1,XPUser:0)

           
Hobby.create(label:'Informatique')
Hobby.create(label:'Natation')
Hobby.create(label:'MANGER')
Hobby.create(label:'Les légendes de la ligue')
Hobby.create(label:'Champs de bataille 4')
Hobby.create(label:'Mécanique')
Hobby.create(label:'Lecture')


s1 = Service.create(title: 'cours informatique',price: 4,description: 'JE SUIS UN GEEK',disponibility: 'quand tu veux bb',
               isGiven: true, isFinished: false, private: false,
               address_id: a1.id,category_id: c1.id,user_id:user1.id)


s2 = Service.create(title: 'cours Rails',price: 5,description: 'Ruby !!',disponibility: 'a partir de 18h',
               isGiven: false, isFinished: false, private: false,
               address_id: a2.id,category_id: c1.id,user_id:user2.id)


s3 = Service.create(title: 'Jardinage',price: 2,description: 'surtout les fleurs',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false, private: false,
               address_id: a3.id,category_id: c2.id,user_id:user3.id)


s4 = Service.create(title: 'BabySitting',price: 5,description: 'serieux et disponible',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false, private: false,
               address_id: a4.id,category_id: c3.id,user_id:user4.id)


Service.create(title: 'cours BDD',price: 3,description: 'Love Francis',disponibility: 'a partir de 18h',
               isGiven: false, isFinished: false, private: false,
               address_id: a4.id,category_id: c1.id,user_id:user1.id)


Service.create(title: 'Coupe de cheveux',price: 6,description: 'Etudiant',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false, private: false,
               address_id: a5.id,category_id: c3.id,user_id:user2.id)


Service.create(title: 'cours de piano',price: 8,description: 'medaille dor',disponibility: 'a partir de 18h',
               isGiven: false, isFinished: false, private: false,
               address_id: a1.id,category_id: c4.id,user_id:user4.id)

Proposition.create(isPaid: nil, isAccepted: false, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: false, motifCancelled: 'Je ne suis pas dispo ce jour là.', proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user2.id, service_id:s1.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user3.id, service_id:s1.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s1.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user3.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s2.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user2.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user4.id, service_id:s3.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user1.id, service_id:s4.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user2.id, service_id:s4.id, price:1)
Proposition.create(isPaid: nil, isAccepted: nil, motifCancelled: nil, proposition: Time.now, comment: 'Je suis très intéressé !', user_id:user3.id, service_id:s4.id, price:1)


Badge.create(label: '1 an de service')
Badge.create(label: '2 ans de service')
Badge.create(label: '3 ans de service')
Badge.create(label: 'Gazouillis: A partagé son service sur twitter')
Badge.create(label: 'Mark-moi: A partagé son service sur Facebook')
Badge.create(label: 'Compagnon : Follow un membre')
Badge.create(label: 'PREMIUM : A acheté un abonnement premium')
Badge.create(label: 'Shopping: A acheter des HP à la boutique')
Badge.create(label: 'Fauché: Ne possède plus aucun HP')
Badge.create(label: 'Mécène: Donateur')
Badge.create(label: 'Beau-parleur : A écrit sur le mur des hobbies')
Badge.create(label: 'Beta-testeur: A utilisé le site lors de la beta')
Badge.create(label: 'Coup de coeur : A aimé le service rendu par un membre')
Badge.create(label: 'Mystère : Ce badge reste un mystère')
Badge.create(label: 'Comme sur des roulettes! : transaction abouti entre deux membres')
Badge.create(label: 'à définir')
Badge.create(label: 'Surprise : Vous avez reçu un cadeau de Syra')
Badge.create(label: 'Pigeon voyageur : Nous a envoyé une carte postale')
Badge.create(label: 'Service : A répondu à un service')
Badge.create(label: 'Première classe')
Badge.create(label: 'Caporal')
Badge.create(label: 'Sergent')
Badge.create(label: 'Adjudant')
Badge.create(label: 'Lieutnant')
Badge.create(label: 'Tu peux me rendre un service : A répondu à un service')
Badge.create(label: 'Tu peux me rendre 10 service : A répondu à 10 services')
Badge.create(label: 'Tu peux me rendre 100 service : A répondu à 100 services')