exports.config =
  # See http://brunch.io/#documentation for docs.
  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
        'test/javascripts/test.js': /^test(\/|\\)(?!vendor)/
        'test/javascripts/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        before: [
          'vendor/scripts/console-helper.js',
          'vendor/scripts/jquery-1.9.1.js',
          'vendor/scripts/lodash-1.2.0.js',
          'vendor/scripts/backbone-1.0.0.js'
        ]

    stylesheets:
      joinTo: 'stylesheets/app.css'
      order:
        after: ['vendor/styles/helpers.css']

    templates:
      joinTo: 'javascripts/app.js'
