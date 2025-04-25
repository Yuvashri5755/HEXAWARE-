class Venue:
    def __init__(self, venue_name=None, address=None):
        self.venue_name = venue_name
        self.address = address

    def display_venue_details(self):
        print(f"Venue Name: {self.venue_name}, Address: {self.address}")
