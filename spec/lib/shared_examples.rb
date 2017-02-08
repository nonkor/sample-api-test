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
