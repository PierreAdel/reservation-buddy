# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


customers = Customer.create([
  { 
    name: "John Doe",
    email: "pierreadelkamel@gmail.com",
    password: "password1"
  }, 

  { 
    name: "Doe John",
    email: "Doe@gmail.com",
    password: "password1"
  }, 

  { 
    name: "John John",
    email: "John@gmail.com",
    password: "password1"
  }, 
])

admins = Admin.create([
  { 
    name: "Admin John Doe",
    email: "Adminpierreadelkamel@gmail.com",
    password_digest: "password1"
  }, 

  { 
    name: "Admin Doe John",
    email: "AdminDoe@gmail.com",
    password_digest: "password1"
  }, 

  { 
    name: "Admin John John",
    email: "AdminJohn@gmail.com",
    password_digest: "password1"
  }, 
])

reservations = Reservation.create([
  { 
    date_from: DateTime.strptime("09/14/2022", "%m/%d/%Y"),
    date_to: DateTime.strptime("09/16/2022", "%m/%d/%Y"),
    hotel: Hotel.first,
    customer: Customer.first
  }, 
  { 
    date_from: DateTime.strptime("09/14/2022", "%m/%d/%Y"),
    date_to: DateTime.strptime("09/17/2022", "%m/%d/%Y"),
    hotel: Hotel.last,
    customer: Customer.last
  }, 
  
])


hotels = Hotel.create([
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel",
    score: 5,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel",
    score: 2,
    price_per_night:99,
    admin: Admin.last
  },  
  
])



