
firewall-cmd --permanent --add-service=imap  # 143

firewall-cmd --permanent --add-service=imaps  # 993

firewall-cmd --permanent --add-service=smtp  # 25

firewall-cmd --permanent --add-service=smtps # 465

firewall-cmd --permanent --add-service=smtp-submission # 587

firewall-cmd --reload
