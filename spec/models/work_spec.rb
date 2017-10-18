require 'rails_helper'

RSpec.describe Work, type: :model do
  before(:all) do
    @work = Work.new(name: "Min title", description: "Mit værk")
  end

  it "should have matching values" do
    expect(@work.description).to eq("Mit værk")
    expect(@work.name).to eq("Min title")
  end

  it "should not be valid with an empty title" do
    @work.name = ""
    expect(@work.valid?).to eq(false)
  end
end
