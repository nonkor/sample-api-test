RSpec.describe 'Github API Pull Requests' do
  let(:api) { GithubApi }
  let(:json) { JSON.parse(subject.body) }
  let(:owner) { ApiHelper.login }
  let(:repo) { ApiHelper.repo }
  let(:head) { 'test' }
  let(:base) { 'master' }
  let(:options) { {} }
  let(:create_options) do
    {
      'title' => 'test PR',
      'body' => 'Please pull this in!',
      'head' => head,
      'base' => base
    }
  end

  def close_open_PRs
    numbers_of_open_PRs.each { |number| close_PR(number) }
  end

  def numbers_of_open_PRs
    response = GithubApi.get "/repos/#{owner}/#{repo}/pulls"
    JSON.parse(response.body).map { |pr| pr['number'] }
  end

  def close_PR(number, terminate: false)
    GithubApi.patch "/repos/#{owner}/#{repo}/pulls/#{number}", :body => {state: 'closed'}.to_json
  end

  def create_PR
    GithubApi.post "/repos/#{owner}/#{repo}/pulls", :body => create_options.to_json
  end

  before { close_open_PRs }

  describe 'GET /repos/:owner/:repo/pulls' do
    subject { api.get "/repos/#{owner}/#{repo}/pulls", :query => options }

    shared_examples 'with "open" state' do
      include_examples 'empty result'
    end

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

  describe 'GET /repos/:owner/:repo/pulls/:number' do
    before { create_PR }

    subject { api.get "/repos/#{owner}/#{repo}/pulls/#{number}" }
    let(:number) { numbers_of_open_PRs.last }

    it 'returns details about specified PR' do
      expect(subject).to be_ok
      expect(json['state']).to eq 'open'
    end
  end

  describe 'POST /repos/:owner/:repo/pulls' do
    subject { api.post "/repos/#{owner}/#{repo}/pulls", :body => options.to_json }
    let(:options) { create_options }

    let(:params) do
      options.reject {|key, _| !%i(title body).include? key }
    end

    it 'creates a new Pull Request' do
      is_expected.to be_created
      expect(json).to include(params)
    end

    context 'whitout authentication' do
      let(:api) { GithubApiWithoutAuth }

      it_behaves_like 'PR has not been found'
    end

    context 'when PR was created before' do
      before { create_PR }

      let(:message) { subject.parsed_response['message'] }
      let(:error_messages) do
        subject.parsed_response['errors'].map { |error| error['message'] }.flatten
      end

      it 'returns validation error' do
        expect(subject.code).to eq 422
        expect(message).to eq 'Validation Failed'
        expect(error_messages).to contain_exactly "A pull request already exists for #{ApiHelper.login}:#{head}."
      end
    end
  end

  describe 'PATCH /repos/:owner/:repo/pulls/:number' do
    before { create_PR }

    subject { api.patch "/repos/#{owner}/#{repo}/pulls/#{number}", body: options.to_json }
    let(:number) { numbers_of_open_PRs.last }
    let(:options) { {state: 'closed'} }

    it 'updates data of specified PR' do
      expect(subject).to be_ok
      expect(json['state']).to eq 'closed'
    end
  end
end
