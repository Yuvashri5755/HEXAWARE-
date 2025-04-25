
from ticketbooksys.entity.venue import Venue
from ticketbooksys.entity.customer import Customer
from ticketbooksys.entity.movie import Movie
from ticketbooksys.entity.sports import Sports
from ticketbooksys.entity.concert import Concert
from ticketbooksys.dao.event_service_provider_impl import EventServiceProviderImpl
from ticketbooksys.dao.booking_service_provider_impl import BookingServiceProviderImpl

if __name__ == '__main__':
    event_service = EventServiceProviderImpl()
    booking_service = BookingServiceProviderImpl(event_service)

    print("Welcome to Ticket Booking System")
    while True:
        print("\n==== MENU ====")
        print("1. Create Movie Event")
        print("2. Create Concert Event")
        print("3. Create Sports Event")
        print("4. Book Tickets")
        print("5. Cancel Booking")
        print("6. View Booking Details")
        print("7. View All Events")
        print("8. Exit")

        choice = input("Enter your choice: ")

        if choice == '1' :
            print("- - Creat Movie Event - -")
            venue_name = input("Enter venue name: ")
            venue_address = input("Enter venue address: ")
            event_name = input("Enter movie name: ")
            event_date = input("Enter event date (YYYY-MM-DD): ")
            event_time = input("Enter event time (HH:MM): ")
            total_seats = int(input("Enter total seats: "))
            ticket_price = float(input("Enter ticket price: "))
            genre = input("Enter movie genre: ")
            actor = input("Enter actor name: ")
            actress = input("Enter actress name: ")

            venue = Venue(venue_name, venue_address)
            movie = Movie(event_name=event_name, event_date=event_date, event_time=event_time,
                          venue=venue, total_seats=total_seats, available_seats=total_seats,
                          ticket_price=ticket_price, event_type="Movie",
                          genre=genre, actor_name=actor, actress_name=actress)
            event_service.create_event(movie)
            print("Movie event created and stored in system successfully.")

        elif choice == '2':
            print(" - - Create Concert Event - -")
            venue_name = input("Enter venue name: ")
            venue_address = input("Enter venue address: ")
            event_name = input("Enter concert name: ")
            event_date = input("Enter event date (YYYY-MM-DD): ")
            event_time = input("Enter event time (HH:MM): ")
            total_seats = int(input("Enter total seats: "))
            ticket_price = float(input("Enter ticket price: "))
            artist = input("Enter artist name: ")
            concert_type = input("Enter concert type (Rock, Classical, etc.): ")

            venue = Venue(venue_name, venue_address)
            concert = Concert(event_name=event_name, event_date=event_date, event_time=event_time,
                              venue=venue, total_seats=total_seats, available_seats=total_seats,
                              ticket_price=ticket_price, event_type="Concert",
                              artist=artist, concert_type=concert_type)
            event_service.create_event(concert)
            print("Concert event created and stored in system successfully.")

        elif choice == '3':
            print(" - - Create Sports Event - -")
            venue_name = input("Enter venue name: ")
            venue_address = input("Enter venue address: ")
            event_name = input("Enter sports event name: ")
            event_date = input("Enter event date (YYYY-MM-DD): ")
            event_time = input("Enter event time (HH:MM): ")
            total_seats = int(input("Enter total seats: "))
            ticket_price = float(input("Enter ticket price: "))
            sport_name = input("Enter sport name: ")
            teams_name = input("Enter teams name (e.g., Team A vs Team B): ")

            venue = Venue(venue_name, venue_address)
            sports = Sports(event_name=event_name, event_date=event_date, event_time=event_time,
                            venue=venue, total_seats=total_seats, available_seats=total_seats,
                            ticket_price=ticket_price, event_type="Sports",
                            sport_name=sport_name, teams_name=teams_name)
            event_service.create_event(sports)
            print("Sports event created and stored in system successfully.")

        elif choice == '4':
            event_name = input("Enter Event Name to Book: ")
            num_tickets = int(input("Enter number of tickets: "))
            customers = []
            for i in range(num_tickets):
                print(f"Enter details for Customer {i+1}:")
                name = input("Name: ")
                email = input("Email: ")
                phone = input("Phone: ")
                customers.append(Customer(name, email, phone))
            try:
                booking = booking_service.book_tickets(event_name, num_tickets, customers)
                print("Booking successful!")
                booking.display_booking_details()
            except Exception as e:
                print(f"Error: {e}")

        elif choice == '5':
            try:
                booking_id = int(input("Enter Booking ID to Cancel: "))
                booking_service.cancel_booking(booking_id)
                print("Booking cancelled successfully.")
            except Exception as e:
                print(f"Error: {e}")

        elif choice == '6':
            try:
                booking_id = int(input("Enter Booking ID to View: "))
                booking = booking_service.get_booking_details(booking_id)
                booking.display_booking_details()
            except Exception as e:
                print(f"Error: {e}")

        elif choice == '7' :
            events = event_service.get_event_details()
            for e in events :
                e.display_event_details()
                print("**********************************************")

        elif choice == '8':
            print("Exiting Ticket Booking System. Thank You!")
            break

        else:
            print("Invalid choice. Please try again.")
