require "rails_helper"

RSpec.describe Item, type: :model do
  it "must have a name" do
    item = Item.new

    expect(item).to_not be_valid

    item.name = "Kebab"

    expect(item).to be_valid
  end

  it "must have unique name" do
    Item.create(name: "Kebab")

    item = Item.new(name: "Kebab")

    expect(item.valid?).to be false
    expect(item.errors.full_messages).to include "Name has already been taken"
  end
end
