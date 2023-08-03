require 'rails_helper'

RSpec.describe Trainer, type: :model do
  describe 'validation' do 
    it 'validate with valid attributes' do
      user = User.create(email: "pratham21@gmail.com", password: '111111')
      trainer = Trainer.new(
        name: "Pratham",
        age: 24,
        phone_number: '6263089693',
        user_id: user.id
      )
    expect(trainer).to be_valid
    end

    it 'not be validate with duplicate name' do
      user = User.create(email:"pratham21@gmail.com", password:"111111")
      Trainer.create(
        name: "Pratham",
        age: 24,
        phone_number: "6263089693",
        user_id: user.id
      )

      trainer = Trainer.new(
        name: "Pratham",
        age: 24,
        phone_number: "6263089693",
        user_id: user.id
      )
      expect(trainer).not_to be_valid
      expect(trainer.errors[:name]).to include("has already been taken")
    end

    it 'not be valid without name' do
      user = User.create(email: "pratham21@gmail.com", password: "111111")
      trainer = Trainer.new(
        age: 24,
        phone_number: '6263089693'
      )
      expect(trainer).not_to be_valid
      expect(trainer.errors[:name]).to include("can't be blank")
    end

    it 'not be valid with non numeric age' do
      user = User.create(email: "pratham21@gmail.com", password: "111111")
      trainer = Trainer.new(
        name: "Pratham",
        age: "twenty four",
        phone_number: "6263089693"
      )
      expect(trainer).not_to be_valid
      expect(trainer.errors[:age]).to include('is not a number')
    end

    it 'not be valid with non numeric phone_number' do
      user = User.create(email: "pratham21@gmail.com", password: "password")
      trainer = Trainer.new(
        name: "Pratham",
        age: 24,
        phone_number: "six0896930"
      )
      expect(trainer).not_to be_valid
      expect(trainer.errors[:phone_number]).to include('is not a number')
    end

    it 'not be valid with incorrect length of phone_number' do
      user = User.create(email: "pratham21@gmail.com", password: "password")
      trainer = Trainer.new(
        name: "Pratham",
        age: 24,
        phone_number: "626308969"
      )
      expect(trainer).not_to be_valid
      expect(trainer.errors[:phone_number]).to include('is the wrong length (should be 10 characters)')
    end
  end
end
