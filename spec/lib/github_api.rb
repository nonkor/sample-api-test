class GithubApiWithoutAuth
  include HTTParty
  base_uri 'https://api.github.com'
  headers 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'User-Agent' => 'test app'
end

class GithubApi < GithubApiWithoutAuth
  basic_auth ApiHelper.login, ApiHelper.token
end
