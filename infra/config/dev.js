// default config
const config = require('./default')

// get the js file name but strip off the extension
const stage = __filename.split('/').pop().split('.').shift();

module.exports = Object.assign(config, {
    // override default config here
    domain: `${stage}.${config.domain}`,
    stage,
});