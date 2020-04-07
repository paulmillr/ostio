import React from 'react';
import usersStore from 'stores/users';

export default React.createClass({
  mixins: [
    usersStore.connect('currentUser')
  ],

  handleNotifsChange(e) {
    const checked = e.target.checked;
    usersStore.actions.updateCurrentUser({enabled_email_notifications: checked});
  },

  render() {
    const {currentUser} = this.state;
    if (!currentUser) return <div/>;

    return <div>
      <input type="checkbox" id="setting-email-notifications" onChange={this.handleNotifsChange} checked={currentUser.enabled_email_notifications} /> <label htmlFor="setting-email-notifications">Enable email notifications</label>
      <p>
        When checked, the setting will enable email notifications on new posts in your / your organizations repos
      </p>
    </div>;
  }
});
