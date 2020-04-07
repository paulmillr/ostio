import Exim from 'exim';
import request from 'lib/request';

export default Exim.createStore({
  actions: [
    'fetchForUser'
  ],

  initial: {
    repos: null,
  },

  fetchForUser: {
    while(reposLoading) {
      this.set({reposLoading});
    },
    on(login) {
      this.set('repos', null);
      return request.get('/users/'+login+'/repos');
    },
    did(data) {
      this.set('repos', data);
    }
  }
})
