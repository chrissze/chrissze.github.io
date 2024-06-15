
firewall-cmd --permanent --add-service=smtp

firewall-cmd --permanent --add-service=smtps

firewall-cmd --permanent --add-service=pop3

firewall-cmd --permanent --add-service=pop3s

firewall-cmd --permanent --add-service=imap

firewall-cmd --permanent --add-service=imaps

firewall-cmd --reload
