require File.expand_path("../spec_helper", __FILE__)

RSpec.describe Danger::DangerMobiledevops do
  it "should be a plugin" do
    expect(described_class.new(nil)).to be_a Danger::Plugin
  end

  describe ".request" do
    let(:object) { described_class.new(nil) }
    let(:json) { { "this is" => "example json" } }
    subject { object.request(json) }

    it "should be type of Typhoeus" do
      expect(subject).to be_a(Typhoeus::Request)
    end
    it "should use defined URL" do
      object.request_url = "https://my.test.url.example.com/"
      expect(subject.base_url).to eq("https://my.test.url.example.com/")
    end
    it "should use defined method" do
      object.request_method = :put
      expect(subject.options[:method]).to eq(:put)
    end
    it "should have json in body" do
      expect(subject.options[:body]).to eq(json)
    end
    describe "authorization" do
      it "should add header when token provided" do
        object.bearer_token = "12345"
        expect(subject.options[:headers]['Authorization']).to eq("bearer 12345")
      end
      it "should not add header when no token provided" do
        object.bearer_token = nil
        expect(subject.options[:headers]['Authorization']).to be_nil
      end
    end
  end

  describe ".upload" do
    before { Typhoeus.stub('www.example.com').and_return(response) }
    subject { object.upload("") }
    let(:object) do
      object = described_class.new(nil)
      object.request_url = "www.example.com"
      object
    end

    context "when success" do
      let(:response) { Typhoeus::Response.new(code: 200, body: "OK") }
      it { is_expected.to be_truthy }
    end

    context "when error" do
      let(:response) { Typhoeus::Response.new(code: 500, body: "ERROR") }
      it { is_expected.to be_falsey }
    end
  end
end
