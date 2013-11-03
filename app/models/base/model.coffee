config = require 'config'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class Model extends Chaplin.Model
  apiRoot: config.api.versionRoot
  urlKey: 'id'

  urlPath: ->
    ''

  urlParams: ->
    access_token: mediator.user?.get('accessToken') ? localStorage.getItem('accessToken')

  urlRoot: ->
    urlPath = @urlPath()
    if urlPath
      @apiRoot + urlPath
    else if @collection
      @collection.url()
    else
      throw new Error('Model must redefine urlPath')

  url: (data = '') ->
    base = @urlRoot()
    full = if @get(@urlKey)?
      base + encodeURIComponent(@get @urlKey) + data
    else
      base + data
    payload = utils.queryParams.stringify @urlParams()
    url = if payload
      sep = if full.indexOf('?') >= 0 then '&' else '?'
      full + sep + payload
    else
      full
    url
