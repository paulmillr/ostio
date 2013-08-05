config = {api: {}}

production = true

config.api.root = if production
  'http://api.ost.io'
else
  'http://dev.ost.io:3000'

config.api.versionRoot = config.api.root + '/v1'

module.exports = config
