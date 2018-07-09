require 'rails_helper'

RSpec.describe Post, type: :model do

  context "Scopes" do
    let!(:post) do
      user = User.create first_name: "Humphrey", last_name: "Litan", middle_name: "P", email: "charot@gmail.com"
      Post.create title: "Hello guys", body: "welcome to my channel", status: "draft", user: user
    end

    describe ".published" do
      it "returns published posts" do
        post.update status: "published"
        expect(Post.published).to include post
      end

      it "does not return posts that are not published" do
        expect(Post.published).not_to include post
      end
    end

    describe ".draft" do
      it "returns drafted posts" do
        expect(Post.draft).to include post
      end

      it "does not return posts that are published" do
        post.update status: "published"
        expect(Post.draft).not_to include post
      end
    end

  end

  context "Callbacks" do
    let!(:post) do
      user = User.create first_name: "Humphrey", last_name: "Litan", middle_name: "P", email: "charot@gmail.com"
      Post.create title: "Hello guys", body: "welcome to my channel", status: "draft", user: user
    end

    describe ".add_title_to_body" do
      it "returns title - body" do
        expect(post.add_title_to_body).to eq post.body
      end
    end
  end

  context "Validations" do
    let!(:error_list) { Post.create.errors.full_messages }
    let!(:post) do
      user = User.create first_name: "Humphrey", last_name: "Litan", middle_name: "P", email: "charot@gmail.com"
      Post.create title: "Hello guys", body: "welcome to my channel", status: "draft", user: user
    end

    describe "presence" do
      it "should tell that something is blank" do
        expect(error_list).to include "User must exist"
        expect(error_list).to include "Title can't be blank"
        expect(error_list).to include "Body can't be blank"
      end
      it "should not tell that something is blank" do
        u = User.create first_name: "Humphrey", last_name: "Litan", middle_name: "P", email: "charot@gmail.com"
        p = Post.create title: "Hello", body: "World", user: u

        expect(p.errors.full_messages).not_to include "User must exist"
        expect(p.errors.full_messages).not_to include "Title can't be blank"
        expect(p.errors.full_messages).not_to include "Body can't be blank"
      end
    end

    describe "inclusion" do
      it "should include draft post" do
        expect(Post.draft).to include post
      end
      it "should include published post" do
        post.update status: "published"
        expect(Post.published).to include post
      end
    end

    describe "uniqueness" do
      a = Post.create title: "Hola"
      it "should not have the same title" do
        
      end
      it "should tell the user that the title already exists" do

      end
    end
  end

end
