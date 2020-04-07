import React from 'react';
import ReactDOM from 'react-dom';

export default React.createClass({
  componentDidMount() {
    const node = ReactDOM.findDOMNode(this);
    node.classList.add('animated-item-view');
    setTimeout(() => node.classList.add('animated-item-view-end'), 0);
  },

  render() {
    const {inline} = this.props;
    const display = inline ? 'inline' : 'block';
    return <div style={{display}}>{this.props.children}</div>;
  }
});
