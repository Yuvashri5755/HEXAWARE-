class Courier:
    tracking_number_counter = 1000

    def __init__(self, sender_name, sender_address, receiver_name, receiver_address, weight, delivery_date, user_id):
        # Automatically generate a unique courier ID
        self.courier_id = f"C{Courier.tracking_number_counter}"
        Courier.tracking_number_counter += 1

        # Assign other attributes to the courier
        self.sender_name = sender_name
        self.sender_address = sender_address
        self.receiver_name = receiver_name
        self.receiver_address = receiver_address
        self.weight = weight
        self.status = "Processing"  # Initially the status is 'Processing'
        self.tracking_number = self.courier_id  # Set the tracking number to the generated courier_id
        self.delivery_date = delivery_date
        self.user_id = user_id

    def __str__(self):
        # Custom string representation of a courier order
        return f"Courier {self.tracking_number}: {self.sender_name} -> {self.receiver_name}"
