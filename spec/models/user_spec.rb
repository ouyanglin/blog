require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :display_name => "Lin", :email => "lin@ouyang.com" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a non-blank display_name" do
    no_name_user = User.new(@attr.merge(:display_name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a non-blank email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should have a name less than 30 characters" do
    long_name = 'a'*31
    invalid_name_user = User.new(@attr.merge(:display_name => long_name))
    invalid_name_user.should_not be_valid
  end

  it "should require a valid email address" do
    invalid_email_user = User.new(@attr.merge(:email => "lin@example"))
    invalid_email_user.should_not be_valid
  end

  it "should not allow mass assignment for admin" do
    not_admin = User.create!(@attr.merge(:admin => true))
    not_admin.admin.should_not be_true
  end

  describe "Success" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should require a unique email address" do
      duplicate_email = User.new(@attr.merge(:display_name => "Bing"))
      duplicate_email.should_not be_valid
    end

    it "should require a unique display_name" do
      duplicate_name = User.new(@attr.merge(:email => "example@foo.net"))
      duplicate_name.should_not be_valid
    end

    it "should have admin default to false" do
      @user.admin.should_not be_nil
      @user.admin.should be_false
    end

    describe "Password" do

      it "should have virtual attribute :password" do
        @user.should respond_to(:password)
      end

      it "should respond to has_password?" do
        @user.should respond_to(:has_password?)
      end

      it "should have 'foobar' for default password" do
        @user.has_password?("foobar").should be_true
      end

      it "should not have 'barfoo' for default password" do
        @user.has_password?("boofar").should_not be_nil
        @user.has_password?("boofar").should be_false
      end

      it "should have a salt upon creation" do
        @user.salt.should_not be_nil
      end

      describe "authenticate method" do

        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
        end

        it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", "foobar")
          nonexistent_user.should be_nil
        end

        it "should return the user on email/password match" do
          matching_user = User.authenticate(@attr[:email], "foobar")
          matching_user.should == @user
        end
      end
    end

    describe "Updating attributes" do

      before(:each) do
        @user.update_attributes(:password              => "boofar",
                                :password_confirmation => "boofar")
      end

      it "should have a new password 'boofar'" do
        @user.has_password?("boofar").should be_true
      end

      it "should update the attributes without changing the password" do
        new_instance = User.find_by_email(@attr[:email])
        new_instance.update_attributes(:display_name => "TeamLRAM",
                                       :email        => "user@example.org")
        new_instance.has_password?("boofar").should be_true
      end
    end
  end

  describe "post associations" do

    before(:each) do
      @user = User.create(@attr)
      @post1 = Factory(:post, :user => @user, :created_at => 1.day.ago)
      @post2 = Factory(:post, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a posts attribute" do
      @user.should respond_to(:posts)
    end

    it "should have the right post in the right order" do
      @user.posts.should == [@post2, @post1]
    end

    it "should destroy associated posts" do
      @user.destroy
      [@post1, @post2].each do |post|
        Post.find_by_id(post.id).should be_nil
      end
    end
  end
end
