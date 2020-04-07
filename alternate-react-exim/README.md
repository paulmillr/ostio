# Ostio + Exim = <3

>Your open-source talks place.

[Ost.io](http://ost.io) ("open-source talks") is a forum for open-source projects and the best place for discussing project stuff with other users. It is tightly integrated with GitHub. The main ostio mission is to replace mailing lists.

Ost.io apps are [TodoMVC](http://todomvc.com)-like set of example applications, which hopes to offer more complex apps.

We think example app should be:

1. Real-world. Ost.io support forum will be self-hosted. Ost.io is already
   used by popular open-source projects.
2. Complex. TodoMVC is simple, but does not show advanced framework features.
3. Useful besides its main purpose.

This is a [React](https://facebook.github.io/react/) + [Exim](http://github.com/hellyeahllc/exim) implementation of the [Ostio front-end](https://github.com/paulmillr/ostio).

---

[![](http://brunch.io/images/screenshots/ostio.png)](http://ost.io/@paulmillr)

## Stack
The stack is cloned from [brunch with exim](https://github.com/hellyeah/brunch-with-exim) skeleton.
Use brunch with exim if you want to build new application:

`brunch new <project name> -s exim`

### Brunch
[Brunch](http://brunch.io) is a html5 application builder that's
agnostic to programming langs and frameworks. In this case,
ES6 is used with Stylus, React, Exim, and javascript libs.

`brunch-config.js` contains brunch configuration, `package.json` contains
brunch plugins.

### Other
* [Marked.js](https://github.com/chjj/marked): renders GitHub-flavored Markdown.
* [Moment.js](http://momentjs.com): lightweight javascript date library.

## Getting started
* Clone the project.
* Install brunch via nodejs: `npm install -g brunch`
* Install brunch plugins: `npm install`
* Run `brunch watch --server` (or `brunch build` if you'll listen webserver on `public/`)
* Open `dev.ost.io:3333` (set dev.ost.io to `127.0.0.1`)
* Run [backend](https://github.com/paulmillr/ostio-api) if you want to use it locally
  or use default api.ost.io (configurable in `app/config.js`).

(*No deploy script here yet.* Deploy via: `sudo sh bin/deploy`)
