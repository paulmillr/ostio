config = require 'config'
mediator = require 'mediator'
utils = require 'lib/utils'

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

Handlebars.registerHelper 'if_is_repo_admin', (options) ->
  user = mediator.user
  return options.inverse(this) unless user
  orgs = user.get('organizations')?.pluck('login') ? []
  repoOwner = @login
  if user.isAdmin() or user.get('login') is repoOwner or repoOwner in orgs
    options.fn(this)
  else
    options.inverse(this)

Handlebars.registerHelper 'if_can_edit_post', (options) ->
  user = mediator.user
  return options.inverse(this) unless user
  orgs = user.get('organizations')?.pluck('login') ? []
  postCreator = @user.login
  repoOwner = @topic.repo.user.login

  if user.isAdmin() or user.get('login') is postCreator or repoOwner in orgs
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
  "https://secure.gravatar.com/avatar/#{options.fn this}?s=140
&d=https://a248.e.akamai.net/assets.github.com
%2Fimages%2Fgravatars%2Fgravatar-140.png"

Handlebars.registerHelper 'date', (options) ->
  date = new Date options.fn this
  new Handlebars.SafeString moment(date).fromNow()

escape =
  "&amp;": "&"
  "&lt;": "<"
  "&gt;": ">"
  "&quot;": '"'
  "&#x27;": "'"
  "&#x60;": "`"

badChars = /&(?:amp|lt|gt|quot|#x27|x60);/g
possible = /&(?:amp|lt|gt|quot|#x27|x60);/

escapeChar = (chr) ->
  escape[chr] ? "&"

escapeExpression = Handlebars.Utils.escapeExpression

unescapeExpression = (string) ->
  if string instanceof Handlebars.SafeString
    string.toString()
  else if not string
    ''
  else if not possible.test(string)
    string
  else
    string.replace(badChars, escapeChar)

Handlebars.registerHelper 'markdown', (options) ->
  repo = @topic.repo
  login = repo.user.login
  repoName = repo.name
  string = escapeExpression(options.fn this).replace /&#x60;/g, '`'

  markdown = marked string,
    gfm: yes,
    highlight: (code, language) ->
      # ಠ_ಠ
      reEscaped = escapeExpression unescapeExpression code
      if language
        try
          hljs.highlight(language, unescapeExpression reEscaped).value
        catch error
          reEscaped
      else
        reEscaped
  new Handlebars.SafeString markdown
