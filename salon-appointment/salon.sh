#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -A -t -c"

# echo $($PSQL "TRUNCATE customers, appointments")

MAIN() {
    # if no given param, display greeting
    # if [[ $1 ]]
    # then
    #   echo -e "$1"
    # else
    echo -e "\n~~ Welcome to Loyal Salon ~~\n"
    echo -e "[Please Select Service, and type Number]\n"
    # fi

    SERVICES=$($PSQL "SELECT * FROM services")

    if [[ -z $SERVICES ]]; then
        echo -e "Sorry, no service available right now!\n"
    else
        # display menu
        echo "$SERVICES" | while IFS="|" read NUM SERVICE_NAME; do
            echo "$NUM) $SERVICE_NAME"
        done
        # select service
        read SERVICE_ID_SELECTED
        # if the input isn't number
        if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
            # back to the main menu
            MAIN
        else
            SERVICE_QUERY=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
            if [[ -z $SERVICE_QUERY ]]; then
                MAIN "\n[Service Doesn't exist]\n"
            else
                echo -e "\nYou chose [$SERVICE_ID_SELECTED]. Could you tell me your phone number?\n"
                read CUSTOMER_PHONE
                CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
                SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
                # if it's a new customer
                if [[ -z $CUSTOMER_ID ]]; then
                    # insert a new customer
                    echo -e "\nAnd your name?\n"
                    read CUSTOMER_NAME
                    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
                    # reset customer id
                    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
                fi
                # get existent customer name from database
                CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")
                # get appointment time
                echo -e "\nWhen do you want to make an appointment?\n"
                read SERVICE_TIME
                INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
                echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
            fi
        fi
    fi
}

MAIN
