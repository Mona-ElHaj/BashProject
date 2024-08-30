#!/bin/bash

create_database() {
    read -p "Enter the name of the database: " DB_NAME
    mkdir -p "$DB_NAME"
    echo "Database '$DB_NAME' created successfully."
}

create_table() {
    read -p "Enter the name of the table: " TABLE_NAME
    TABLE_PATH="$DB_NAME/$TABLE_NAME.txt"
    
    read -p "Enter the column names (space-separated): " COLUMNS
    echo "$COLUMNS" > "$TABLE_PATH"
    echo "Table '$TABLE_NAME' with columns '$COLUMNS' created successfully."
}


insert_data() {
    read -p "Enter the name of the table: " TABLE_NAME
    TABLE_PATH="$DB_NAME/$TABLE_NAME.txt"
    
    if [[ -f "$TABLE_PATH" ]]; then
        read -p "Enter the data (space-separated) corresponding to the columns: " DATA
        echo "$DATA" >> "$TABLE_PATH"
        echo "Data inserted into table '$TABLE_NAME'."
    else
        echo "Table '$TABLE_NAME' does not exist."
    fi
}

update_data() {
    read -p "Enter the name of the table: " TABLE_NAME
    TABLE_PATH="$DB_NAME/$TABLE_NAME.txt"
    
    if [[ -f "$TABLE_PATH" ]]; then
        read -p "Enter the ID of the row to update (first column value): " ROW_ID
        read -p "Enter the new data (space-separated): " NEW_DATA
        sed -i "/^$ROW_ID /c\\$NEW_DATA" "$TABLE_PATH"
        echo "Data updated in table '$TABLE_NAME'."
    else
        echo "Table '$TABLE_NAME' does not exist."
    fi
}

delete_data() {
    read -p "Enter the name of the table: " TABLE_NAME
    TABLE_PATH="$DB_NAME/$TABLE_NAME.txt"
    
    if [[ -f "$TABLE_PATH" ]]; then
        read -p "Enter the ID of the row to delete (first column value): " ROW_ID
        sed -i "/^$ROW_ID /d" "$TABLE_PATH"
        echo "Data deleted from table '$TABLE_NAME'."
    else
        echo "Table '$TABLE_NAME' does not exist."
    fi
}

view_table() {
    read -p "Enter the name of the table: " TABLE_NAME
    TABLE_PATH="$DB_NAME/$TABLE_NAME.txt"
    
    if [[ -f "$TABLE_PATH" ]]; then
        cat "$TABLE_PATH"
    else
        echo "Table '$TABLE_NAME' does not exist."
    fi
}

while true; do
    echo "Select an option:"
    echo "1. Create Database"
    echo "2. Create Table"
    echo "3. Insert Data"
    echo "4. Update Data"
    echo "5. Delete Data"
    echo "6. View Table"
    echo "7. Exit"
    read -p "Enter your choice: " CHOICE

    case $CHOICE in
        1) create_database ;;
        2) create_table ;;
        3) insert_data ;;
        4) update_data ;;
        5) delete_data ;;
        6) view_table ;;
        7) echo "Exiting..." ; exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
