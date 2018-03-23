require_relative("../db/sql_runner")

class Screening
  :attr_reader :id
  :attr_accessor :screening_time, :tickets

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screening_time = options['time'] #Time when the movie is playing [an int]
    @tickets = options['tickets'] #Tickets sold to that movie [an array]
  end



end
