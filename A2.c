// A2: Write a C program to demonstrate indexing and associated operations.
#include <stdio.h>
#include <sqlca.h>
EXEC SQL INCLUDE SQLCA;

int main() {
    // Connect to the database
    //EXEC SQL CONNECT :username IDENTIFIED BY :password;
    EXEC SQL CONNECT :22cs001 IDENTIFIED BY :a;

    if (sqlca.sqlcode != 0) {
        printf("Error connecting to the database: %d\n", sqlca.sqlcode);
        return 1;
    }

    printf("Connected to the database.\n");

    // Create a table
    EXEC SQL EXECUTE IMMEDIATE "CREATE TABLE employees (emp_id NUMBER PRIMARY KEY, emp_name VARCHAR2(50), emp_dept VARCHAR2(30), emp_salary NUMBER)";

    if (sqlca.sqlcode != 0) {
        printf("Error creating table: %d\n", sqlca.sqlcode);
        return 1;
    }
    printf("Table created successfully.\n");

    // Insert data
    EXEC SQL EXECUTE IMMEDIATE "INSERT INTO employees (emp_id, emp_name, emp_dept, emp_salary) VALUES (101, 'AbdulBasith', 'HR', 50000)";

    if (sqlca.sqlcode != 0) {
        printf("Error inserting data: %d\n", sqlca.sqlcode);
        return 1;
    }
    printf("Data inserted successfully.\n");

    // Create an index
    EXEC SQL EXECUTE IMMEDIATE "CREATE INDEX emp_dept_idx ON employees(emp_dept)";

    if (sqlca.sqlcode != 0) {
        printf("Error creating index: %d\n", sqlca.sqlcode);
        return 1;
    }
    printf("Index created successfully.\n");

    // Query the data (with index)
    EXEC SQL EXECUTE IMMEDIATE "SELECT * FROM employees WHERE emp_dept = 'HR'";

    if (sqlca.sqlcode != 0) {
        printf("Error querying data: %d\n", sqlca.sqlcode);
        return 1;
    }

    // Drop the index
    EXEC SQL EXECUTE IMMEDIATE "DROP INDEX emp_dept_idx";

    if (sqlca.sqlcode != 0) {
        printf("Error dropping index: %d\n", sqlca.sqlcode);
        return 1;
    }
    printf("Index dropped successfully.\n");

    // Commit and disconnect
    EXEC SQL COMMIT WORK;
    EXEC SQL DISCONNECT;
    
    printf("Disconnected from the database.\n");
    return 0;
}
