from datetime import datetime

class Booking:
    booking_counter = 1

    def __init__(self, customers, event, num_tickets):
        self.booking_id = Booking.booking_counter
        Booking.booking_counter += 1
        self.customers = customers
        self.event = event
        self.num_tickets = num_tickets
        self.total_cost = event.ticket_price * num_tickets
        self.booking_date = datetime.now()

    def display_booking_details(self):
        print(f"Booking ID: {self.booking_id}, Event: {self.event.event_name}, Date: {self.booking_date},\n"
              f"Total Cost: {self.total_cost}, Tickets: {self.num_tickets}")
        for customer in self.customers:
            customer.display_customer_details()