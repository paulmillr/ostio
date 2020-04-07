import React from 'react'
import Form from 'components/common/Form';
import Button from 'components/common/Button';
import topicsStore from 'stores/topics';

export default React.createClass({
  getInitialState() {
    return { isCreating: false };
  },

  createTopic() {
    const title = (this.refs.title.value || '').trim();
    const body = (this.refs.body.value || '').trim();

    if (title.length === 0 || body.length === 0) return;

    const {user, repo, onDone} = this.props;

    this.setState({isCreating: true});

    topicsStore.actions.create(user, repo, title, body).then(() => {
      this.setState({isCreating: false});
      onDone()
    });
  },

  render() {
    const {isCreating} = this.state;

    return <Form className="new-topic-form" ref="form" onSubmit={this.createTopic}>
      <div className="new-topic-form-fields visible">
        <input ref="title" className="new-topic-form-title" type="text" placeholder="Title" />
        <textarea ref="body" className="new-topic-form-text" placeholder="Post body" />
        <div className="new-topic-form-submit-button-container form-submit-button-container">
          <Button loading={isCreating}>Submit new topic (⌘↩)</Button>
        </div>
      </div>
    </Form>;
  }
});

