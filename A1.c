//A1: Write a C program to study all file operations related SYSTEM CALLS supported by UNIX OS and C libraries for file operations.
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#define FILENAME "dbms.txt"
#define BUFFER_SIZE 100

int main() {
    int fd;  // File descriptor
    char text[] = "Hello, this is a test file.\n";  // Data to write to the file
    char buffer[BUFFER_SIZE];  // Buffer to hold read data

    // 1. Create and open a file for writing
    fd = open(FILENAME, O_CREAT | O_WRONLY | O_TRUNC);
    if (fd == -1) {
        perror("Error opening file for writing");
        return EXIT_FAILURE;
    }
    printf("File '%s' created successfully.\n", FILENAME);

    // 2. Write to the file
    if (write(fd, text, strlen(text)) == -1) {
        perror("Error writing to file");
        close(fd);
        return EXIT_FAILURE;
    }
    printf("Data written to file successfully.\n");

    // 3. Close the file
    if (close(fd) == -1) {
        perror("Error closing file after writing");
        return EXIT_FAILURE;
    }
    printf("File closed successfully after writing.\n");


    // 4. Open the file for reading
    fd = open(FILENAME, O_RDONLY);
    if (fd == -1) {
        perror("Error opening file for reading");
        return EXIT_FAILURE;
    }
    printf("File '%s' opened for reading.\n", FILENAME);

    // 5. Read from the file
    ssize_t bytesRead = read(fd, buffer, sizeof(buffer) - 1);
    if (bytesRead == -1) {
        perror("Error reading from file");
        close(fd);
        return EXIT_FAILURE;
    }
    buffer[bytesRead] = '\0'; // Null-terminate the buffer
    printf("Data read from file: %s", buffer);

    // 6. Close the file after reading
    if (close(fd) == -1) {
        perror("Error closing file after reading");
        return EXIT_FAILURE;
    }
    printf("File closed successfully after reading.\n");

    // 7. Delete the file
    if (remove(FILENAME) == 0) {
        printf("File '%s' deleted successfully.\n", FILENAME);
    } else {
        perror("Error deleting file");
    }

    return EXIT_SUCCESS;
}
// Output:
// PS C:\Users\ABDULBASITH-HOME> cd "c:\Users\ABDULBASITH-HOME\Documents\" ; if ($?) { gcc dbmsA1.c -o dbmsA1 } ; if ($?) { .\dbmsA1 }
// File 'dbms.txt' created successfully.
// Data written to file successfully.
// File closed successfully after writing.
// File 'dbms.txt' opened for reading.
// Data read from file: Hello, this is a test file.
// File closed successfully after reading.
// File 'dbms.txt' deleted successfully.
// PS C:\Users\ABDULBASITH-HOME\Documents>
