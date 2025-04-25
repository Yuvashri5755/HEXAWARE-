# dao/courier_user_service.py

from courierms.entity.payment import Payment  # Import the Payment class


class CourierUserService :
    def __init__(self, company) :
        self.company = company
        self.orders = {}  # Dictionary to store orders by tracking_number
        self.users = {}  # Dictionary to store users by user_id
        self.payments = []  # List to store payments made by users

    def add_user(self, user) :
        if user.user_id in self.users :
            raise Exception("User with this ID already exists.")
        self.users[user.user_id] = user
        print(f"User {user.user_name} added successfully.")

    def get_user_by_id(self, user_id) :
        return self.users.get(user_id, None)

    def place_order(self, courier) :
        tracking_number = courier.tracking_number  # This is the courier_id
        self.orders[tracking_number] = courier
        return tracking_number  # Return the tracking_number to the caller

    def get_order_status(self, tracking_number) :
        courier = self.orders.get(tracking_number)
        if not courier :
            raise TrackingNumberNotFoundException(f"Order with tracking number {tracking_number} not found.")
        return courier.status  # Return the current status of the courier

    def cancel_order(self, tracking_number) :
        if tracking_number in self.orders :
            del self.orders[tracking_number]
        else :
            raise TrackingNumberNotFoundException(f"Order with tracking number {tracking_number} not found.")

    def get_user_by_tracking_number(self, tracking_number) :
        courier = self.orders.get(tracking_number)
        if not courier :
            raise TrackingNumberNotFoundException(f"Order with tracking number {tracking_number} not found.")

        user_id = courier.user_id  # Get user_id from the courier order
        return self.get_user_by_id(user_id)  # Return the user object using user_id

    def make_payment(self, user_id, amount, payment_date) :
        """Process payment and add to the payments list."""
        user = self.get_user_by_id(user_id)
        if user is None :
            raise Exception("User not found")

        # Create Payment object with payment_date
        payment = Payment(user_id=user_id, amount=amount, payment_date=payment_date)
        self.payments.append(payment)
        print(f"Payment of {amount} received from {user.user_name} on {payment_date}.")

    def get_all_payments(self) :
        """Retrieve all payments made in the system."""
        if not self.payments :
            raise Exception("No payments recorded yet.")
        return self.payments  # Return the list of all payments
