require 'spec_helper'

describe CLI do
  describe "Thor" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI.new(@valid_initialize_options) }

    describe "Thor group definition" do
      subject { CLI }
      it { should respond_to(:desc) }
      it { should respond_to(:class_option) }
      it { should respond_to(:argument) }
      its (:desc) { should_not be_empty }
      its (:arguments) { should_not be_empty }
    end

    describe "input" do
      it "should have an arguments :input defined" do
        CLI.arguments.any? { |arg| arg.name == 'input' }.should be_true
      end

      it "should be required" do
        -> { CLI.new }.should raise_error Thor::RequiredArgumentMissingError,
          "No value provided for required arguments 'input'"
      end

      it { should respond_to(:set_input_filename) }

      it "should set @input_filename" do
        subject.set_input_filename
        subject.instance_variable_get('@input_filename').should == 'README.md'
      end
    end
  end
end