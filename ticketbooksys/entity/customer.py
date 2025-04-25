class Customer:
    def __init__(self, customer_name=None, email=None, phone_number=None):
        self.customer_name = customer_name
        self.email = email
        self.phone_number = phone_number

    def display_customer_details(self):
        print(f"Customer: {self.customer_name}, Email: {self.email}, Phone: {self.phone_number}")