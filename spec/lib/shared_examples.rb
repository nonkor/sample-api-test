shared_examples_for 'empty result' do
  it do
    is_expected.to be_ok
    expect(json).to be_empty
  end
end

shared_examples_for 'non-empty result' do
  it do
    is_expected.to be_ok
    expect(json).not_to be_empty
  end
end

shared_examples_for 'successful query' do
  it { is_expected.to be_ok }
end

shared_examples_for 'PR has not been found' do
  it do
    expect(subject.code).to eq 404
    expect(subject.message).to eq 'Not Found'
  end
end
