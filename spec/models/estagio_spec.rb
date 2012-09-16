require File.dirname(__FILE__) + '/../spec_helper'

describe Estagio do
  before(:each) do
    @estagio = Estagio.new
  end

  it "should be valid" do
    @estagio.should be_valid
  end
end
