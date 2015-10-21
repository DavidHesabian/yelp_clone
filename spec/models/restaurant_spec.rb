require 'spec_helper'
require 'pry'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'deletes reviews if restaurant is deleted' do
    restaurant = Restaurant.create(name: "KFC", rating: 3)
    review = restaurant.reviews.create(thoughts: "Good", rating: 3)
    restaurant.destroy
    expect(restaurant.reviews.count).to eq 0
  end

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'cant create duplicate restaurants with the same name' do
    Restaurant.create(name: "KFC", rating: 3)
    restaurant = Restaurant.create(name: "KFC", rating: 3)
    expect(restaurant.errors[:name]).to eq ["Name already exists"]
  end


end

