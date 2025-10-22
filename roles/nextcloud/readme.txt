# start with
/etc/apache2/sites-available/nextcloud.dvorak.xyz.conf
<VirtualHost *:80>
    ServerName nextcloud.dvorak.xyz
    ServerAlias www.nextcloud.dvorak.xyz
    ServerAdmin webmaster@privatundfrei.de
    DocumentRoot /var/www/nextcloud.dvorak.xyz

    <Directory /var/www/nextcloud.dvorak.xyz>
        Options -Indexes +FollowSymLinks
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/nextcloud.dvorak.xyz-error.log
    CustomLog ${APACHE_LOG_DIR}/nextcloud.dvorak.xyz-access.log combined
</VirtualHost>

certbot adds lines an create ssl file

# create link
a2ensite nextcloud.dvorak.xyz

# certbot
certbot --apache -d nextcloud.dvorak.xyz