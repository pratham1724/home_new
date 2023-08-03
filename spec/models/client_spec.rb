require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(email: 'pratham21@gmail.com', password: '1111111')
      client = Client.new(
        name: 'Pratham',
        phone_number: '6263089693',
        age: 24,
        user_id: user.id
      )
      expect(client).to be_valid
    end

    it 'is not valid with a duplicate name' do
      user = User.create(email: 'pratham21@gmail.com', password: '1111111')
      Client.create(
        name: 'Pratham',
        phone_number: '6263089693',
        age: 24,
        user_id: user.id
      )
      client = Client.new(
        name: 'Pratham',
        phone_number: '6263089693',
        age: 24,
        user_id: user.id
      )
      expect(client).not_to be_valid
      expect(client.errors[:name]).to include("has already been taken")
    end

    it 'is not valid with an invalid phone number length' do
      user = User.create(email: 'pratham21@gmail.com', password: '1111111')
      client = Client.new(
        name: 'Pratham',
        phone_number: '6263089',
        age: 24,
        user_id: user.id
      )
      expect(client).not_to be_valid
      expect(client.errors[:phone_number]).to include("is the wrong length (should be 10 characters)")
    end

    it 'is not valid without an age' do
      user = User.create(email: 'pratham21@gmail.com', password: '1111111')
      client = Client.new(
        name: 'Pratham',
        phone_number: '6263089693',
        user_id: user.id
      )
      expect(client).not_to be_valid
      expect(client.errors[:age]).to include("is not a number")
    end

    it 'is not valid with a non-numeric age' do
      user = User.create(email: 'pratham21@gmail.com', password: '1111111')
      client = Client.new(
        name: 'Pratham',
        phone_number: '6263089693',
        age: 'twenty four',
        user_id: user.id
      )
      expect(client).not_to be_valid
      expect(client.errors[:age]).to include("is not a number")
    end
  end
end
