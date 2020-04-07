import React from 'react';
import {Link} from 'react-router';
import Form from 'components/common/Form';
import Avatar from 'components/common/Avatar';
import Button from 'components/common/Button';
import PostCardBlueprint from 'components/PostCardBlueprint';
import postsStore from 'stores/posts';

export default React.createClass({
  getInitialState() {
    return { isCreating: false };
  },

  createPost() {
    const body = (this.refs.body.value || '').trim();
    if (body.length === 0) return;

    const {user, repo, topic, onDone} = this.props;

    this.setState({isCreating: true});

    postsStore.actions.post(user.login, repo, topic, body).then(() => {
      this.setState({isCreating: false});
      this.refs.body.value = '';
      onDone();
    });
  },

  render() {
    const {user} = this.props;
    const {isCreating} = this.state;

    const metadata = <span>Posts are parsed with <a href="http://github.github.com/github-flavored-markdown/" target="_blank">Markdown</a></span>;

    return <Form className="post" onSubmit={this.createPost}>
      <PostCardBlueprint {...{user, metadata}}>
        <div className="post-text">
          <textarea ref="body" className="new-post-body" />
          <div className="post-buttons">
            <Button loading={isCreating}>Comment on this topic (⌘↩)</Button>
          </div>
        </div>
      </PostCardBlueprint>
    </Form>;
  }
});
