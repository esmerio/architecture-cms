require File.dirname(__FILE__) + '/../spec_helper'

describe Projeto do
  before(:each) do
    @projeto = Projeto.new
  end

  it "should be valid" do
    @projeto.should be_valid
  end
end
