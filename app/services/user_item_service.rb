# frozen_string_literal: true

class UserItemService
  def call
    ActiveRecord::Base.transaction do
      user = User.create!(email: "test@example.com", name: "Test User", password: "password")
      item = ActiveRecord::Base.transaction do
        Item.create!(user: user, name: "Test Item 2", description: "Test Description 2", price: 200)
        raise ActiveRecord::Rollback
      end
    end
  end
end
