curl -v --location --request GET 'http://127.0.0.1:2046/application/alexa_v2' \
--header 'Step-Name: frontend' \
--header 'Content-Type: application/json' \
--data-raw '{
    "utter" : "open smarthome to I love Taylor Swift"
}'

# Note: To see logs, add -v after curl
