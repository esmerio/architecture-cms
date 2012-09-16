require File.dirname(__FILE__) + '/../spec_helper'

describe Categoria do
  before(:each) do
    @categoria = Categoria.new
  end

  it "should be valid" do
    @categoria.should be_valid
  end
end
