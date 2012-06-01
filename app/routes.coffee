module.exports = (match) ->
  match '', 'home#show'
  match 'logout/', 'auth#logout'
  match 'auth-callback/?login=:login&accessToken=:accessToken', 'auth#callback'
  match ':login', 'users#show'
  match ':login/:repoName', 'repos#show'
  match ':login/:repoName/topics', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/:topicNumber', 'topics#show'
