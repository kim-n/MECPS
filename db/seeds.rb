# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create({email: 'admin@site.com', name: 'Site Admin', password: '123456'})
admin.update_attribute("admin", 1)
user = User.create({email: 'user@site.com', name: 'Site User', password: '123456'})

book1 = Book.create({title: "Harry Potter", author: "JK Rowling", description: "You're a wizard Harry!", image: ":)"})
Book.create({title: "Twilight", author: "Stephanie Meyers", description: "Vampires and werewolves", image: ":("})
Book.create({title: "The Catcher in the Rye", author: "Some Dude", description: "That annoying kid", image: ":|"})

3.times do |t|
  Question.create({book_id: book1.id, user_id: admin.id, name: "Question#{t}", description: "This is a description of question #{t}."})
end