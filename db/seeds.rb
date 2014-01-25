# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create({email: 'admin@site.com', name: 'Admin', password: '123456', avatar: 'http://www.murketing.com/journal/wp-content/uploads/2009/04/8tracks.jpg' })
admin.update_attribute("admin", 1)

user = User.create({email: 'jenny@site.com', name: 'Jenny Renny', password: '123456', avatar: 'http://seeyprofile.com/design/main/images/default_avatar_female.jpg'})
user = User.create({email: 'tim@site.com', name: 'Tim Jim', password: '123456', avatar: 'http://www.dotnetcodesg.com/Register/UserImage/Default.png'})
user = User.create({email: 'dave@site.com', name: 'Dave Cave', password: '123456'})
user = User.create({email: 'mark@site.com', name: 'Mark Park', password: '123456'})


book1 = Book.create({
  title: "Harry Potter", 
  author: "JK Rowling", 
  description: "Harry Potter has never played a sport while flying on a broomstick. He's never worn a Cloak of Invisibility, befriended a giant, or helped hatch a dragon. All Harry knows is a miserable life with the Dursleys, his horrible aunt and uncle, and their abominable son, Dudley. Harry's room is a tiny cupboard under the stairs, and he hasn't had a birthday party in ten years.

But all that is about to change when a mysterious letter arrives by owl messenger: a letter with an invitation to a wonderful place he never dreamed existed. There he finds not only friends, aerial sports, and magic around every corner, but a great destiny that's been waiting for him... if Harry can survive the encounter.", 
  cover: "http://www.hp-lexicon.org/images/covers/1-ps-covers/500x710xss-front-710px.jpg.pagespeed.ic.17FlJpTzga.jpg"})
Book.create({
  title: "Twilight", 
  author: "Stephanie Meyers", 
  description: "Isabella Swan's move to Forks, a perpetually rainy town in Washington, could have been the most boring move she ever made. When she meets the mysterious, alluring Edward Cullen--a vampire--her life takes a thrilling and terrifying romantic turn. Young Adult", 
  cover: "http://awaitingthemuse.files.wordpress.com/2012/12/twilight-book-cover.jpg"})
Book.create({
  title: "The Fellowship of the Ring (The Lord of the Rings #1)", 
  author: "JRR Tolkien", 
  description: "Frodo Baggins knew the Ringwraiths were searching for him - and the Ring of Power he bore that would enable Sauron to destroy all that was good in Middle-earth. Now it was up to Frodo and his faithful servant Sam to carry the Ring to where it could be detroyed - in the very center of Sauron's dark kingdom.", 
  cover: "http://www.geofftaylor-artist.com/system/files/imagecache/normal/covers/tolkien-fellowship_of_the_ring1.jpg"})

admin = User.first

3.times do |t|
  Question.create({book_id: Book.all[t].id, user_id: admin.id, name: "What didn't you like about #{Book.all[t].title}?", description: "For example, the plot, the setting, the characters."})
  Question.create({book_id: Book.all[t].id, user_id: admin.id, name: "What was your favorite thing about #{Book.all[t].title}?", description: "For example, the plot, the setting, the characters."})
  Question.create({book_id: Book.all[t].id, user_id: admin.id, name: "Which of the main characters from #{Book.all[t].title} did you relate to the most?", description: "In what way did you relate to this character? Emotionally, Physically, Politically?"})
  Question.create({book_id: Book.all[t].id, user_id: admin.id, name: "What did the author mean when saying 'some words' in lines 23-24?"})
end