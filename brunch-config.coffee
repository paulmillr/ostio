exports.config =
  # See http://brunch.io/#documentation for docs.
  npm:
    enabled: true

    globals:
      moment: 'moment'
      _cp: 'console-polyfill'
      _: 'underscore'
      $: 'jquery'
      Davy: 'davy'
      Backbone: 'backbone'
      Chaplin: 'chaplin'
      Exoskeleton: 'exoskeleton'

    aliases:
      backbone: 'exoskeleton'

    styles:
      'normalize.css': ['normalize.css']

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(node_modules|vendor)/
      order:
        before: [/underscore/]

    stylesheets:
      joinTo: 'stylesheets/app.css'
      order:
        before: [/normalize/]
        after: ['vendor/styles/helpers.css']

    templates:
      joinTo: 'javascripts/app.js'
