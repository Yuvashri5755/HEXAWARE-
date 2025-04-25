from ticketbooksys.entity.event import Event

class Movie(Event):
    def __init__(self, genre=None, actor_name=None, actress_name=None, **kwargs):
        super().__init__(**kwargs)
        self.genre = genre
        self.actor_name = actor_name
        self.actress_name = actress_name

    def display_event_details(self):
        super().display_event_details()
        print(f"Genre: {self.genre}, Actor: {self.actor_name}, Actress: {self.actress_name}")