# entity/user.py
class User:
    def __init__(self, user_id, user_name, email, password, contact_number, address):
        self.user_id = user_id
        self.user_name = user_name
        self.email = email
        self.password = password
        self.contact_number = contact_number
        self.address = address  # Can be further broken down into city, state, etc.

    def __str__(self):
        return f"User ID: {self.user_id}, Name: {self.user_name}, Email: {self.email}, Contact: {self.contact_number}, Address: {self.address}"
