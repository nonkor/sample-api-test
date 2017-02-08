RSpec.describe 'Github API Pull Requests' do
  let(:json) { JSON.parse(subject.body) }
  let(:api) { GithubApi }
  let(:owner) { 'KorvinBoxTest' }
  let(:repo) { 'techlab' }
  let(:options) { {} }

  describe 'GET /repos/:owner/:repo/pulls' do
    shared_examples 'with "open" state' do
      include_examples 'empty result'
    end

    subject { api.get "/repos/#{owner}/#{repo}/pulls", :query => options }

    context 'whitout authentication' do
      let(:api) { GithubApiWithoutAuth }

      it_behaves_like 'successful query'
    end

    context 'without specified state' do
      it_behaves_like 'with "open" state'
    end

    context 'with "open" state' do
      let(:options) { {state: 'open'} }

      include_examples 'with "open" state'
    end

    context 'with "closed" state' do
      let(:options) { {state: 'closed'} }

      include_examples 'non-empty result'
    end

    context 'with all states' do
      let(:options) { {state: 'all'} }

      include_examples 'non-empty result'
    end
  end

  # GET /repos/:owner/:repo/pulls/:number

  # POST /repos/:owner/:repo/pulls

  # PATCH /repos/:owner/:repo/pulls/:number
end
