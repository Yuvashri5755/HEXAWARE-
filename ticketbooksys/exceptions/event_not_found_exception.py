class EventNotFoundException(Exception):
    def __init__(self, message="Event not found!"):
        super().__init__(message)

