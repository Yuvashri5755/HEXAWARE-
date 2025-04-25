class Location:
    def __init__(self, location_id, location_name, address):
        self.location_id = location_id
        self.location_name = location_name
        self.address = address

    def __str__(self):
        return f"{self.location_name} ({self.location_id})"
