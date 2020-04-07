const isProduction = true;
const api = { root: isProduction ? 'http://api.ost.io' : 'http://dev.ost.io:3000', base: '/v1' };

export {api};
