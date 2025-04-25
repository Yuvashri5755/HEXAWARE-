class Payment:
    def __init__(self, user_id, amount, payment_date):
        self.user_id = user_id
        self.amount = amount
        self.payment_date = payment_date

    def __str__(self):
        return f"Payment of {self.amount} by User {self.user_id} on {self.payment_date}"
