  class GithubApiWithoutAuth
    include HTTParty
    base_uri 'https://api.github.com'

    headers 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'User-Agent' => 'test app'
  end

  class GithubApi < GithubApiWithoutAuth
    basic_auth 'KorvinBoxTest', 'ce46ec31ea431f38c8b1211c3df191ce6d7cde8b'
  end
