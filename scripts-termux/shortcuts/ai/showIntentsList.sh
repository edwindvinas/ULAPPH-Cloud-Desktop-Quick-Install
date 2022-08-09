#!/data/data/com.termux/files/usr/bin/bash

INTENTS=$(cat <<-END
quote of the day
quotation
define <word>
definition for <word>
dictionary <word>
dictionary for <word>
word of the day
joke
tell me a joke
news latest
news Philippines
news technology
what is <term>
what is a <term>
what is an <term>
who is <term>
what is the <term>
wiki for <term>
wikipedia for <term>
wikipedia <term>
END
)


termux-dialog text -m -i "${INTENTS}" -t "Sample Intents"

