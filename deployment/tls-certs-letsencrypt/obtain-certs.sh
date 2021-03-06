#!/bin/bash
# Based on http://blog.thesparktree.com/post/138999997429/generating-intranet-and-private-network-ssl

# Passing HTTP challenge is a bit tricky under PaaS (problem and solution explained well in
# https://blog.semicolonsoftware.de/securing-dokku-with-lets-encrypt-tls-certificates/);
# DNS challenge is nicer, doesn't interfere with the app itself in any way.
# It's especially convenient for obtaining a multi-domain cert, and installing it
# on both RHCloud and Heroku.

set -e -u -o pipefail
set -x

# Create one combined cert for all domains - best for Heroku.
MAIN_DOMAIN='mathdown.net'
ALT_DOMAINS='www.mathdown.net www.mathdown.com mathdown.com'

CERTS_DIR="./certs"
BASH=(bash)

## DEBUG - TODO MAKE OPTIONS
## TODO: $CA IS IGNORED, ALWAYS USES acme-v01 ?
## POSSIBLY https://github.com/lukas2511/dehydrated/blob/master/docs/troubleshooting.md#no-registration-exists-matching-provided-key
#CERTS_DIR="./certs-acme-staging"
#set -x CA "https://acme-staging.api.letsencrypt.org/directory"
#BASH=(bash -x)

export PROVIDER=dnsimple
export LEXICON_DNSIMPLE_USERNAME=beni.cherniavsky@gmail.com
# Note: dnsimple supports sub-accounts.  I've created a 'mathdown' sub-account
# but so far kept the domains under beni.cherniavsky, don't remember why.
if [[ -z "${LEXICON_DNSIMPLE_TOKEN:-}" ]]; then
    echo 'Error: LEXICON_DNSIMPLE_TOKEN env var must be set (https://dnsimple.com/user)'
    exit 1
fi
# TODO: will token work if I enable DNSimple 2FA?

cd "$(dirname "$0")"

echo $'\n== INSTALLING =='
virtualenv -p python2 ./lexicon_venv/
export PATH="$PWD/lexicon_venv/bin/:$PATH"

pip install --upgrade ./lexicon/

echo $'\n== TESTING DNS CONTROL =='
lexicon "$PROVIDER" list "$MAIN_DOMAIN" CNAME

echo $'\n== OBTAINING CERTS =='

mkdir -p "$CERTS_DIR"
"${BASH[@]}" ./dehydrated/dehydrated --cron --challenge dns-01 --hook ./lexicon/examples/letsencrypt.default.sh --domain "$MAIN_DOMAIN $ALT_DOMAINS" --out "$CERTS_DIR" | tee -a "$CERTS_DIR/letsencrypt.out"

echo '$\n== RESULTS =='

./show-cert.sh "$CERTS_DIR/$MAIN_DOMAIN/fullchain.pem"

ls -ltr "$CERTS_DIR/$MAIN_DOMAIN/" "$CERTS_DIR/letsencrypt.out"
