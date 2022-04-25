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
    name: "Admin John2",
    email: "Admin@gmail.com",
    password: "password1"
  }, 

  { 
    name: "Admin Doe",
    email: "Doe@gmail.com",
    password: "password1"
  }, 

  { 
    name: "Admin Admin Admin",
    email: "AdminAdmin@gmail.com",
    password: "password1"
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
    hotel_name: "New Cairo Hotel1",
    score: 5.4,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel2",
    score: 2.1,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel3",
    score: 3.2,
    price_per_night:1000,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel4",
    score: 5.3,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel5",
    score: 2.4,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel6",
    score: 3.5,
    price_per_night:1000,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel7",
    score: 5.6,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel8",
    score: 2.7,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel9",
    score: 3.8,
    price_per_night:1000,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel11",
    score: 5.9,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel12",
    score: 2.4,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel13",
    score: 3.8,
    price_per_night:1000,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel14",
    score: 5.1,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel15",
    score: 2.2,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel16",
    score: 3.3,
    price_per_night:1000,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel17",
    score: 5.4,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel18",
    score: 2.5,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel19",
    score: 3.8,
    price_per_night:1000,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=",
    city: "Cairo",
    hotel_name: "New Cairo Hotel21",
    score: 5.6,
    price_per_night:20.25,
    admin: Admin.first
  }, 
  { 
    cover_image_url: "https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768",
    city: "Giza",
    hotel_name: "New Giza Hotel22",
    score: 2.9,
    price_per_night:99,
    admin: Admin.last
  },  
  { 
    cover_image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiR6Hq2-K9pNHC2vQvbmCTwQI2kzK9saJqK14JvoCk8aheX0ujIPEndLlQ_06a1sxWCgQ&usqp=CAU",
    city: "Alexandria",
    hotel_name: "New Alexandria Hotel23",
    score: 3.0,
    price_per_night:1000,
    admin: Admin.last
  },  
  
  
])



