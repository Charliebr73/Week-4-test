require 'twilio-ruby'
require_relative 'twilio-credentials'

class Takeaway

	attr_reader :messenger
  attr_reader :menu, :phone_number


		def menu
			menu = {  :prawn_crackers => 1.00,
								:spare_ribs => 5.00,
								:special_fried_rice => 4.50,
								:spring_roll => 0.99,
								:sweet_and_sour_soup => 3.00
							 }
		end

		def place_order(dishes_and_quantities, order_total)
	    actual_price = check_price_of(dishes_and_quantities)
	    raise_order_total_error if actual_price != order_total
	    send_order_confirmation
  	end

	  def send_order_confirmation
	    one_hour_from_now = (Time.now + 60 * 60).strftime("%H:%M")
	    order_confirmation = "Thank you for your order. " +
	     "Expect your items to be delivered before #{one_hour_from_now}"
	    send_text(order_confirmation)
	  end

	  def check_price_of(dishes_and_quantities)
	    dishes_and_quantities.inject(0) do |price, (dish, quantity)|
	      price += menu[dish] * quantity
	    end
	  end

	  def raise_order_total_error
	    raise ArgumentError, 'The total is wrong. Please check your order and place it again.'
	  end

	  def twilio_client
	    account_sid = TwilioCredentials::ACCOUNT_SID
	    auth_token = TwilioCredentials::AUTH_TOKEN
	    @twilio_client ||= Twilio::REST::Client.new account_sid, auth_token
	  end

	  def send_text(message)
	    twilio_client.account.sms.messages.create(
	      :from => TwilioCredentials::FROM_NUMBER,
	      :to => TwilioCredentials::TO_NUMBER,
	      :body => message)
	  end


end