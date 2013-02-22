require 'spec_helper'

describe Charger do
  context '.configure' do
    subject { Charger }
    it { should respond_to :configure }
  end
end
