require 'rails_helper'
require_relative '../support/association'

RSpec.describe Post, type: :model do
  let(:user) { User.create(fname: 'aaron', lname: 'rory') }
  let(:post1) { Post.create(user_id: user.id, content: 'valid test post') }

  describe 'test for presence of model attributes for' do
    describe 'general expected attributes' do
      it 'should include the :content attribute' do
        expect(post1.attributes).to include('content')
      end
      it 'should include the :imageURL attribute' do
        expect(post1.attributes).to include('imageURL')
      end
    end
  end

  describe 'Basic validations' do
    context 'content' do
      it 'is valid if length is less than 800 characters' do
        post1.valid?
        expect(post1.errors[:content]).to_not include('is too long (maximum is 800 characters)')
      end

      it 'is invalid if length is more than 800 characters' do
        post1.content = 'a' * 802
        post1.valid?
        expect(post1.errors[:content]).to include('is too long (maximum is 800 characters)')
      end

      it 'is invalid if length is less than 3 characters' do
        post1.content = 'te'
        post1.valid?
        expect(post1.errors[:content]).to include('is too short (minimum is 3 characters)')
      end
    end
  end

  describe 'Associations' do
    context 'users' do
      it 'has correct has_many association' do
        expect(Post).to belong_to(:user)
      end
    end

    context 'comments' do
      it 'has correct has_many association' do
        expect(Post).to have_many(:comments)
      end
    end

    context 'likes' do
      it 'has correct has_many association' do
        expect(Post).to have_many(:likes)
      end
    end
  end
end
