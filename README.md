# Reservation Buddy

Reservation Buddy is an hotel reservation system demo made with [shakacode/rescript-react-on-rails](https://github.com/shakacode/rescript-react-on-rails).

## Installation

```bash
bundle
yarn
rails db:create
rails db:migrate
rails db:seed
```

## Run the app

In two separate terminals run the following commands

```bash
yarn run re:start
rails s
```

## To run the test suite

```bash
bundle exec rspec
```

## Seed credentials

- Admin:

  - **Email:** admin@admin.com
  - **Password:** password1

- Customer:
  - **Email:** johndoe@gmail.com
  - **Password:** password1

## Postman

[Documentation link](https://documenter.getpostman.com/view/14307895/UyrEgEsA).

## Entity Relationship Diagram (ERD)

![Reservation Buddy ERD](https://lucid.app/publicSegments/view/9c25395f-c0c3-45a6-8526-046a81b732be/image.png "Reservation Buddy ERD")

You can edit the ERD, you can request edit access through this [link](https://lucid.app/lucidchart/037b5f25-5a82-4836-a722-07645882489b/edit?invitationId=inv_36d4fc4b-de58-469c-a8d3-c89d150706d9).

## Features

- As an Admin you can:

  - Login to the admin panel.
  - Add new hotel.
  - Delete a hotel.
  - Browse, sort, paginate, and search all hotels, customers, and reservations.
  - Logout.

- As a customer you can:
  - Register as user.
  - Login as user.
  - Search for a hotel by name or city.
  - Reserve a hotel.
  - Browse your past reservations.
  - Logout.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
