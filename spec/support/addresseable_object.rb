require 'spec_helper'

shared_examples_for "an addresseable object" do
  context "validations" do
    it { should allow_value(75018).for(:postal_code) }
    it { should_not allow_value(5018).for(:postal_code) }
    it { should_not allow_value(750183).for(:postal_code) }
    it { should_not allow_value("yo").for(:postal_code) }
  end

  it { should respond_to :address }

  context "after_validation" do
    it "should have a :geocode validation callback" do
      described_class._validation_callbacks.detect{|o| o.filter == :geocode}.should_not be_nil
    end

    it "should perform the geocode callback" do
      callback = described_class._validation_callbacks.detect{|o| o.filter == :geocode}.options[:if].first
      klass = described_class.new street: 'street', city: 'City', postal_code: 75000
      callback.call(klass).should be_true
    end

    it "should not perform the geocode callback" do
      callback = described_class._validation_callbacks.detect{|o| o.filter == :geocode}.options[:if].first
      klass = described_class.new
      callback.call(klass).should be_false
    end
  end
end
