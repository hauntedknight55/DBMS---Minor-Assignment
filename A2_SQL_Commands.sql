-- A2: Demonstrate indexing and associated operations.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_RECORDS 100
#define NAME_LENGTH 50
#define FILENAME "students.csv"

typedef struct {
    int id;
    char name[NAME_LENGTH];
} Student;

typedef struct {
    int id;
    long position; // Position in the data file
} IndexEntry;

void writeRecords(FILE *dataFile) {
    fprintf(dataFile, "ID,Name\n"); // Header row
    Student students[MAX_RECORDS] = {
        {1, "Aman"},
        {2, "Shrikar"},
        {3, "Ravi"},
        {4, "Harish"},
        {5, "Ramesh"}
    };

    for (int i = 0; i < 5; i++) {
        fprintf(dataFile, "%d,%s\n", students[i].id, students[i].name);
    }
}


void createIndex(FILE *dataFile, IndexEntry *index, int *indexSize) {
    fseek(dataFile, 0, SEEK_SET);
    char line[NAME_LENGTH + 10]; // Buffer for reading lines
    *indexSize = 0;

    while (fgets(line, sizeof(line), dataFile)) {
        // Get the position of the current line
        index[*indexSize].position = ftell(dataFile) - strlen(line);
        
        // Parse the ID from the line
        sscanf(line, "%d,", &index[*indexSize].id);
        (*indexSize)++;
    }
}

void searchRecord(FILE *dataFile, IndexEntry *index, int indexSize, int searchId) {
    for (int i = 0; i < indexSize; i++) {
        if (index[i].id == searchId) {
            char line[NAME_LENGTH + 10];
            fseek(dataFile, index[i].position, SEEK_SET);
            fgets(line, sizeof(line), dataFile);
            printf("Record Found: %s", line);
            return;
        }
    }
    printf("Record with ID %d not found.\n", searchId);
}

int main() {
    FILE *dataFile = fopen(FILENAME, "w+");
    if (dataFile == NULL) {
        perror("Unable to open file");
        return 1;
    }

    // Step 1: Write records to the data file
    writeRecords(dataFile);

    // Step 2: Create an index for the records
    IndexEntry index[MAX_RECORDS];
    int indexSize;
    createIndex(dataFile, index, &indexSize);

    // Step 3: Search for records using the index
    int searchId;
    printf("Enter ID to search for: ");
    scanf("%d", &searchId);
    searchRecord(dataFile, index, indexSize, searchId);

    // Clean up
    fclose(dataFile);
    return 0;
}
