require 'spec_helper'

describe "Users" do

    describe "signup" do

        describe "failure" 
            it "should not make a new user" do
                lambda do
                    visit signup_path
                    fill_in "Name",         :with => ""
                    fill_in "Email",        :with => ""
                    fill_in "Password",     :with => ""
                    fill_in "Confirmation", :with => ""
                    click_button
                    response.should render_template('users/new')
                    response.should have_selector("div#error_explanation")
                end.should_not change(User, :count)
            end
        end
    
        describe "success" do
            it "should create a new user" do
                lambda do
                    visit signup_path
                    fill_in "Name",         :with => "JP"
                    fill_in "Email",        :with => "joaopaulolethier@hotmail.com"
                    fill_in "Password",     :with => "123456"
                    fill_in "Confirmation", :with => "123456"
                    click_button
                    response.should render_template('users/show')
                    response.should have_selector("div.flash.success", :content => "Welcome")
                end.should change(User, :count).by(1)
            end
        end
    end
    describe "sign in/out" do
    
        describe "failure" do

            it "should not sign in" do
                visit signin_path
                fill_in "Email",    :with => ""
                fill_in "Password", :with => ""
                click_button
                response.should have_selector("div.flash.error", :content => "incorreto")
                controller.should_not be_signed_in
            end
        end

        describe "success" do
            it "should sign in and out"
                user = Factory(:user)
                visit signin_path
                fill_in "Email",    :with => user.email
                fill_in "Password", :with => user.password
                click_button
                controller.should be_signed_in
                click_link "Sign out"
                controller.should_not be_signed_in
            end
        end
    end
end    
