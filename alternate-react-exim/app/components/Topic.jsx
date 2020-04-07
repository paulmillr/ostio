import React from 'react';
import usersStore from 'stores/users';
import topicsStore from 'stores/topics';
import postsStore from 'stores/posts';
import PostCard from 'components/PostCard';
import NewPost from 'components/NewPost';
import Spinner from 'components/common/Spinner';
import Animated from 'components/common/Animated';

export default React.createClass({
  mixins: [
    usersStore.connect('currentUser'),
    topicsStore.connect('topics'),
    postsStore.connect('postsLoading', 'posts')
  ],

  componentDidMount() {
    topicsStore.actions.fetchForUserRepo(this.props.params.login, this.props.params.repo);
    postsStore.actions.fetchForUserRepoTopic(this.props.params.login, this.props.params.repo, this.props.params.topic);
  },

  getInitialState() { return {}; },

  posted() {
    postsStore.actions.fetchForUserRepoTopic(this.props.params.login, this.props.params.repo, this.props.params.topic);
  },

  render() {
    const {topics, posts, currentUser} = this.state;
    const topic = topics && topics.find(topic => topic.number == this.props.params.topic);

    if (!topic) return <Spinner />;

    let tops;

    if (!posts || this.state.postsLoading) {
      tops = <Spinner />;
    } else if (posts.length > 0) {
      tops = posts.map(post => {
        const showActions = post.user.login === currentUser.login;
        const {login, repo} = this.props.params;
        const onDelete = () => postsStore.actions.deletePost(login, repo, topic.number, post.id).then(() => this.posted());
        const onEdit = body => postsStore.actions.updatePost(login, repo, topic.number, post.id, body).then(() => this.posted());
        return <Animated><PostCard {...{showActions, onDelete, onEdit, post}} /></Animated>;
      });
    } else {
      tops = "No posts."
    }
    return <div className="topic-posts-container">
      <h3>{topic.title}</h3>

      <div className="topic-posts">
        <div className="posts">
          {tops}
        </div>
        {this.state.currentUser ? <NewPost user={currentUser} repo={this.props.params.repo} topic={this.props.params.topic} onDone={this.posted} /> : null}
      </div>
    </div>;
  }
});
