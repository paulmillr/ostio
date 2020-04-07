import React from 'react';
import { Link } from 'react-router';
import { api } from 'config';
import usersStore from 'stores/users';
import Avatar from 'components/common/Avatar';

const HeaderLink = ({ to, children }) => {
  return <h4 className="header-link"><Link to={to}>{children}</Link></h4>;
};

const HeaderAuth = React.createClass({
  mixins: [
    usersStore.connect('currentUser')
  ],

  getInitialState() { return {}; },

  logout(e) {
    e.preventDefault();
    usersStore.actions.logout();
  },

  render() {
    const {currentUser} = this.state;

    if (currentUser) {
      const profilePath = '/@' + currentUser.login;

      return <div className="header-auth">
        <Link to={profilePath}><Avatar className="header-avatar" url={currentUser.avatar_url} /></Link>
        <Link to={profilePath}>{currentUser.login}</Link>
        <Link to="/settings" className="icon icon-cog" />
        <a href="#" className="icon icon-logout" onClick={this.logout} />
      </div>;
    } else {
      const {protocol, host} = window.location;
      const cbUrl = encodeURIComponent(protocol + '//' + host + '/auth-callback');
      const loginUrl = api.root + '/auth/github/?origin=' + cbUrl;

      return <div className="header-auth">
        <a href={loginUrl} className="header-login-button button noscript">Login with GitHub</a>
      </div>
    }
  }
});

export default () => {
  return (
    <div className="header-container">
      <header className="header">
        <h1 className="header-logo">
          <Link to="/">Ost.io</Link>
        </h1>

        <div className="header-links">
          <HeaderLink to="/feed">Feed</HeaderLink>
          <HeaderLink to="/search">Search</HeaderLink>
        </div>

        <HeaderAuth />
      </header>
    </div>
  );
};
