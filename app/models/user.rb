class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  
  attr_accessor :stripe_card_token
  
  # If Pro user passes validations (email, password, etc.), then call Stripe
  # and tell Stripe to set up a subscription upon charging a customer's card.
  #
  # NOTE: Subscription does not work due to difference in Stripe dashboard
  # from when course was created. I took "plan" out of the params when creating
  # the customer because I was unable to assign a plan ID to the different plans
  # on my Stripe dashboard.
  #
  # Stripe responds back with customer data.
  # Store customer.id as the customer token and save the user.
  def save_with_subscription
      if valid?
          customer = Stripe::Customer.create(description: email, card: stripe_card_token)
          self.stripe_customer_token = customer.id
          save!
      end
  end
end
