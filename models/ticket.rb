require_relative("../db/sql_runner")
require_relative("customer")
require_relative("film")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    hash = SqlRunner.run( sql,values ).first
    @id = hash['id'].to_i
  end

  def update()
    sql = 'UPDATE tickets SET customer_id=$1, film_id=$2 WHERE id=$3'
    values = [@customer_id,@film_id,@id]
    SqlRunner.run(sql,values)
  end


  def self.all()
    sql = "SELECT * FROM tickets"
    hash = SqlRunner.run(sql)
    return hash.map{|x| Ticket.new(x)}
  end

  def self.delete_all()
   sql = "DELETE FROM tickets"
   SqlRunner.run(sql)
  end


end
