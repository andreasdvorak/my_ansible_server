# Setup of the postfix for gmail

Generate Google App Password for Postfix MTA
https://computingforgeeks.com/configure-postfix-to-relay-emails-using-gmail-smtp/

    vi /etc/postfix/sasl/sasl_password

Add the line:
    [smtp.gmail.com]:587    username@gmail.com:MTA-password

Use postmap to compile and hash the contents of sasl_passwd. The results will be stored in your Postfix configuration directory in the file sasl_passwd.db.
    postmap /etc/postfix/sasl/sasl_password

create file /etc/postfix/generic
root@hostname    andreas.dvorak@gmail.com
@hostname        andreas.dvorak@gmail.com

postmap /etc/postfix/generic

/etc/mailname
FQDN of server

echo "START=yes" >> /etc/default/saslauthd
echo "OPTIONS="-c -m /var/spool/postfix/var/run/saslauthd"" >> /etc/default/saslauthd

mkdir -p /var/spool/postfix/var/run/saslauthd
chown root:sasl /var/spool/postfix/var/run/saslauthd
chmod 750 /var/spool/postfix/var/run/saslauthd
systemctl restart saslauthd

/etc/postfix/sasl/smtp.conf
saslauthd_path: /var/run/saslauthd/mux
pwcheck_method: saslauthd
mech_list: PLAIN LOGIN
log_level: 3

/etc/pam.d/saslauthd
auth    required        pam_unix.so
account required        pam_unix.so

## Variables

put these variables e.g. in the file ../host_vars/FQDN-HOSTNAME

    mydomain: ''
    myhostname: ''


Testen mit Gmail
openssl s_client -connect smtp.gmail.com:587 -starttls smtp


apt install swaks
swaks --to empfaenger@example.com --from deine.email@gmail.com --server smtp.gmail.com:587 --auth LOGIN --auth-user deine.email@gmail.com --tls

testsaslauthd -u deine.email@gmail.com -p dein-app-passwort -s smtp -f /var/spool/postfix/var/run/saslauthd/mux
aber das funktioniert nicht, da es kein tsl spricht