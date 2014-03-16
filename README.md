Makers Academy - Week 4 - Rubying Test
======================================

Task 1
------

> Reopen the 'Array' class or subclass it.
> Rewrite the inject method. White a test for it first. Don't worry about returning an enumerator, assume a block is always given.
> Name your method differently (i.e, not inject() or subclass 'Array') because rspec uses inject() internally and the tests will fail with weird messages unless your implementation of inject is perferct.
>	If you would like a challenge, rewrite inject using two approaches: using iterators and using recursion but it is not required to pass the test.

Task 2
------

> Write a class 'Takeaway'
> Implement the following functionalities:
	> List of dishes
	> Placing the order by giving the list of dishes, their quantity and the number that should be the exact total. If the sum is not correct the method should raise an error, otherwise the customer is sent a text saying that the order was placed successfully and that it will be delivered 1 hour from then, e.g.: "Thank you! Your order was placed and will be delivered before 18:52".
	> The text sending functionality should be implemented using Twilio API. You'll need to register for it. It is free.
	> Use twilio-ruby gem to access the API.
	> Use a Gemfile to manage your gems.
	> Make sure that your Takeaway class is throughly tested and that you use mocks and/or stubs, as necessary to not send texts when the tests are run.
	> However, if your Takeaway class is loaded into IRB, and the order is placed, the text should actually be sent.
> A free account on Twilio will allow you to send texts to "verified" numbers. Use your mobile phone number, don't worry about the customer's modile phone. 
