from ticketbooksys.entity.event import Event

class Sports(Event):
    def __init__(self, sport_name=None, teams_name=None, **kwargs):
        super().__init__(**kwargs)
        self.sport_name = sport_name
        self.teams_name = teams_name

    def display_event_details(self):
        super().display_event_details()
        print(f"Sport: {self.sport_name}, Teams: {self.teams_name}")
