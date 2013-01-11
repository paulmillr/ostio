module.exports = (match) ->
  match '', 'home#show', name: 'home'
  match 'logout', 'auth#logout', name: 'logout'
  match 'feed', 'feed#show', name: 'feed'
  match 'settings', 'settings#show', name: 'settings'
  match 'auth-callback/', 'auth#callback'

  match ':login', 'users#show', name: 'user'
  match ':login/:repoName', 'repos#show', name: 'repo'
  match ':login/:repoName/', 'topics#redirect_to_repo'
  match ':login/:repoName/topics', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/:topicNumber', 'topics#show', name: 'topic'
