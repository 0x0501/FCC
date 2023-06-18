#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

QUERY_ATOMIC_NUMBER() {
    QUERY_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
}

QUERY_SYMBOL() {
    QUERY_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
}

QUERY_NAME() {
    QUERY_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
}

if [[ -z $1 ]]; then
    echo "Please provide an element as an argument."
else
    # input is number
    if [[ $1 =~ ^[0-9]+$ ]]; then
        QUERY_ATOMIC_NUMBER $1
    # input is symbol (A letter or 2 letters)
    elif [[ $1 =~ ^[A-Za-z_]{1,2}$ ]]; then
        QUERY_SYMBOL $1
    # input is normal words
    elif [[ $1 =~ ^[A-Za-z_]{2,} ]]; then
        QUERY_NAME $1
    fi

    # if query result is not null
    if [[ -n $QUERY_RESULT ]]; then
        echo $QUERY_RESULT | while IFS="|" read NUM NAME SYMBOL TYPE MASS MELT_P BOIL_P; do
            echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_P celsius and a boiling point of $BOIL_P celsius."
        done
    else
        echo "I could not find that element in the database."
    fi
fi
