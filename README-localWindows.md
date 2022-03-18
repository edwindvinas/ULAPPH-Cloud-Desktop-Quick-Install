### ULAPPH Installation in Windows 10

# Create indexes in TDSMEDIA in MEDIA_ID column
curl "http://localhost:6060/all"
curl "http://localhost:6060/create?col=TDSMEDIA"
curl "http://localhost:6060/indexes?col=TDSMEDIA"
curl "http://localhost:6060/index?col=TDSMEDIA&path=MEDIA_ID"