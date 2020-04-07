import React from 'react';
import {Link} from 'react-router';
import moment from 'moment';
import {escapeExpression, unescapeExpression} from 'lib/util';
import Form from 'components/common/Form';
import Button from 'components/common/Button';
import Avatar from 'components/common/Avatar';
import PostCardBlueprint from 'components/PostCardBlueprint';

const PostEditor = React.createClass({
  handleEditSave() {
    const newBody = (this.refs.body.value || '').trim();
    if (newBody.length === 0) return;
    this.props.onEdit(newBody);
  },

  handleCancel(e) {
    e.preventDefault();
    this.props.onCancel();
  },

  render() {
    const {text} = this.props;

    return <Form className="post post-create" onSubmit={this.handleEditSave}>
      <div className="post-text">
        <textarea className="edit-post-body" ref="body" style={{height: 64}} defaultValue={text} />
        <div className="post-buttons">
          <Button onClick={this.handleCancel}>Cancel</Button> <Button>Save post (⌘↩)</Button>
        </div>
      </div>
    </Form>;
  }
});


const PostRenderer = ({ text }) => {
  const string = escapeExpression(text).replace(/&#x60;/g, '`');
  const rendered = marked(text, {
    gfm: true,
    sanitize: true,
    highlight: (code, language) => {
      if (language && language in hljs.LANGUAGES) {
        const raw = unescapeExpression(code);
        try {
          return hljs.highlight(language, raw).value;
        } catch (e) {
          return code;
        }
      }
      return code;
    }
  });
  return <div className="post-text" dangerouslySetInnerHTML={{__html: rendered}} />;
};

export default React.createClass({
  getInitialState() {
    return { isEditing: false };
  },

  handleDelete() {
    this.props.onDelete();
  },

  handleEditStart() {
    this.setState({isEditing: true});
  },

  handleEditCancel() {
    this.setState({isEditing: false});
  },

  handleEditSave(newBody) {
    this.props.onEdit(newBody);
    this.setState({isEditing: false});
  },

  render() {
    const {post, inFeed, showActions, onEdit, onDelete} = this.props;

    const topicAddress = post.user.login + "/" + post.topic.repo.name + "/topics/" + post.topic.number;
    const topicUrl = "/@" + topicAddress;

    let actions;

    if (showActions && !this.state.isEditing) {
      actions = <div className="post-icons">
        <span className="icon icon-pencil-1 post-edit-button" title="Edit" onClick={this.handleEditStart} />
        <span className="icon icon-trash post-delete-button" title="Delete" onClick={this.handleDelete} />
      </div>
    }

    let text;

    if (!this.state.isEditing) {
      text = <PostRenderer text={post.text} />
    } else {
      text = <PostEditor onCancel={this.handleEditCancel} onEdit={this.handleEditSave} text={post.text} />
    }

    const authorAddition = inFeed ?
      <span>in <Link className="post-url" to={topicUrl}>{topicAddress}</Link></span> :
      null;

    const {user} = post;
    const metadata = <span>{moment(new Date(post.created_at)).fromNow()}</span>;

    return <PostCardBlueprint {...{user, authorAddition, metadata}}>
      {actions}
      {text}
    </PostCardBlueprint>;
  }
});
