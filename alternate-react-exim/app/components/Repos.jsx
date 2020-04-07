import React from 'react';
import {Link} from 'react-router';
import Avatar from 'components/common/Avatar';
import Spinner from 'components/common/Spinner';
import Animated from 'components/common/Animated';
import usersStore from 'stores/users';
import reposStore from 'stores/repos';

const RepoCard = ({ user, repo }) => {
  return <li className="user-repo">
    <Link to={"/@" + user.login + "/" + repo.name}>{repo.name}</Link>
  </li>
};

const OrgCard = ({ item }) => {
  return <span className="user">
    <Link to={"/@" + item.login} title={item.login} className="user-organization organization">
      <Avatar url={item.avatar_url} />
    </Link>
  </span>;
};

const OrganizationsOwners = ({ user }) => {
  const isOrg = user.type === 'Organization';
  const orgItems = isOrg ? user.owners : user.organizations;

  if (orgItems.length > 0) {
    const userList = orgItems.map(item => <Animated inline={true}><OrgCard item={item} /></Animated>);

    return <div className="user-organization-list-container">
      <div className="users">
        <h4>{isOrg ? 'Owners' : 'Organizations'}</h4>

        <div className="users-list">{userList}</div>
      </div>
    </div>;
  }

  return <div />;
};

export default React.createClass({
  mixins: [
    reposStore.connect('reposLoading', 'repos'),
    usersStore.connect('user')
  ],

  componentDidMount() {
    reposStore.actions.fetchForUser(this.props.params.login);
  },

  getInitialState() { return {}; },

  render() {
    const user = this.state.user
    const repositories = this.state.repos;
    let repos;

    if (!user) return <Spinner />;

    if (!repositories || this.state.reposLoading) {
      repos = <Spinner />;
    } else if (repositories.length > 0) {
      repos = repositories.map(repo => <Animated><RepoCard user={user} repo={repo} /></Animated>);
      repos = <ul className="user-repo-list">{repos}</ul>;
    } else {
      repos = "No repositories.";
    }

    return <div>
      <OrganizationsOwners {...{user}} />

      <div className="user-repo-list-container">
        <h4>
          Repositories <a className="icon icon-github" href={"https://github.com/" + user.login} />
        </h4>

        {repos}
      </div>
    </div>;
  }
});
