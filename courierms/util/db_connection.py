import pyodbc

def get_connection():
    conn_str = (
        "Driver={SQL Server};"
        "Server=LAPTOP-P3260BCS\\MSSQLSERVER01;"  # Update with your SQL Server instance
        "Database=StudentDB;"
        "Trusted_Connection=yes;"
    )
    return pyodbc.connect(conn_str)
