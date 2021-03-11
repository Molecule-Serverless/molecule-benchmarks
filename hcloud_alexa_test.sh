#!/bin/bash
function init_function() {
	function_name=$1
	function_zip=$2
	function_runtime=$3
	function_service=$4
	function_base64=$(base64 "${function_zip}")  
	request_json="{
	\"functionName\" : \"$function_name\",
	\"handler\": \"index.handler\",
	\"instanceConcurrency\": 1,
	\"instanceType\": \"弹性\",
	\"memorySize\": 128,
	\"regionId\": \"1777\",
	\"runEnv\": \"$function_runtime\",
	\"serviceName\": \"$function_service\",
	\"timeout\": 60,
	\"code\": {
	\"zipFile\": \"$function_base64\"
}
}"


echo "$request_json" | curl --location --request POST 'http://127.0.0.1:30342/creatFunction' \
	--header 'Content-Type: application/json' \
	-d @-
}

 init_function frontend ./frontend.zip nodejs10 nodejs-test
 init_function interact ./interact.zip nodejs10 nodejs-test
 init_function door ./door.zip nodejs10 nodejs-test
 init_function light ./light.zip nodejs10 nodejs-test
 init_function smarthome ./smarthome.zip nodejs10 nodejs-test

curl --location --request POST 'http://127.0.0.1:30342/application/' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	"name":"alexa_v2",
	"entryStep": "frontend",
	"steps": {
	"frontend": {
	"stepName": "frontend",
	"type": "function",
	"function": {
	"functionName": "frontend",
	"nextStep": "interact"
}
},
"interact": {
"stepName": "interact",
"type": "function",
"function": {
"functionName": "interact",
"nextStep": "smarthome"
}
},
"smarthome": {
"stepName": "smarthome",
"type": "function",
"function": {
"functionName": "smarthome",
"nextStep": "all"
}
},
"all": {
"stepName": "all",
"type": "parallel",
"parallel": {
"targets": ["door", "light"],
"nextStep": "end"
}
},
"door": {
"stepName": "door",
"type": "function",
"function": {
"functionName": "door",
"nextStep": "end"
}
},
"light": {
"stepName": "light",
"type": "function",
"function": {
"functionName": "light",
"nextStep": "end"
}
},
"end": {
"stepName": "end",
"type": "end",
"end": {
"stepName": "end"
}
}
}
}'
