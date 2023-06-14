#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# truncate table
echo $($PSQL "truncate teams, games")

# insert teams table
echo -e "\n INSERT \`teams\` table:\n"
cat games.csv | while IFS=',' read YEAR ROUND WIN OPP WIN_S OPP_S
do
  # excluding headline
  if [[ $WIN != 'winner' ]]
  then
    IS_EXIST_WIN=$($PSQL "select * from teams where name = '$WIN'")
    IS_EXIST_OPP=$($PSQL "select * from teams where name = '$OPP'")
    if [[ -z $IS_EXIST_WIN ]]
    then
      INSERT_TEAM_RESULT_1=$($PSQL "insert into teams (name) values ('$WIN')")
      echo "Insert Team: $WIN success!"
    elif [[ -z $IS_EXIST_OPP ]]
    then
      INSERT_TEAM_RESULT_2=$($PSQL "insert into teams (name) values ('$OPP')")
      echo "Insert Team: $OPP success!"
    fi
  fi
done

# insert games table
echo -e "\n INSERT \`games\` table:\n"
cat games.csv | while IFS=',' read YEAR ROUND WIN OPP WIN_S OPP_S
do
if [[ $WIN != 'winner' ]]
then
  WINNER_ID=$($PSQL "select team_id from teams where name = '$WIN'")
  OPPONENT_ID=$($PSQL "select team_id from teams where name = '$OPP'")

  INSERT_RESULT=$($PSQL "insert into games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) values ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WIN_S, $OPP_S)")

  if [[ $INSERT_RESULT == 'INSERT 0 1' ]]
  then
    echo "Insert Game: ($YEAR - $WIN : $OPP) success!"
  fi
fi
done