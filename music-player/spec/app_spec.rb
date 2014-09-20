require "spec_helper"

RSpec.describe 'The HelloWorld App' do
  it "says hello" do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to eq 'Hello world!'
  end
end
