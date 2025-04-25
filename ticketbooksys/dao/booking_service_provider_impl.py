from ticketbooksys.dao.i_booking_service_provider import IBookingServiceProvider
from ticketbooksys.exceptions.invalid_booking_id_exception import InvalidBookingIDException
from ticketbooksys.exceptions.event_not_found_exception import EventNotFoundException
from ticketbooksys.entity.booking import Booking

class BookingServiceProviderImpl(IBookingServiceProvider):
    def __init__(self, event_service):
        self.event_service = event_service
        self.bookings = []

    def calculate_booking_cost(self, num_tickets, ticket_price):
        return num_tickets * ticket_price

    def book_tickets(self, event_name, num_tickets, customers):
        for event in self.event_service.get_event_details():
            if event.event_name == event_name:
                if event.book_tickets(num_tickets):
                    booking = Booking(customers, event, num_tickets)
                    self.bookings.append(booking)
                    return booking
                else:
                    raise Exception("Not enough tickets available.")
        raise EventNotFoundException(f"Event '{event_name}' not found.")

    def cancel_booking(self, booking_id):
        for booking in self.bookings:
            if booking.booking_id == booking_id:
                booking.event.cancel_booking(booking.num_tickets)
                self.bookings.remove(booking)
                return True
        raise InvalidBookingIDException(f"Booking ID '{booking_id}' not found.")

    def get_booking_details(self, booking_id):
        for booking in self.bookings:
            if booking.booking_id == booking_id:
                return booking
        raise InvalidBookingIDException(f"Booking ID '{booking_id}' not found.")
