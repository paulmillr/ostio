import Exim from 'exim';
import request from 'lib/request';

export default Exim.createStore({
  actions: [
    'findUser',
    'fetchLatest',
    'login',
    'logout',
    'fetchCurrentUser',
    'updateCurrentUser',
    'syncRepos'
  ],

  initial: {
    currentUser: null,
    user: null,
    users: null
  },

  findUser: {
    while(userLoading) {
      this.set({userLoading});
    },
    on(login) {
      this.set('user', null);
      return request.get('/users/'+login);
    },
    did(data) {
      this.set('user', data);
    }
  },

  fetchLatest: {
    while(usersLoading) {
      this.set({usersLoading});
    },
    on() {
      this.set('users', null);
      return request.get('/users/');
    },
    did(data) {
      this.set('users', data);
    }
  },

  login(accessToken) {
    if (this.get('currentUser')) return;
    localStorage.setItem('accessToken', accessToken);
    return this.actions.fetchCurrentUser();
  },

  logout() {
    localStorage.removeItem('accessToken');
    this.set('currentUser', null);
  },

  updateCurrentUser(data) {
    return request.put('/users/me', data).then(() => this.actions.fetchCurrentUser());
  },

  fetchCurrentUser: {
    on() {
      if (!localStorage.getItem('accessToken')) return;
      return request.get('/users/me');
    },
    did(user) {
      this.set('currentUser', user);
    }
  },

  syncRepos() {
    return request.post('/users/' + this.get('currentUser').login + '/sync_repos');
  }
})
