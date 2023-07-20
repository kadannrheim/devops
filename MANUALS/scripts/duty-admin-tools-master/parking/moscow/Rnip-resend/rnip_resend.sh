#!/bin/bash
set -e

if [ $# -gt 1 ]; then
  DATE_FROM=$1
  DATE_TO=$2
fi
if [ -z $DATE_FROM ]; then
  echo "Usage example $0 2021-12-15T18:50:00.000 2021-12-15T21:00:00.000"
  exit 1
fi

PG_DB=${PG_DB:-mskparking_rnip_integration}
PG_USER=${PG_USER:-rnip_integration}
PG_PASS=${PG_PASS:-"jF02l0!7&fErtL-1"}
PG_HOST=${PG_HOST:-127.0.0.1}
PG_PORT=${PG_PORT:-5432}

UUID=$(uuid -v1)

PGPASSWORD=$PG_PASS psql -h $PG_HOST -U $PG_USER -p $PG_PORT -d $PG_DB -c "INSERT INTO public.requests (id, \"type\", date_from, date_to, message_status, create_date, message_id, current_page_index) VALUES (nextval('requests_id_seq'), 'RNIP_PAYMENT_REQUEST', '$DATE_FROM', '$DATE_TO', 'NEW', CURRENT_TIMESTAMP, '$UUID', 1);"
echo $UUID

