class CourierCompany:
    def __init__(self, company_name):
        self.company_name = company_name
        self.courier_details = []
        self.employee = {}  # ✅ Dictionary for fast lookup by ID
        self.location_details = []

    def add_courier(self, courier):
        self.courier_details.append(courier)

    def add_employee(self, employee):
        self.employee[employee.employee_id] = employee
        print(f"Employee {employee.employee_name} added to the company.")

    def get_employee_by_id(self, employee_id):
        return self.employee.get(employee_id, None)

    def add_location(self, location):
        self.location_details.append(location)
