#!/usr/bin/env bash

echo "$(python3 -m toggl -s ls -f description | sed -n '2 p') | $(python3 -m toggl -s ls -f duration | sed -n '2 p')"

