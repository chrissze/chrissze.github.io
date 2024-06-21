
./setup.sh   # show options


# pw SHA512 hash ./docker-data/dms/config/postfix-accounts.cf (hx2 l2S0; hxN CD1/)

./setup.sh email add cs@nutdb.com  # will prompt for pw

./setup.sh email update cs@nutdb.com  # update pw


# Delete login user
# prompt to ask if deleting mailbox at /var/mail/nutdb.com/xxx
./setup.sh email del xxx@nutdb.com 

./setup.sh email list




./setup.sh alias add virtual@220122.xyz real@220122.xyz

./setup.sh alias del virtual@220122.xyz real@220122.xyz

./setup.sh alias list    # SHOWS virtual@220122.xyz real@220122.xyz

