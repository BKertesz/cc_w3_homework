require_relative("../db/sql_runner")
require("pry")
require_relative("ticket")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name,@funds]
    hash = SqlRunner.run( sql, values ).first
    @id = hash['id'].to_i
  end

  def update()
    sql = 'UPDATE customers SET name=$1, funds=$2 WHERE id=$3'
    values = [@name,@funds,@id]
    SqlRunner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    data = SqlRunner.run(sql)
    return User.map_items(data)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    hash = SqlRunner.run(sql, values)
    return hash.map{|x| Film.new(x)}
  end

  def buy_ticket(film)
    @funds -= film.price
    sql = "INSERT INTO tickets (customer_id,film_id) VALUES ($1,$2)"
    values = [@id,film.id]
    SqlRunner.run(sql,values)
    return ticket = Ticket.new({'customer_id'=>@id,'film_id'=>film.id})
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets WHERE customer_id = $1"
    values = [@id]
    hash = SqlRunner.run(sql,values)
    return hash.map{|x| Ticket.new(x)}
  end




end


# EOF
