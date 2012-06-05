config = require 'config'
mediator = require 'mediator'
utils = require 'chaplin/lib/utils'

# Application-specific view helpers
# ---------------------------------

# http://handlebarsjs.com/#helpers

# Conditional evaluation
# ----------------------

# Choose block by user login status
Handlebars.registerHelper 'if_logged_in', (options) ->
  if mediator.user
    options.fn(this)
  else
    options.inverse(this)

Handlebars.registerHelper 'if_has_sync_repo_permission', (options) ->
  user = mediator.user
  return options.inverse(this) unless user
  organizations = _(user.get('organizations')).map((org) -> org.login)
  if user.get('login') is @login or @login in organizations
    options.fn(this)
  else
    options.inverse(this)

Handlebars.registerHelper 'if_user_type_is_user', (options) ->
  if mediator.user?.get('type') is 'User'
    options.fn(this)
  else
    options.inverse(this)


Handlebars.registerHelper 'if_on_mac', (options) ->
  if /mac/i.test(navigator.userAgent)
    options.fn(this)
  else
    options.inverse(this)

# Map helpers
# -----------

# Make 'with' behave a little more mustachey
Handlebars.registerHelper 'with', (context, options) ->
  if not context or Handlebars.Utils.isEmpty context
    options.inverse(this)
  else
    options.fn(context)

# Inverse for 'with'
Handlebars.registerHelper 'without', (context, options) ->
  inverse = options.inverse
  options.inverse = options.fn
  options.fn = inverse
  Handlebars.helpers.with.call(this, context, options)

# Make 'with' behave a little more mustachey
Handlebars.registerHelper 'with_config', (options) ->
  context = config
  Handlebars.helpers.with.call(this, context, options)

# Evaluate block with context being current user
Handlebars.registerHelper 'with_user', (options) ->
  context = mediator.user.getAttributes()
  Handlebars.helpers.with.call(this, context, options)

Handlebars.registerHelper 'gravatar', (options) ->
  "https://secure.gravatar.com/avatar/#{options.fn this}?s=140&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png" 

Handlebars.registerHelper 'date', (options) ->
  date = new Date options.fn this
  new Handlebars.SafeString moment(date).fromNow()


unescape = (string) ->
  re = /&(?:#x60|#x27|quot|lt|gt);/g
  replacements =
    '&#x60;': '`'
    '&#x27;': '\''
    '&quot;': '"'
    '&lt;': '<'
    '&gt;': '>'
  unescaped = string.replace re, (substr, index) ->
    replacements[substr]

Handlebars.registerHelper 'markdown', (options) ->
  unescaped = unescape options.fn(this)
  markdown = marked unescaped, gfm: yes, highlight: (code, language) ->
    hljs.highlight(language, code).value
  new Handlebars.SafeString markdown
