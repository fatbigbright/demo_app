require 'spec_helper'

describe User do
    before { @user = User.new(name: "Example User", email: "user@example.com") }
    subject { @user }

    # to test whether attributs name & email exist
    it { should respond_to(:name) }
    it { should respond_to(:email) }

    it { should be_valid }

    describe "when name is not present" do
        before { @user.name = " " }
        it { should_not be_valid }
    end

    describe "when name is too long" do
        before { @user.name = "a" * 51 }
        it { should_not be_valid }
    end

    describe "when email is not present" do
        before { @user.email = " " }
        it { should_not be_valid }
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.com a_us-er@f.b.org frst.lst@foo.jp a+b@baz.com]
            addresses.each do |address|
                @user.email = address
                expect(@user).to be_valid
            end
        end
    end

    describe "when email address is already taken" do
        before do
            #create a new user with the same data of 'user'
            #by using dup method
            user_with_same_email = @user.dup            
            user_with_same_email.email = @user.email.upcase
            user_with_same_email.save
        end

        it { should_not be_valid }
    end
end
