#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN() {
    echo "Enter your username:"
    read USERNAME

    USER_INFO=$($PSQL "SELECT name, total_played, best_game_times FROM users INNER JOIN scores USING(user_id) WHERE name = '$USERNAME'")

    # if user doesn't exist before
    if [[ -z $USER_INFO ]]; then
        echo "Welcome, $USERNAME! It looks like this is your first time here."
        # add user into database
        INSERT_USER_RESULT=$($PSQL "INSERT INTO users (name) VALUES ('$USERNAME')")
        USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
        INSERT_SCORE_RESULT=$($PSQL "INSERT INTO scores (user_id) VALUES ($USER_ID)")
    else
        # if user exist
        echo $USER_INFO | while IFS="|" read USER_NAME PLAYED BEST
        do
            echo "Welcome back, $USER_NAME! You have played $PLAYED games, and your best game took $BEST guesses."
        done
    fi  

    # call guess function:
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
    GUESS $USER_ID
}

# $1 = user_id
GUESS() {
    
    # from 1 to 1000
    SECRET_NUMBER=$(($RANDOM%1000 + 1))
    GUESS_TIMES=1

    echo "Guess the secret number between 1 and 1000:"
    read USER_GUESS

    while (( $USER_GUESS != $SECRET_NUMBER ))
    do
        # if input is not a number
        if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
        then
            echo "That is not an integer, guess again:"
            read USER_GUESS
        else
            # count guessed times only when user's input is numeric
            GUESS_TIMES=$(( ++GUESS_TIMES ))
            # if input is higher
            if [[ $USER_GUESS > $SECRET_NUMBER ]]; then
                echo "It's higher than that, guess again:"
                read USER_GUESS
            # if input is lower
            else
                echo "It's lower than that, guess again:"
                read USER_GUESS
            fi  
        fi
    done
    # when number is guessed:
    echo "You guessed it in $GUESS_TIMES tries. The secret number was $SECRET_NUMBER. Nice job!"

    # update played times info to database
    UPDATE_TIMES_RESULT=$($PSQL "UPDATE users SET total_played = total_played + 1 WHERE user_id=$1")

    USER_GUESS_TIMES_HISTORY=$($PSQL "SELECT best_game_times FROM scores WHERE user_id = $1")

    # if socore this time is better than history, updating it
    if [[ $GUESS_TIMES > $USER_GUESS_TIMES_HISTORY ]]; then
        UPDATE_BEST_SCORE_RESULT=$($PSQL "UPDATE scores SET best_game_times = $GUESS_TIMES WHERE user_id = $1")
    fi
}

MAIN

# database structure

: 'users:
    - user_id (number)
    - name (string)
    - total_played (number)

scores:
    - score_id (number)
    - best_game_times (number)
    - user_id (number)
'
