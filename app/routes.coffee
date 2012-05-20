module.exports = (match) ->
  match '', 'home#show'
  match ':username', 'users#show'
  match ':username/:repoName', 'repos#show'
  match ':username/:repoName/threads/', 'threads#redirect_to_repo'
  match ':username/:repoName/threads/:threadNumber', 'threads#show'
