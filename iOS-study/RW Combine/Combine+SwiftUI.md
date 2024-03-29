SwiftUI modifier which behaves much like the sink(receiveValue:) and you can directly subscribe to publishers inside the view
```Swift
struct ContentView: View {
	private let timer = Timer.publish(every: 10, on: .main,
	in: .common)
	.autoconnect()
	.eraseToAnyPublisher()


	var body: some View {
		Text("")
			.onReceive(timer) {
			  self.currentDate = $0
			}
}
```