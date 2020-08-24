require File.expand_path("../spec_helper", __FILE__)

RSpec.describe Danger::DangerMobiledevops do
  describe ".upload" do
    subject do
      object = described_class.new(nil)
      object.request_url = "https://example.com"
      object.upload({ test: :json })
    end

    before do 
      allow_any_instance_of(described_class).to receive(:request).and_return(mocked_response)
    end

    context "when success" do
      let(:mocked_response) { double(:response, code: 200) }

      it { is_expected.to be_truthy }
    end

    context "when error" do
      let(:mocked_response) { double(:response, code: 400) }

      it { is_expected.to be_falsey }
    end
  end
end
