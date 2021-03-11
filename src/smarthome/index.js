/*
 * Copyright (c) 2020 Institution of Parallel and Distributed System, Shanghai Jiao Tong University
 * ServerlessBench is licensed under the Mulan PSL v1.
 * You can use this software according to the terms and conditions of the Mulan PSL v1.
 * You may obtain a copy of Mulan PSL v1 at:
 *     http://license.coscl.org.cn/MulanPSL
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
 * PURPOSE.
 * See the Mulan PSL v1 for more details.
 */

const smarthome_handler = require('./smarthome-handler').handler

async function invoke(args) {
    let result = await smarthome_handler.invoke(args);
    console.log("smarthome invoke result.response: %o", result.respons)
    return result.response.json();
}

function handler(args) {
    args = { 
	    context: {
		    System: { application: {} }},
	    request: {
		    locale: 'en-US', 
		    requestId:  'amzn1.echo-external.request.c2ac317f-ed36-4c8f-90a3-23723ad0ea2a', 
		    timestamp: '2021-03-11T10:23:19Z', 
		    type: 'IntentRequest',
		    intent: {
			    name: 'EnterHomeIntent',
			    slots: { 
				    password: {
					    name: 'password', 
					    value: 'Taylor Swift' }
			    }
	    	}
	    },
	    version: '1.0',
	    session:  { 
		    application: {},
		    'new': true,
		    sessionId: 'SessionID.f061d76a-ce58-45e3-be52-d839d91e1a17', 
		    attributes: {}
	    } 
	 };
    var beginTime = process.hrtime();
    var date = new Date();
    const year = date.getFullYear();
    const month = ("0" + (date.getMonth() + 1)).slice(-2);
    const day = ("0" + (date.getDate())).slice(-2);
    const hour = ("0" + (date.getHours())).slice(-2);
    const minute = ("0" + (date.getMinutes())).slice(-2);
    const second = ("0" + (date.getSeconds())).slice(-2);
    const millisecond = ("00" + (date.getMilliseconds())).slice(-3);

    var datestr = "[" + year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + "." + millisecond + "Z]";


    let result = invoke(args)

    var endTime = process.hrtime(beginTime);
    var interval = parseInt(endTime[0] * 1e6 + endTime[1]*1e-3);
    console.log('smarthome exe costs: ', interval, 'us' )

    return result

  /*  var response = await handler.invoke(args);

    console.log(`RESPONSE++++${JSON.stringify(response)}`);

    response['startTimes'] = {"controllers": response['startTimes'], "smarthome": datestr};
    return response;
   */
}

exports.handler = handler
