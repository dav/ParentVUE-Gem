# frozen_string_literal: true

require_relative '../../../lib/parentvue'
require 'mechanize'

RSpec.describe ParentVUE::Service do
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:login_url) { 'https://portal.sfusd.edu/PXP2_Login' }
  let(:default_options) { { login_url: login_url, username: username, password: password } }
  let(:service) { ParentVUE::Service.new(default_options) }

  before do
    stub_web_requests
  end

  describe '#initialize' do
    subject do
      service
    end

    it 'sets up mechanize' do
      expect(service.mechanize).to be_instance_of Mechanize
    end

    it 'sets #base_url' do
      expect(service.base_url).to eql 'https://portal.sfusd.edu'
    end
  end

  describe '#parent_sign_in' do
    subject do
      service.parent_sign_in(username, password)
    end

    it 'loads the main sign in page' do
      expect(service.mechanize).to receive(:get).with(login_url).and_call_original
      allow(service.mechanize).to receive(:get).with('PXP2_Login_Parent.aspx', any_args).and_call_original
      subject
    end

    it 'loads the parent sign in page' do
      allow(service.mechanize).to receive(:get).with(login_url).and_call_original
      expect(service.mechanize).to receive(:get).with('PXP2_Login_Parent.aspx', any_args).and_call_original
      subject
    end

    context 'with correct credentials password' do
      it 'returns truthy' do
        expect(subject).to be_truthy
      end
    end

    context 'with wrong password' do
      let(:password) { 'wrong password' }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#students' do
    before do
      service.parent_sign_in(username, password)
    end

    subject do
      service.students
    end

    it 'returns student hashes' do
      expect(subject).to eq([
                              {:name=>"Aila", :id=>"20111337", :school_name=>"Parks (Rosa) ES"},
                              {:name=>"Tesla", :id=>"20071337", :school_name=>"Asawa (Ruth) SOTA HS"}
                            ])

    end
  end
end

private_methods

def stub_web_requests
  html_fixtures_dir = './spec/fixtures/html/'
  main_login_html = File.read(html_fixtures_dir + 'main_login.html')
  stub_request(:get, "https://portal.sfusd.edu/PXP2_Login")
    .to_return(status: 200, body: main_login_html, headers: {content_type: 'text/html'})

  parent_login_html = File.read(html_fixtures_dir + 'parent_login.html')
  stub_request(:get, "https://portal.sfusd.edu/PXP2_Login_Parent.aspx")
    .to_return(status: 200, body: parent_login_html, headers: {content_type: 'text/html'})

  bad_parent_login_html = File.read(html_fixtures_dir + 'bad_parent_login.html')
  stub_request(:post, "https://portal.sfusd.edu/PXP2_Login_Parent.aspx?regenerateSessionId=True").
    with(
      body: {
        "__EVENTVALIDATION"=>"BIG-SECRET-THING",
        "__VIEWSTATE"=>"B64_ENCODED-THINGAMABOB",
        "__VIEWSTATEGENERATOR"=>"D5A74BF2",
        "ctl00$MainContent$Submit1"=>"Login",
        "ctl00$MainContent$password"=>"wrong password",
        "ctl00$MainContent$username"=>"username"
      }
    )
    .to_return(status: 200, body: bad_parent_login_html, headers: {content_type: 'text/html'})

  home_html = File.read(html_fixtures_dir + 'home.html')
  stub_request(:post, "https://portal.sfusd.edu/PXP2_Login_Parent.aspx?regenerateSessionId=True").
    with(
      body: {
        "__EVENTVALIDATION"=>"BIG-SECRET-THING",
        "__VIEWSTATE"=>"B64_ENCODED-THINGAMABOB",
        "__VIEWSTATEGENERATOR"=>"D5A74BF2",
        "ctl00$MainContent$Submit1"=>"Login",
        "ctl00$MainContent$password"=>"password",
        "ctl00$MainContent$username"=>"username"
      }
    )
    .to_return(status: 200, body: home_html, headers: {content_type: 'text/html'})
end
