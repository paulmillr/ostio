utils = require 'lib/utils'
Chaplin = require 'chaplin'

# Application-specific feature detection
# --------------------------------------

# Delegate to Chaplin’s support module
support = utils.beget Chaplin.support

# _(support).extend
  # someMethod: ->

module.exports = support
