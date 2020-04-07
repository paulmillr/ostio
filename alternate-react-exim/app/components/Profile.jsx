import React from 'react';
import {Link} from 'react-router';
import Button from 'components/common/Button';
import Avatar from 'components/common/Avatar';
import Spinner from 'components/common/Spinner';
import NewTopic from 'components/NewTopic';
import usersStore from 'stores/users';
import reposStore from 'stores/repos';
import topicsStore from 'stores/topics';

const Navigation = ({ user, repo, topic }) => {
  const profilePath = '/@' + user.login;

  const avatar = <Link className="navigation-link" to={profilePath}><Avatar url={user.avatar_url} /></Link>;
  const userLink = <Link className="navigation-link" to={profilePath} data-type="login">{user.login}</Link>;

  let repoLink, topicLink;

  if (repo) {
    const repoPath = profilePath + '/' + repo;

    repoLink = <Link className="navigation-link" to={repoPath} data-type="repo">{repo}</Link>

    if (topic) {
      topicLink = <Link className="navigation-link" to={repoPath + "/topics/" + topic} data-type="topic">#{topic}</Link>
    }
  }

  return <span>{avatar} {userLink} {repoLink ? [' / ', repoLink] : null} {topicLink ? [' / ', topicLink] : null}</span>
};

export default React.createClass({
  mixins: [
    usersStore.connect('userLoading', 'user', 'currentUser'),
  ],

  componentDidMount() {
    usersStore.actions.findUser(this.props.params.login);
  },

  getInitialState() { return {}; },

  componentWillReceiveProps() {
    this.setState({newTopic: false});
  },

  syncRepos() {
    usersStore.actions.syncRepos().then(() => {
      reposStore.actions.fetchForUser(this.state.user.login);
    });
  },

  createNewTopic() {
    this.setState({newTopic: true});
  },

  topicCreated() {
    topicsStore.actions.fetchForUserRepo(this.props.params.login, this.props.params.repo).then(() => this.setState({newTopic: false}));
  },

  actionButton() {
    const {user, currentUser} = this.state;
    const {params} = this.props;

    let button;

    if (currentUser) {
      if (!params.repo && !params.topic && currentUser.login === user.login) {
        button = ['Sync GitHub repos', this.syncRepos];
      } else if (params.repo && !params.topic) {
        button = ['Create new topic', this.createNewTopic];
      }
    }

    button = button ? <Button onClick={button[1]}>{button[0]}</Button> : null;
    let buttonContainer = button ? <div className="button-container">{button}</div> : null;

    return buttonContainer;
  },

  render() {
    const {user, userLoading, newTopic} = this.state;
    if (!user || userLoading) return <Spinner />;

    const {repo, topic, login} = this.props.params;

    return <div>
      <div className="user-nav">
        <h2>
          <Navigation {...{user, repo, topic}} />
        </h2>
        {this.actionButton()}
      </div>

      {newTopic ? <NewTopic user={login} repo={repo} onDone={this.topicCreated} /> : null}
      {this.props.children}
    </div>;
  }
});
