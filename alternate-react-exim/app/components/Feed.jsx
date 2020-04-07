import React from 'react';
import {Link} from 'react-router';
import PostCard from 'components/PostCard';
import Avatar from 'components/common/Avatar';
import Spinner from 'components/common/Spinner';
import Animated from 'components/common/Animated';
import postsStore from 'stores/posts';
import usersStore from 'stores/users';

const UserCard = ({ user }) => {
  return <span className="user">
    <Link className="user-organization organization" to={'/@' + user.login} title={user.login}>
      <Avatar url={user.avatar_url} />
    </Link>
  </span>;
};

const Users = React.createClass({
  mixins: [
    usersStore.connect('usersLoading', 'users')
  ],

  componentDidMount() {
    usersStore.actions.fetchLatest();
  },

  getInitialState() { return {}; },

  render() {
    let users;

    if (!this.state.users || this.state.usersLoading) {
      users = <Spinner />;
    } else if (this.state.users.length > 0) {
      users = this.state.users.map(user => <Animated inline={true}><UserCard user={user} /></Animated>);
    } else {
      users = "No users.";
    }

    return (
      <div className="user-list-container">
        <h4>Latest users</h4>

        <div className="users">
          {users}
        </div>
      </div>
    );
  }
});


const Posts = React.createClass({
  mixins: [
    postsStore.connect('postsLoading', 'posts'),
  ],

  componentDidMount() {
    postsStore.actions.fetchLatest();
  },

  getInitialState() { return {}; },

  render() {
    let posts;

    if (!this.state.posts || this.state.postsLoading) {
      posts = <Spinner />;
    } else if (this.state.posts.length > 0) {
      posts = this.state.posts.map(post => <Animated><PostCard post={post} inFeed={true} /></Animated>);
    } else {
      posts = "No posts.";
    }

    return (
      <div className="post-list-container">
        <h4>Latest posts</h4>

        <div className="topic-posts">
          {posts}
        </div>
      </div>
    );
  }
});

export default () => {
  return <div>
    <Users />
    <Posts />
  </div>;
};
