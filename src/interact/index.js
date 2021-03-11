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


const va = require('./VirtualAlexa');
const fs = require('fs');

function handler(params) {
    params =  { skill: 'smarthome', utter: 'open smarthome to I love Taylor Swift'};

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

    console.log('skill:', params.skill, ', utter:', params.utter);
    const model = fs.readFileSync(__dirname + '/models/model-'+params.skill+'.json')
    const modelJson = JSON.parse(model.toString());
    var alexa = new va.VirtualAlexa(modelJson);
    let response = alexa.utter(params.utter, params.skill).json()

    var endTime = process.hrtime(beginTime);
    var interval = parseInt(endTime[0] * 1e6 + endTime[1]*1e-3);
    console.log('interact exe costs: ', interval, 'us' )

    return response;

}

exports.handler = handler
