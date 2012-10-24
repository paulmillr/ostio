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

Handlebars.registerHelper 'markdown', (options) ->
  repo = @topic.repo
  login = repo.user.login
  repoName = repo.name
  string = options.fn(this)

  markdown = marked string,
    gfm: yes,
    inlineModifier: (text) ->
      # Replace patterns:
      # * `gh-143` with link to github issue 143.
      # * `@name` with link to ost.io user.
      repl = "[**gh-$1**](https://github.com/#{login}/#{repoName}/issues/$1)"
      text
        .replace(/gh\-?(\d+)/g, repl)
        .replace(/@([\w\.]+)/g, '[**@$1**](/$1)')
    highlight: (code, language) ->
      if language
        try
          hljs.highlight(language, code).value
        catch error
          code
      else
        code
  new Handlebars.SafeString markdown
