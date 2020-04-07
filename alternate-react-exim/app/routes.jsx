import React from 'react';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';

import App from 'components/App';
import AuthCallback from 'components/AuthCallback';
import Home from 'components/Home';
import Feed from 'components/Feed';
import Search from 'components/Search';
import Profile from 'components/Profile';
import Repos from 'components/Repos';
import Repo from 'components/Repo'
import Topic from 'components/Topic';
import Settings from 'components/Settings';

const Routes = <Router history={browserHistory}>
  <Route path="/" component={App}>
    <IndexRoute component={Home} />
    <Route path="/auth-callback" component={AuthCallback} />
    <Route path="/feed" component={Feed} />
    <Route path="/search" component={Search} />
    <Route path="/settings" component={Settings} />
    <Route path="/@:login" component={Profile}>
      <IndexRoute component={Repos} />
      <Route path=":repo/topics/:topic" component={Topic} />
      <Route path=":repo" component={Repo}>
      </Route>
    </Route>
  </Route>
</Router>;

export default Routes;
