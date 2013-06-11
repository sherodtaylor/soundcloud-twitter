require 'spec_helper'

describe SearchesController do
  describe '#playlist' do
    it "should return json data of query" do
      user = User.create(soundcloud_token: "1-43000-47511904-1532b1fafcd8fd9",
                         name: "Sherod Taylor")
      controller.stub!(:current_user).and_return(user)
      get :playlist,  "q" => "flatbrush%20zombies"
      response.body.should == {hi: "bye"}.to_json
    end
  end
end
