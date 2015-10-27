module.exports = (match) ->
  match '', 'home#show'
  match 'feed', 'feed#show'
  match 'search', 'feed#search'
  match 'settings', 'settings#show'
  match 'auth-callback', 'auth#callback'
  match 'auth-callback/', 'auth#callback'

  # Users, repos, topics.
  match '@:login', 'users#show'
  match '@:login/:repoName', 'repos#show'
  match '@:login/:repoName/', 'topics#index'
  match '@:login/:repoName/topics', 'topics#index'
  match '@:login/:repoName/topics/', 'topics#index'
  match '@:login/:repoName/topics/:topicNumber', 'topics#show'
