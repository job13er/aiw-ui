/**
 * @author Adam Meadows <adam.meadows@gmail.com>
 * @copyright 2015 Adam Meadows. All rights reserved.
 */

'use strict';

var loaders = require('beaker/config/webpack/loaders');
var resolve = require('beaker/config/webpack/resolve');
var webpack = require('webpack');

module.exports = {
    entry: {
        app: './src/index.6.js',
    },

    devtool: 'cheap-module-source-map',

    output: {
        path: 'bundle',
        publicPath: 'bundle/',
        filename: 'app-entry.js',
        pathinfo: true,
    },

    plugins: [
        new webpack.DefinePlugin({
            'process.env': {
                'MOCK_APIS': process.env.MOCK_APIS,
                'MOCK_ADMIN': process.env.MOCK_ADMIN,
            },
        }),
    ],

    module: {
        loaders: loaders,
    },

    resolve: resolve,
};
