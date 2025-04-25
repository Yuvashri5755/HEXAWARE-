from ticketbooksys.dao.i_event_service_provider import IEventServiceProvider

class EventServiceProviderImpl(IEventServiceProvider):
    def __init__(self):
        self.events = []

    def create_event(self, event):
        self.events.append(event)
        return event

    def get_event_details(self):
        return self.events

    def get_available_no_of_tickets(self):
        return sum(event.available_seats for event in self.events)