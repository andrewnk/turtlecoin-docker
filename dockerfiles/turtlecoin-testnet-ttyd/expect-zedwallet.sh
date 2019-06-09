#!/usr/bin/expect -f

spawn su-exec turtlecoin ttyd tmux new -A -s wallet /usr/local/bin/zedwallet --remote-daemon $env(REMOTE_DAEMON_HOST):$env(REMOTE_DAEMON_PORT)
expect "What would you like to do?:"
send "4\r"
expect "Enter your private spend key:"
send "$env(SPEND_KEY)\r"
expect "Enter your private view key:"
send "$env(VIEW_KEY)\r"
expect "What would you like to call your new wallet?: "
send "$env(WALLET_NAME)\r"
expect "Give your new wallet a password:"
send "$env(WALLET_PASSWORD)\r"
expect "Confirm your new password:"
send "$env(WALLET_PASSWORD)\r"
expect "Hit enter for the sub-optimal default of zero:"
send "0\r"

interact

exit