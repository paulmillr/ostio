import React from 'react';

export default React.createClass({
  handleSubmit(e) {
    if (e) e.preventDefault();
    this.props.onSubmit();
  },

  handleKeyDown(e) {
    if (e.key === 'Enter' && e.metaKey) {
      e.preventDefault();
      this.handleSubmit();
    }
  },

  render() {
    return <form className={this.props.className} onSubmit={this.handleSubmit} onKeyDown={this.handleKeyDown}>
      {this.props.children}
    </form>;
  }
});
