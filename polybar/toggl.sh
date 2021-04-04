#!/bin/bash

TIMERS=$(python -m toggl -s ls -f description)
DURATIONS=$(python -m toggl -s ls -f duration)

TIMERS_SPACED="${TIMERS//$'\n'/'±'}"
DURATIONS_SPACED="${DURATIONS//$'\n'/'±'}"

SAVEIFS=$IFS  
IFS='±'     
TIMERLIST=($TIMERS_SPACED)
DURATIONLIST=($DURATIONS_SPACED)
IFS=$SAVEIFS  

echo "${TIMERLIST[1]} | ${DURATIONLIST[1]}"

