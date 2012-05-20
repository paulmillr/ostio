module.exports = (match) ->
  match '', 'home#show'
  match ':login', 'users#show'
  match ':login/:repoName', 'repos#show'
  match ':login/:repoName/topics', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/', 'topics#redirect_to_repo'
  match ':login/:repoName/topics/:topicNumber', 'topics#show'
