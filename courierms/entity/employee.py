class Employee:
    def __init__(self, employee_id, employee_name, email, phone_number,role, salary):
        self.employee_id = employee_id
        self.employee_name = employee_name
        self.email = email
        self.phone_number = phone_number
        self.role=role
        self.salary = salary

    def __str__(self):
        return (f"Employee ID: {self.employee_id}, Name: {self.employee_name}, "
                f"Email: {self.email}, Phone: {self.phone_number}, Role:{self.role} Salary: {self.salary}")
