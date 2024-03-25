> You should try to run using the Thread Sanitizer frequently — and not just once. Enabling the sanitizer has a pretty steep performance impact of anywhere between 2x to 20x CPU slowdown, and yet, you should run it often or otherwise integrate it into your workflow, so you don't miss out on all of these sneaky threading issue!

![[thread-sanitizer-1.png]]![[thread-sanitizer-2.png]]>