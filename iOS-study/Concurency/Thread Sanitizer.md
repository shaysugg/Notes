To detect race conditions and other thread-related issues, enable the Thread Sanitizer tool from the Diagnostics section of the appropriate build scheme.

You ==can’t use Thread Sanitizer to diagnose iOS, tvOS, and watchOS apps running on a device. ==Use Thread Sanitizer only on your 64-bit macOS app, or to diagnose your 64-bit iOS, tvOS, or watchOS app running in Simulator.

> You should try to run using the Thread Sanitizer frequently — and not just once. Enabling the sanitizer has a pretty steep performance impact of anywhere between 2x to 20x CPU slowdown, and yet, you should run it often or otherwise integrate it into your workflow, so you don't miss out on all of these sneaky threading issue!

![[thread-sanitizer-1.png]]![[thread-sanitizer-2.png]]>