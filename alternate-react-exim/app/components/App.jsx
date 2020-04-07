import React from 'react';
import Header from 'components/Header';
import usersStore from 'stores/users';

export default React.createClass({
  componentDidMount() {
    usersStore.actions.fetchCurrentUser();
  },

  render() {
    return (
      <div>
        <Header />
        <div className="container outer-container">
          <div className="page-container">
            <div className="content-container">
              {this.props.children}
            </div>
          </div>
        </div>
      </div>
    );
  }
});
