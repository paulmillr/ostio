import React from 'react';
import { Link } from 'react-router';

export default () => {
  return (
    <div>
      <h2>Your open source talks place</h2>
      <p>Ost.io ("open-source talks") is a forum for open-source projects and the best place for discussing project stuff with other users. It is tightly integrated with <a href="https://github.com/">GitHub</a>.</p>

      <p>The main ost.io mission is to replace mailing lists. <strong>Mailing lists are broken!</strong>. They have ugly interface, most of the time you can't read all messages in a comfortable way (instead, you see a plain-text message). Unfortunately, a lot of open-source projects currently still use mailing lists, because there was no replacement for it. Until now.</p>

      <p>To start, click on "Sign in with GitHub" button at the top. You'll be redirected to your account then. If you want to sync your repositories, press the button on your profile or profile of any of your organization. When logged in, you're able to create any thread &amp; post in any repo. If you want to receive email notifications on new posts in your repos and in threads you've commented in, you can enable them in <Link to="/settings">settings</Link>.</p>

      <p>This project is open-source and available on GitHub: (<a href="https://github.com/paulmillr/ostio/">frontend</a>, <a href="https://github.com/paulmillr/ostio-api/">backend</a>). Oh, and there's also <a href="https://github.com/paulmillr/ostio-api#api">API documentation</a>. Follow <a href="http://twitter.com/paulmillr">@paulmillr</a> on twitter to get latest updates.</p>

      <h3>Users</h3>

      <p>
        <strong>2,500 people hosting over 15,000 forum projects already!</strong>
      </p>

      <p>Some popular open-source projects are already using ost.io. Care to join them? You're three clicks away!</p>

      <ul>
        <li><Link to="/@brunch/brunch">Brunch</Link> — lightweight build tool for HTML5 apps.</li>
        <li><Link to="/@chaplinjs/chaplin">Chaplin</Link> — app framework on top of Backbone.js.</li>
        <li><Link to="/@gkz/LiveScript">LiveScript</Link> — more functional-programming oriented CoffeeScript fork.</li>
        <li><Link to="/@Codeception/Codeception">Codeception</Link> — full-stack testing PHP framework.</li>
      </ul>

      <Link className="screenshot-container" to="/@paulmillr">
        <img className="screenshot" src="http://brunch.io/images/screenshots/ostio.png" alt="screenshot" />
      </Link>
    </div>
  );
};
