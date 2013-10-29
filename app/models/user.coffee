Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports = class User extends Model
  urlKey: 'login'

  urlPath: ->
    '/users/'

  parse: (response) ->
    return @previousAttributes unless response?
    options = {model: User}
    if response.organizations?
      organizations = new Collection response.organizations, options
      Backbone.utils.extend response, {organizations}
    if response.owners?
      owners = new Collection response.owners, options
      Backbone.utils.extend response, {owners}
    response

  # Ideally, there should be a special model field for this.
  isAdmin: ->
    @get('login') is 'paulmillr'
