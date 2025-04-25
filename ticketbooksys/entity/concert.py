from ticketbooksys.entity.event import Event

class Concert(Event):
    def __init__(self, artist=None, concert_type=None, **kwargs):
        super().__init__(**kwargs)
        self.artist = artist
        self.concert_type = concert_type

    def display_event_details(self):
        super().display_event_details()
        print(f"Artist: {self.artist}, Type: {self.concert_type}")