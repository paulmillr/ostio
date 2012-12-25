utils = require 'lib/utils'
View = require 'views/base/view'
template = require './templates/login'

module.exports = class LoginView extends View
  autoRender: yes
  container: '#page-container'
  id: 'login'
  template: template

  # Expects the serviceProviders in the options.
  initialize: (options) ->
    super
    @initButtons options.serviceProviders

  # In this project we currently only have one service provider and therefore
  # one button. But this should allow for different service providers.
  initButtons: (serviceProviders) ->
    _.each serviceProviders, (serviceProvider, serviceProviderName) =>
      bind = (fn) =>
        _(fn).bind this, serviceProviderName, serviceProvider

      buttonSelector = ".#{serviceProviderName}"
      @$(buttonSelector).addClass('service-loading')

      @delegate 'click', buttonSelector, bind @loginWith
      serviceProvider.done bind @serviceProviderLoaded
      serviceProvider.fail bind @serviceProviderFailed

  loginWith: (serviceProviderName, serviceProvider, event) ->
    event.preventDefault()
    return unless serviceProvider.isLoaded()
    @publishEvent 'login:pickService', serviceProviderName
    @publishEvent '!login', serviceProviderName

  serviceProviderLoaded: (serviceProviderName) ->
    @$(".#{serviceProviderName}").removeClass('service-loading')

  serviceProviderFailed: (serviceProviderName) ->
    @$(".#{serviceProviderName}")
      .removeClass('service-loading')
      .addClass('service-unavailable')
      .attr('disabled', true)
      .attr('title', "Error connecting. Please check whether you are
blocking #{utils.upcase(serviceProviderName)}.")
