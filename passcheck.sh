#!/bin/bash
PASSWD_WRONG=true
while [[ "$PASSWD_WRONG"=true ]]; do
    read -srep "Enter a password:"$'\n' PASSWORD
    read -srep "Re-enter your password:"$'\n' PASSCHECK
    if [[ "$PASSWORD" == "$PASSCHECK" ]]; then
        break
    fi
    echo "Your passwords do not match!"
done