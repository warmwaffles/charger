require 'spec_helper'

describe Charger::Client do
  let(:client) { Charger::Client.new('abc123', 'testing') }
  subject { client }

  describe 'attributes' do
    it { should respond_to :api_key }
    it { should respond_to :subdomain }
  end


  describe '#get' do
    it { should respond_to :get }

    context 'when Chargify responds with an error' do
      before { RestClient.stub(:get).and_raise(RestClient::Exception) }

      it 'should raise Charger::Exception' do
        expect { client.get 'resource' }.to raise_error(Charger::Exception)
      end
    end


    context 'when Chargify responds with success' do
      before { RestClient.stub(:get).and_return("{\"foo\":\"bar\",\"baz\":\"qux\"}")}
      subject { client.get 'resource' }
      it { should be_a(Hash) }
    end
  end


  describe '#post' do
    it { should respond_to :post }

    context 'when Chargify responds with an error' do
      before { RestClient.stub(:post).and_raise(RestClient::Exception) }

      it 'should raise Charger::Exception' do
        expect { client.post 'resource', { :some_data => 'value' } }.to raise_error(Charger::Exception)
      end
    end

    context 'when Chargify responds with success' do
      before { RestClient.stub(:post).and_return("{\"foo\":\"bar\",\"baz\":\"qux\"}")}
      subject { client.post 'resource', { :some_data => 'value' } }
      it { should be_a(Hash) }
    end
  end


  describe '#put' do
    it { should respond_to :put }

    context 'when Chargify responds with an error' do
      before { RestClient.stub(:put).and_raise(RestClient::Exception) }

      it 'should raise Charger::Exception' do
        expect { client.put 'resource/1', { :some_data => 'value' } }.to raise_error(Charger::Exception)
      end
    end

    context 'when Chargify responds with success' do
      before { RestClient.stub(:put).and_return("{\"foo\":\"bar\",\"baz\":\"qux\"}")}
      subject { client.put 'resource/1', { :some_data => 'value' } }
      it { should be_a(Hash) }
    end
  end


  describe '#delete' do
    it { should respond_to :delete }

    context 'when Chargify responds with an error' do
      before { RestClient.stub(:delete).and_raise(RestClient::Exception) }
      it 'should raise Charger::Exception' do
        expect { client.delete 'resource/1' }.to raise_error(Charger::Exception)
      end
    end

    context 'when Chargify responds with success' do
      before { RestClient.stub(:delete).and_return("{\"foo\":\"bar\",\"baz\":\"qux\"}")}
      subject { client.delete 'resource/1' }
      it { should be_a(Hash) }
    end
  end
end
