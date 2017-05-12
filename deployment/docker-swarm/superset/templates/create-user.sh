#!/usr/bin/env expect

set timeout 120
spawn fabmanager create-admin --app superset
set username "{{superset.admin.username}}"
set first_name "{{superset.admin.first_name}}"
set last_name "{{superset.admin.last_name}}"
set email "{{superset.admin.email}}"
set password "{{superset.admin.password}}"
expect {
    "Username \\\[admin\\\]:" { send "$username\n";}
}
sleep 2
expect {
    "User first name \\\[admin\\\]:" { send "$first_name\n";}
}
sleep 2
expect {
    "User last name \\\[user\\\]:" { send "$last_name\n";}
}
sleep 2
expect {
    "Email \\\[admin@fab.org\\\]:" { send "$email\n";}
}
sleep 2
expect {
    "Password" { send "$password\n";}
}
sleep 2
expect {
    "Repeat for confirmation:" { send "$password\n"; }
}
expect eof