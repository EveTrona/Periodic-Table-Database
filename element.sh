#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #if argument is atomic number
  if [[ $1 =~ [0-9]+ ]]
  then
    #get atomic number
    ATOMIC_NUMBER=$1
    # get atomic symbol
    ATOMIC_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER;")
    # get atomic name
    ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER;")
    # get atomic type id
    ATOMIC_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
    ATOMIC_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $ATOMIC_TYPE_ID")
    # get atomic mass
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
    # get atomic melting point
    ATOMIC_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
    # get atomic boiling point
    ATOMIC_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
  fi
  # if the argument is aotmic symbol
  if [[ $1 =~ ^[A-Z]$ || $1 =~ ^[A-Z][A-Z]$ || $1 =~ ^[A-Z][a-z]$ ]]
  then
    #get atomic symbol
    ATOMIC_SYMBOL=$1
    #get atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$ATOMIC_SYMBOL'")
    #get atomic name
    ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$ATOMIC_SYMBOL'")
    #get atomic type id
    ATOMIC_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ATOMIC_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $ATOMIC_TYPE_ID")
    # get atomic mass
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    # get atomic melting point
    ATOMIC_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    # get atomic boiling point
    ATOMIC_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  fi
  #if the argument is aotmic name  
  if [[ $1 =~ ^[A-Za-z]{3,}$ ]]
  then
    #get atomic name
    ATOMIC_NAME=$1
    #get atomic symbol
    ATOMIC_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$ATOMIC_NAME'")
    #get atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$ATOMIC_NAME'")
    #get atomic type id
    ATOMIC_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ATOMIC_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $ATOMIC_TYPE_ID")
    # get atomic mass
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    # get atomic melting point
    ATOMIC_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    # get atomic boiling point
    ATOMIC_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  fi
  if [[ -z $ATOMIC_TYPE ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius."
  fi
fi

