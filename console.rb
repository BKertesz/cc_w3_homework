require_relative("db/sql_runner")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/ticket")

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name'=>'Bryce','funds'=>'1200'})
customer1.save


film1 = Film.new({'title'=>'Generic Movie','price'=>'45'})
film1.save


customer1.buy_ticket(film1)
customer1.buy_ticket(film1)
customer1.buy_ticket(film1)
customer1.update

# Create screenings TABLE
# Create Screening class
# Screening class has a time and a tickets array?
# When buying ticket it adds it to the screening.tickets?



# p film1.customers

# customer1.funds -= film1.price
# return Ticket.new('customer_id'=>@id,'film_id'=>film.id)

# p Ticket.all

# ticket1 = Ticket.new({'customer_id'=>customer1.id,'film_id'=>film1.id})
# ticket1.save


# EOF
