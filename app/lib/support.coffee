utils = require 'lib/utils'
Chaplin = require 'chaplin'

# Application-specific feature detection
# --------------------------------------

# Delegate to Chaplin’s support module
support = utils.beget Chaplin.support

# _.extend support,
  # someMethod: ->

module.exports = support
