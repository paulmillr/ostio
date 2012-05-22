mediator = require 'mediator'
ChaplinModel = require 'chaplin/models/model'

module.exports = class Model extends ChaplinModel
  apiRoot: 'http://localhost:3000/v1'
  urlKey: 'id'

  urlPath: ->
    ''

  urlParams: ->
    access_token: mediator.user?.get('accessToken')

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
      base + encodeURIComponent(@get(@urlKey)) + data
    else
      base + data
    sep = if full.indexOf('?') >= 0 then '&' else '?'
    params = @urlParams()
    payload = _.keys(params)
      .map (key) ->
        [key, params[key]]
      .filter (pair) ->
        pair[1]?
      .map (pair) ->
        pair.join('=')
      .join('&')
    url = if payload
      full + sep + payload
    else
      full
    url

  fetch: (options) ->
    @trigger 'loadStart'
    (options ?= {}).success = =>
      @trigger 'load'
    super
