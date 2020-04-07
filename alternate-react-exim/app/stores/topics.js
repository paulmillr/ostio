import Exim from 'exim';
import request from 'lib/request';
import postsStore from 'stores/posts';

export default Exim.createStore({
  actions: [
    'fetchForUserRepo',
    'create'
  ],

  initial: {
    topics: null,
  },

  fetchForUserRepo: {
    while(topicsLoading) {
      this.set({topicsLoading});
    },
    on(login, repo) {
      this.set('topics', null);
      return request.get('/users/'+login+'/repos/'+repo+'/topics');
    },
    did(data) {
      this.set('topics', data);
    }
  },

  create: {
    while(topicCreating) {
      this.set({topicCreating});
    },
    on(user, repo, title, body) {
      return request.post('/users/'+user+'/repos/'+repo+'/topics', {title}).then(topic => {
        return postsStore.actions.post(user, repo, topic.number, body);
      });
    }
  }
})
