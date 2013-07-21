# This htaccess file is generated from a template supplying server paths.  Run scripts/create_htaccess.php to generate.

<Files .htaccess>
order allow,deny
deny from all
</Files>

RewriteEngine on
RewriteBase {{ BETA_ROOT_URL }}

# Set some rewrite environment vars
RewriteRule ^.*$ - [E=STRIPPED_REQUEST:$0]
RewriteRule . - [E=SITE_BASE:{{ BETA_ROOT_PATH }}]

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_URI} !(.*)/$
RewriteRule ^.*$ $0/ [L,R=301]

# Redirect everything else through the index file
RewriteCond %{ENV:STRIPPED_REQUEST} !^index\.php
RewriteCond %{ENV:STRIPPED_REQUEST} !^static/?
RewriteRule . index.php [L]
