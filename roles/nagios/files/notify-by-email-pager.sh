#!/bin/bash
if [[ ! -z "$NAGIOS_SERVICEDESC" ]]; then 
    SERVICEDESC="/$NAGIOS_SERVICEDESC"
    OUTPUT="$NAGIOS_SERVICEOUTPUT"
else
    SERVICEDESC=""
    OUTPUT="$NAGIOS_HOSTOUTPUT"
fi

if [[ "$NAGIOS_NOTIFICATIONTYPE" == "RECOVERY" ]]; then
    SUBJECT="Recovery: ${NAGIOS_HOSTNAME}${SERVICEDESC}"
    MESSAGE="$OUTPUT"
elif [[ "$NAGIOS_NOTIFICATIONTYPE" == "PROBLEM" ]]; then
    SUBJECT="Alert: ${NAGIOS_HOSTNAME}${SERVICEDESC}"
    MESSAGE="$OUTPUT"
elif [[ "$NAGIOS_NOTIFICATIONTYPE" == "ACKNOWLEDGEMENT" ]]; then
    SUBJECT="Ack: ${NAGIOS_HOSTNAME}${SERVICEDESC}"
    MESSAGE="$NAGIOS_NOTIFICATIONCOMMENT"
elif [[ "$NAGIOS_NOTIFICATIONTYPE" == "CUSTOM" ]]; then
    SUBJECT="Custom: ${NAGIOS_HOSTNAME}${SERVICEDESC}"
    MESSAGE="$NAGIOS_NOTIFICATIONCOMMENT"
fi

/usr/bin/printf "%b" "$MESSAGE\n" | /bin/mail -s "$SUBJECT" $NAGIOS_CONTACTEMAIL
