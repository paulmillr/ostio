module.exports = (match) ->
  match '', 'home#show'
  match ':login', 'users#show'
  match ':login/:repoName', 'repos#show'
  match ':login/:repoName/threads/', 'threads#redirect_to_repo'
  match ':login/:repoName/threads/:threadNumber', 'threads#show'
