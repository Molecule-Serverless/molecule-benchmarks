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

const door_handler = require('./door-handler').handler


async function invoke(args) {
    let result = await door_handler.invoke(args);
    return result;
}
function handler(args) {
    args =  {
	    context: { 
		    System: { application: {} } 
	    }, 
	    request: { 
		    locale: 'en-US',
		    requestId: 'amzn1.echo-external.request.532b9a7f-5dcb-4d3b-a366-740e095ddcf5',  
		    timestamp: '2021-03-11T10:23:19Z',
		    type: 'LaunchRequest' 
	    },
	    version: '1.0',
	    session: { 
		    application: {}, 
		    'new': true, 
		    sessionId: 'SessionID.2bbe5504-dcc3-4239-9518-28d0e91457b6' } 
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
    console.log("args in door-index :%o", args)

    let response = invoke(args);

    var endTime = process.hrtime(beginTime);
    var interval = parseInt(endTime[0] * 1e6 + endTime[1]*1e-3);
    console.log('light exe costs: ', interval, 'us' )

    return response
}

exports.handler = handler
