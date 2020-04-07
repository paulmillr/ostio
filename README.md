# Ost.io

[Ost.io](http://ost.io) ("open-source talks") is a forum for open-source projects and the best place for discussing project stuff with other users. It is tightly integrated with GitHub. The main ostio mission is to replace mailing lists.

Ost.io apps are [TodoMVC](http://todomvc.com)-like set of example applications, which hopes to offer more complex apps.

We think example app should be:

1. Real-world. Ost.io support forum will be self-hosted. Ost.io is already
   used by popular open-source projects.
2. Complex. TodoMVC is simple, but does not show advanced framework features.
3. Useful besides its main purpose.

There are currently two main examples of ostio apps:

- [**React + Exim**](https://github.com/paulmillr/ostio-exim) implementation from 2016. Very useful if you'd love to know how to make real-world apps with React.
- [**Backbone + Chaplin**](https://github.com/paulmillr/ostio-chaplin) app. This is the first and initial app, made in 2012.

## Features

Features we initially feel it should capture:

* Multi-view
* Multi-level hierarchies, modals
* Captures CRUD
* Authentication, session management
* Register, login, logout
* Demonstrates github login
* Uses a dedicated backend for data
* State management / routing
* Precompiled templates
* Sub-views
* Mobile support
* Animations

# Examples

For initial launch, we need at least three apps.

You may pick any stack you want. Just stick to the
look-and-feel specification.
Though we **suggest** to use [Bower](http://bower.io)
for dependency management
and [Mocha](http://mochajs.org/) for tests.

Any transpiled languages (coffee, typescript, elm) are very welcome.

For list of current implementations, see **apps/** directory.

# Specification

Feel free to submit any proposals.

## Structure

Develop your application in your own repository and
send us a pull request that will add
[git submodule](http://git-scm.com/book/en/Git-Tools-Submodules)
to `apps` directory.

For example, if you’re making angular app built with Grunt,
send us `angular-grunt` submodule.

# General

See [http://ost.io](http://ost.io) for general example of how app should behave. Source: [https://github.com/paulmillr/ostio](https://github.com/paulmillr/ostio/).

* **UX:** Must look exactly the same. Try to reuse existing styles. Box-sizing: border-box must be used for simplicity of calculations.

* **Compatibility:** IE9+, modern Firefox, Chrome, Safari (including mobile)

* **Structure:** Files in `app` dir, libs in `vendor` dir unless other is specified by your framework.

* **Routing:** Required, with pushState. Routes:

    * `/` — **home** page. Contains description text.
    * `/auth-callback` — endpoint for OAuth redirection.
    * `/feed` — **feed**, contains last users and posts.
    * `/settings` — user **settings.**
    * `/@:login` — **user** page. Contains user info, repos and organisations.
    * `/@:login/:repo` — **repository** page. Contains current repo topics with their stats.
    * `/@:login/:repo/topics/:topic` — **topic** page. Contains topic posts.

# Common

## API & Auth

App plays with OAuth REST API at [http://api.ost.io](http://api.ost.io/) (source: [https://github.com/paulmillr/ostio-api](https://github.com/paulmillr/ostio-api)). App must have a simple way [in code] to switch between API endpoints. **Auth token** must be stored in local storage. No cookies.

*// we should likely also provide backend specification for people who want to show how it can be alternatively done with their stack*

## Header

Located on top of application. Contains link to **home**, **feed**.

If logged-in, also contains links to current **user** with his name, **settings** and **logout**.

When clicked on **logout**, the app should destroy the session. If user was on **settings** page, he must be redirected to `/`. On any other page user must not be redirected.

Otherwise, contains login button. Must have its own persistent view.

## Breadcrumbs

Located under the header, on **user**, **repository** or **topic** pages. Example for **topic** page:

`[:user avatar] :user / :repo / #:number`. Must have its own persistent view.

## Spinners

When creating new post or topic, button that was pressed by user must change its state and its contents must turn into spinner.

# Pages

## Home

Contains description of an application, description of taste.js project, links to frontend and backend implementations and api docs. Also, top repos and screenshot of users page.

## Auth callback

A page to which oauth authentication redirects. Receives credentials (access token & current user).

## Logout

Destroys current session, clears local storage. Must be done without page reloading.

## Feed

24 latest users. Just their avatars with links to them.

20 latest posts. Each post has:

* user **avatar** with link to user

* **username** also with link to user

* a **repo** and **topic** where it was posted

* post **date**

* **contents**

* **edit** and **delete** buttons if it’s written by current user or in a current user repository or in repository of organization that current user is in.

## Settings

A simple page with switches, radio buttons etc. Clicking on switch immediately submits API request.

## User

Repositories list (also, GitHub icon with link to GitHub profile)

Organizations list (just avatars with links)

If it’s current user or organization that current user is in, also has "Sync GitHub repos" button which updates repositories list.

## Repository

Topics list. Each topic has:

* Number (#35 etc) with link to topic

* Topic name with link to topic

* Topic author

* Date

* Post count

Also has GitHub icon with link to repository on GitHub.

## Topic

Topic name, then posts (see feed) and new post form. Posts must be without post location, unlike in feed.

# Links

Example app: [http://ost.io/](http://ost.io/)

Frontend source code: [https://github.com/paulmillr/ostio](https://github.com/paulmillr/ostio)

Backend source code: [https://github.com/paulmillr/ostio-api](https://github.com/paulmillr/ostio-api)

Building an app with Ember: [http://www.youtube.com/watch?v=Ga99hMi7wfY](http://www.youtube.com/watch?v=Ga99hMi7wfY)

Support for complex nested hierarchies: [http://stackoverflow.com/questions/12863663/angularjs-complex-nesting-of-partials-and-templates](http://stackoverflow.com/questions/12863663/angularjs-complex-nesting-of-partials-and-templates)

Runnable Ember app spec: [http://www.youtube.com/watch?v=heK78M6Ql9Q](http://www.youtube.com/watch?v=heK78M6Ql9Q)

Jasmine tactics screencast: [http://searls.testdouble.com/posts/2013-03-21-jasmine-tactics-screencast.html](http://searls.testdouble.com/posts/2013-03-21-jasmine-tactics-screencast.html)
