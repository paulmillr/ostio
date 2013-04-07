config = require 'config'
utils = require 'lib/utils'
Chaplin = require 'chaplin'

# Application-specific view helpers
# ---------------------------------

# http://handlebarsjs.com/#helpers

# Conditional evaluation
# ----------------------

# Choose block by user login status
Handlebars.registerHelper 'ifLoggedIn', (options) ->
  method = if Chaplin.mediator.user then options.fn else options.inverse
  method this

Handlebars.registerHelper 'ifIsRepoAdmin', (options) ->
  user = Chaplin.mediator.user
  return options.inverse(this) unless user
  orgs = user.get('organizations')?.pluck('login') ? []
  repoOwner = @login
  if user.isAdmin() or user.get('login') is repoOwner or repoOwner in orgs
    options.fn(this)
  else
    options.inverse(this)

Handlebars.registerHelper 'ifCanEditPost', (options) ->
  user = Chaplin.mediator.user
  return options.inverse(this) unless user
  orgs = user.get('organizations')?.pluck('login') ? []
  postCreator = @user.login
  repoOwner = @topic.repo.user.login

  if user.isAdmin() or user.get('login') is postCreator or repoOwner in orgs
    options.fn(this)
  else
    options.inverse(this)

# Show keyboard short-cut for posting etc on OS X.
Handlebars.registerHelper 'showShortcut', (options) ->
  if /mac/i.test(navigator.userAgent)
    ' (⌘↩)'
  else
    ''

Handlebars.registerHelper 'showPostUrl', (c, options) ->
  url = Chaplin.helpers.reverse 'topics#show', [@topic.repo.user.login, @topic.repo.name, @topic.number]
  new Handlebars.SafeString "<a class='post-url' href='#{url}'>#{url.slice(2)}</a>"

Handlebars.registerHelper 'showLoginUrl', ->
  {protocol, host} = window.location
  path = Chaplin.helpers.reverse 'auth#callback'
  encodeURIComponent "#{protocol}//#{host}#{path}"

# Map helpers
# -----------

# Make 'with' behave a little more mustachey
Handlebars.registerHelper 'with', (context, options) ->
  if not context or Handlebars.Utils.isEmpty context
    options.inverse(this)
  else
    options.fn(context)

# Make 'with' behave a little more mustachey
Handlebars.registerHelper 'withConfig', (options) ->
  context = config
  Handlebars.helpers.with.call(this, context, options)

# Evaluate block with context being current user
Handlebars.registerHelper 'withUser', (options) ->
  context = Chaplin.mediator.user.getAttributes()
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
      raw = unescapeExpression code
      if language and language of hljs.LANGUAGES
        try
          hljs.highlight(language, raw).value
        catch error
          new Handlebars.SafeString code
      else
        new Handlebars.SafeString code
  new Handlebars.SafeString markdown


Handlebars.registerHelper 'url', (routeName, params..., options) ->
  Chaplin.helpers.reverse routeName, params
