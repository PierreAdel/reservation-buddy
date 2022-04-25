class ReservationRepresenter
    
    def initialize(reservation)
      @reservation = reservation
    end
    def as_json
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
     
    private
    attr_reader :reservation
 
end