require 'spec_helper'

describe User do
  it "can search by email" do
    User.create(email: "sherodtaylor@gmail.com",
                name: "Sherod Taylor")
    user = User.where(:email => "sherodtaylor@gmail.com").first
    expect(User.find_by_email("sherodtaylor@gmail.com")).to eq user
  end
end
