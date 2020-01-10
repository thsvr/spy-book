# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_1) { User.create(fname:'aaron',lname:'ro') }

  describe 'test for presence of model attributes for' do
    describe 'general expected attributes' do 
      it 'should include the :fname attribute' do 
        expect(user_1.attributes).to include('fname')
      end

      it 'should include the :lname attribute' do 
        expect(user_2.attributes).to include('lname')
      end
    end
  end

  describe 'Basic validations' do
    context 'fname' do
      it 'is valid with a first name' do 
        user_1.valid?
        expect(user_1.errors[:fname]).to_not include("can't be blank")
      end

      it 'is valid if length is less than 15 characters' do
        user_1.valid?
        expect(user_1.errors[:fname]).to_not include('is too long (maximum is 15 characters)')
      end

      it 'is invalid if length is more than 15 characters' do
        user_1.fname = 'a' * 16
        user_1.valid?
        expect(user_1.errors[:fname]).to include('is too long (maximum is 15 characters)')
      end

      it 'is invalid without a first name' do 
        user_1.fname = nil
        user_1.valid?
        expect(user_1.errors[:fname]).to include("can't be blank")
      end
    end

    context 'lname' do
      it 'is valid with a last name' do 
        user_1.valid?
        expect(user_1.errors[:lname]).to_not include("can't be blank")
      end

      it 'is valid if length is less than 15 characters' do
        user_1.valid?
        expect(user_1.errors[:lname]).to_not include('is too long (maximum is 15 characters)')
      end

      it 'is invalid if length is more than 15 characters' do
        user_1.lname = 'a' * 16
        user_1.valid?
        expect(user_1.errors[:lname]).to include('is too long (maximum is 15 characters)')
      end

      it 'is invalid without a first name' do 
        user_1.lname = nil
        user_1.valid?
        expect(user_1.errors[:lname]).to include("can't be blank")
      end
    end
  end


  describe 'Devise specific attributes' do 
    it 'should include the :encrypted_password attribute' do 
      expect(user_1.attributes).to include('encrypted_password')
    end

    it 'should include the :reset_password_sent_at attribute' do 
      expect(user_1.attributes).to include('reset_password_sent_at')
    end

    it 'should include the :reset_password_token attribute' do 
      expect(user_1.attributes).to include('reset_password_token')
    end

    it 'should include the :remember_created_at attribute' do 
      expect(user_1.attributes).to include('remember_created_at')
    end
  end

  describe "Associations" do

    context 'posts' do 
      it 'has correct has_many association' do 
        t = User.reflect_on_association(:posts) 
        expect(t.macro).to eq(:has_many) 
      end
    end

    context 'comments' do 
      it 'has correct has_many association' do 
        t = User.reflect_on_association(:comments) 
        expect(t.macro).to eq(:has_many) 
      end
    end

    context 'likes' do 
      it 'has correct has_many association' do 
        t = User.reflect_on_association(:likes) 
        expect(t.macro).to eq(:has_many) 
      end
    end
  end


 end
