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


function parseSkill(utter) {
    const regex = /(ask|open|launch|talk to|tell) (.*)/i;
    const result = regex.exec(utter);
    if (result && result.length) {
        console.log('result[0,1,2]: ' + result[0] + ', ' + result[1] + ', ' + result[2]);
        return result[2]; // smarthome to I love Taylor Swift
    } else {
        return undefined;
    }
}

function parseIntent(utter) {
    const regex = /(.*) to (.*)/i;
    const result = regex.exec(utter);
    if (result && result.length) {
        return {'skill': result[1], 'utter': 'open ' + utter}
    } else {
        return {'skill': utter, 'utter': 'open ' + utter}
    }
}

function handler(params) {
    console.log('hello frontend');
    //retval = {'speakOutput': 'i cannot understand you, please repeat'};
    //return retval

    params = {'utter': 'open smarthome to I love Taylor Swift'};


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

    var utteranceString = params.utter;
    console.log('utter: ' + utteranceString);
    var skill = parseSkill(utteranceString);
    console.log('skill: ' + skill);
    var retval;
    if (skill === undefined) {
        console.log("cannot parse skill from utterance: " + utteranceString);
        retval = {'speakOutput': 'i cannot understand you, please repeat'};
    }else{ 
	retval = parseIntent(skill);
    }
    var endTime = process.hrtime(beginTime);
    var interval = parseInt(endTime[0] * 1e6 + endTime[1]*1e-3);
    console.log('frontend exe costs: ', interval, 'us' )
    return retval;
    //return parseIntent(skill)
}

exports.handler = handler
