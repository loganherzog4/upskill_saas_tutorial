class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  
  attr_accessor :stripe_card_token
  
  def save_with_subscription
      if valid?
          customer = Stripe::Customer.create(description: email, id: "prod_Iqj5x1aeQBG4J4", card: stripe_card_token)
          self.stripe_customer_token = customer.id
          save!
      end
  end
end
