require '../lib/takeaway'

describe 'Takeaway application' do

	let(:takeaway) { Takeaway.new }
	let(:twilio_client) { double :TwilioRESTClient}

	context 'There should' do
	 
		it 'Exist a menu with some items.' do
			menu = { 	:prawn_crackers => 1.00,
								:spare_ribs => 5.00,
								:special_fried_rice =>4.50,
								:spring_roll => 0.99,
								:sweet_and_sour_soup => 3.00}
			expect(takeaway.menu).to eq menu
		end
	end

	context "Sending text messages:" do

		it 'Using a new Twilio API client' do
      expect(Twilio::REST::Client).to receive(:new).and_return twilio_client

      expect(takeaway.twilio_client).to be twilio_client
    end

		it 'Using a current Twilio API client' do
      expect(Twilio::REST::Client).to receive(:new).and_return twilio_client

      takeaway.twilio_client

      expect(takeaway.twilio_client). to be twilio_client
    end

    it 'Send message if successful with a message' do
      message = "Thank you!"
      account = double :account
      sms = double :sms
      messages  = double :messages

      expect(takeaway).to receive(:twilio_client).and_return twilio_client
      expect(twilio_client).to receive(:account).and_return account
      expect(account).to receive(:sms).and_return sms
      expect(sms).to receive(:messages).and_return messages
      expect(messages).to receive(:create) do |message_hash|
        expect(message_hash[:body]).to eq message
      end

      takeaway.send_text(message)
    end

	end
	context 'Should we receive:' do

    context 'Incorrect order(s):' do

      it 'Raise an error if the total is wrong' do
        expect {
          takeaway.place_order({ :spare_ribs => 5.00, }, 1)
        }.to raise_error(ArgumentError,
          'The total is wrong. Please check your order and place it again.')
      end

    end

    context 'Correct order(s):' do

      let(:place_correct_order) { takeaway.place_order(
      	{ :spare_ribs => 1,
          :prawn_crackers => 2 },
        7.00) }

      it 'Place the order(s).' do
        expect(takeaway).to receive(:send_text).and_return true

        expect(takeaway.place_order({ :spare_ribs => 1, :prawn_crackers => 2 }, 7.00)).to be_true
      end

      it 'Send an order confirmation by text.' do
        expect(takeaway).to receive(:send_text).and_return true

        place_correct_order
      end

      it 'Confirm the delivery time of one hour from now.' do
        one_hour_from_now = (Time.now + 60 * 60).strftime("%H:%M")
        expect(takeaway).to receive(:send_text) do |message|
          expect(message).to include one_hour_from_now
        end

        place_correct_order
      end
    end
	end
end