/**
 * @author Adam Meadows <adam.meadows@gmail.com>
 * @copyright 2015 Adam Meadows. All rights reserved.
 */

'use strict';

require('./style/main.less');
const template = require('./tmpl/main.jade');
const $ = require('jquery');
const users = require('aiw-api').users();

const ns = {
    render: function (element) {
        users.current().then(
            res => {
                $(element).append(template({
                    content: JSON.stringify(res.body, null, 4),
                }));
            }
        ).done();
    },
};

window.users = users;
window.main = ns;

module.exports = ns;
