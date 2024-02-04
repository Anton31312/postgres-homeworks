"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv
import os

def openCSV(path):
    data_file = []
    with open(path, newline='') as file:
        reader = csv.reader(file, delimiter=',')
        for item in reader:
            data_file.append(item)
        return data_file

def main():
    conn = psycopg2.connect(
        host="localhost",
        database="north",
        user="postgres",
        password="admin"
    )

    try:
        with conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM customers")
                rows = cur.fetchall() 

                if rows == []:   
                    file_customer_path = os.path.join('homework-1', 'north_data', 'customers_data.csv')

                    customer_info = openCSV(file_customer_path)

                    for customer in customer_info:
                        if customer[0] != 'customer_id':
                            cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", (customer[0], customer[1], customer[2]))  
                
                cur.execute("SELECT * FROM employees")
                rows = cur.fetchall() 
                
                if rows == []:  
                    file_employees_path = os.path.join('homework-1', 'north_data', 'employees_data.csv')
                    employeer_info = openCSV(file_employees_path)

                    for employeer in employeer_info:
                        if employeer[0] != 'employee_id':
                            cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)", (employeer[0], employeer[1], employeer[2], employeer[3], employeer[4], employeer[5]))
                            
                cur.execute("SELECT * FROM orders")
                rows = cur.fetchall() 
                
                if rows == []:  
                    file_orders_path = os.path.join('homework-1', 'north_data', 'orders_data.csv')
                    order_info = openCSV(file_orders_path)

                    for order in order_info:
                        if order[0] != 'order_id':
                            cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)", (order[0], order[1], order[2], order[3], order[4]))  
                
    finally:
        conn.close()


if __name__ == '__main__':
    main()