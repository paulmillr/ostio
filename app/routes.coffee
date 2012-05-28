module.exports = (match) ->
  match '', 'home#show'
  match 'auth-callback/?login=:login&accessToken=:accessToken', 'auth_callback#initialize'
  match ':login', 'users#show'
  match ':login/:repoName', 'repos#show'
  match ':login/:repoName/topics', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/:topicNumber', 'topics#show'
