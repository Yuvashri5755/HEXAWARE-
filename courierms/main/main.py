from courierms.entity.user import User
from courierms.entity.courier import Courier
from courierms.entity.employee import Employee
from courierms.entity.courier_company import CourierCompany
from courierms.entity.payment import Payment
from courierms.dao.courier_user_service import CourierUserService
from courierms.dao.courier_admin_service import CourierAdminService
from courierms.exceptions.tracking_number_not_found_exception import TrackingNumberNotFoundException
from courierms.exceptions.invalid_employee_id_exception import InvalidEmployeeIdException
from datetime import datetime


def main() :
    company = CourierCompany("HexaCourier")
    user_service = CourierUserService(company)
    admin_service = CourierAdminService(company)

    print("Welcome to HexaCourier Management System")

    while True :
        print("\n==== MENU ====")
        print("1. Add New Employee")
        print("2. Add New User")
        print("3. Place a Courier Order")
        print("4. Get Order Status")
        print("5. Cancel Order")
        print("6. Make Payment")
        print("7. View Employee Details")
        print("8. View User Details")
        print("9. View Payments")
        print("10. Exit")

        choice = input("Enter your choice: ")

        if choice == "1" :
            try :
                # Add New Employee
                employee_id = input("Enter Employee ID: ")
                employee_name = input("Enter Employee Name: ")
                email = input("Enter Email: ")
                contact_number = input("Enter Contact Number: ")
                role = input("Enter Role: ")
                salary = float(input("Enter Salary: "))

                employee = Employee(employee_id, employee_name, email, contact_number, role, salary)
                admin_service.add_courier_staff(employee)
                print(f"Employee {employee_name} added successfully.")

            except InvalidEmployeeIdException as e :
                print(f"Error: {e}")
            except Exception as e :
                print(f"Error adding employee: {e}")

        elif choice == "2" :
            try :
                # Add New User
                user_id = input("Enter User ID: ")
                user_name = input("Enter User Name: ")
                email = input("Enter Email: ")
                password = input("Enter Password: ")
                contact_number = input("Enter Contact Number: ")
                address = input("Enter Address: ")

                user = User(user_id, user_name, email, password, contact_number, address)
                user_service.add_user(user)  # Add user to the system
                print(f"User {user_name} added successfully.")

            except Exception as e :
                print(f"Error adding user: {e}")

        elif choice == "3" :
            try :
                # Place a Courier Order
                sender_name = input("Sender Name: ")
                sender_address = input("Sender Address: ")
                receiver_name = input("Receiver Name: ")
                receiver_address = input("Receiver Address: ")
                weight = float(input("Enter Weight (kg): "))
                delivery_date = input("Enter Delivery Date (YYYY-MM-DD): ")

                user_id = input("Enter User ID: ")
                user = user_service.get_user_by_id(user_id)

                if not user :
                    print("User not found.")
                    continue

                courier = Courier(sender_name, sender_address, receiver_name, receiver_address, weight, delivery_date,
                                  user_id)
                tracking_number = user_service.place_order(courier)
                print(f"Order placed successfully. Tracking number: {tracking_number}")

            except Exception as e :
                print(f"Error placing courier order: {e}")

        elif choice == "4" :
            try :
                # Get Order Status
                tracking_number = input("Enter Tracking Number: ")
                status = user_service.get_order_status(tracking_number)

                if not status :
                    print(f"Order with tracking number {tracking_number} not found.")
                    continue

                print(f"Order Status for {tracking_number}: {status}")

            except TrackingNumberNotFoundException as e :
                print(f"Error: {e}")
            except Exception as e :
                print(f"Error retrieving order status: {e}")

        elif choice == "5" :
            try :
                # Cancel Order
                tracking_number = input("Enter Tracking Number to cancel: ")
                user_service.cancel_order(tracking_number)

                print(f"Order with tracking number {tracking_number} has been cancelled.")

            except TrackingNumberNotFoundException as e :
                print(f"Error: {e}")
            except Exception as e :
                print(f"Error cancelling order: {e}")

        elif choice == "6" :
            try :
                # Make Payment
                tracking_number = input("Enter Tracking Number for payment: ")
                amount = float(input("Enter Payment Amount: "))
                payment_date_str = input("Enter Payment Date (YYYY-MM-DD): ")
                payment_date = datetime.strptime(payment_date_str, "%Y-%m-%d").date()

                user = user_service.get_user_by_tracking_number(tracking_number)
                if not user :
                    print("No user found with this tracking number.")
                    continue

                user_id = user.user_id

                # Correct method call with all required arguments
                user_service.make_payment(user_id, amount, payment_date)

                print(f"Payment of {amount} processed successfully for tracking number {tracking_number}.")

            except Exception as e :
                print(f"Error processing payment: {e}")

        elif choice == "7" :
            try :
                # View Employee Details
                emp_id = input("Enter Employee ID to view: ")
                employee_details = admin_service.view_employee_details(emp_id)

                # Print employee details or a message if not found
                print("Employee Details:")
                print(employee_details)  # Will print the employee information, or 'Employee not found'

            except Exception as e :
                print("Error viewing employee details:", e)


        elif choice == "8" :
            try :
                # View User Details
                user_id = input("Enter User ID to view: ")
                user = user_service.get_user_by_id(user_id)

                if not user :
                    print(f"No user found with ID: {user_id}")
                else :
                    print(f"User Details:\n{user}")

            except Exception as e :
                print(f"Error viewing user details: {e}")

        elif choice == "9" :
            try :
                # View Payments
                payments = user_service.get_all_payments()
                if not payments :
                    print("No payments found.")
                else :
                    print("Payments Details:")
                    for payment in payments :
                        print(payment)

            except Exception as e :
                print(f"Error retrieving payments: {e}")

        elif choice == "10" :
            print("Exiting... Goodbye!")
            break

        else :
            print("Invalid choice. Please try again.")


if __name__ == "__main__" :
    main()
