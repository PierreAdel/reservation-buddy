 


class ReservationsRepresenter
    
    def initialize(reservations)
      @reservations = reservations
    end
    def as_json
        reservations.map do |reservation|
            {
                id: reservation.id,
                date_from: reservation.date_from,
                 number_of_days: reservation.number_of_days,
                 customer_id: reservation.customer_id,
                 customer_name: reservation.customer.name,
                 hotel_id: reservation.hotel_id,
                 hotel_name: reservation.hotel.hotel_name,
            }
        end
    end
     
    private
    attr_reader :reservations
 
end