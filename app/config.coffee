config = {api: {}}

production = yes

config.api.root = if production
  'http://api.ost.io'
else
  'http://ost.io:3000'

config.api.versionRoot = config.api.root + '/v1'

module.exports = config
