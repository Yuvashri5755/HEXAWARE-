from courierms.entity.employee import Employee

class CourierAdminService:
    def __init__(self, company):
        self.company = company

    def add_courier_staff(self, employee):
        self.company.add_employee(employee)
        return employee.employee_id
    def get_employee_by_id(self, employee_id):
        return self.company.get_employee_by_id(employee_id)

    def view_employee_details(self, emp_id) :
        employee = self.get_employee_by_id(emp_id)  # Retrieves employee using their ID
        if employee :
            return str(employee)  # Returns employee details as string
        else :
            return "Employee not found."