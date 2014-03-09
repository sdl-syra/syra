# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

#User.create(name: 'Maxime', lastName: 'Prudhomme', password:'12345678', email:'prudhommemaxime@gmail.com')

Address.create(label:'5 rue Nationale Lille', x: 5, y: 4)

Service.create(title: 'cours informatique',price: 20,description: 'JE SUIS UN GEEK',disponibility: 'quand tu veux bb',
               isGiven: true, isFinished: true,
               address_id: 1,category_id: 1,user_id:1)


Service.create(title: 'cours Rails',price: 30,description: 'Ruby !!',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: 1,category_id: 1,user_id:1)


Service.create(title: 'Jardinage',price: 30,description: 'surtout les fleurs',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: 1,category_id: 1,user_id:1)


Service.create(title: 'BabySitting',price: 40,description: 'serieux et disponible',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: 1,category_id: 1,user_id:1)


Service.create(title: 'cours BDD',price: 30,description: 'Love Francis',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: 1,category_id: 1,user_id:1)


Service.create(title: 'Coupe de cheveux',price: 30,description: 'Etudiant',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: 1,category_id: 1,user_id:1)


Service.create(title: 'cours de piano',price: 30,description: 'medaille dor',disponibility: 'a partir de 18h',
               isGiven: true, isFinished: false,
               address_id: 1,category_id: 1,user_id:1)
