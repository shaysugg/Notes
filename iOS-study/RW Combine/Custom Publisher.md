*this example demonstrate how to write a custom publisher for the keyboard appearance.*
## Defining the publisher
In the receive function we connect the subscriber to our publisher by using our subscription.
```Swift
struct KeyboardAppearingPublisher: Publisher {

    typealias Output = KeyboardState

    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, KeyboardState == S.Input {

        let subscription = KeyboardAppearingSubscription<S>(susbscriber: subscriber)

        subscriber.receive(subscription: subscription)

    }
}
```

## Subscription = Logics
Put all of our logic of emitting values into the subscription.
* Use request + demand to setup value emitting process
* Use cancel to clear up and remove emitting process
```Swift
final class KeyboardAppearingSubscription<Target: Subscriber>: Subscription where Target.Input == KeyboardState, Target.Failure == Never {

    let combineIdentifier = CombineIdentifier()

    private let susbscriber: Target

    private let notificationCenter: NotificationCenter

    private var keyboardObservers: (show: NSObjectProtocol, hide: NSObjectProtocol)?

    private var requested: Subscribers.Demand = .none

    init(susbscriber: Target, notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.susbscriber = susbscriber
        self.notificationCenter = notificationCenter
    }

    func request(_ demand: Subscribers.Demand) {
        requested += demand
        if keyboardObservers == nil && demand > .none {
            watchKeyboardChange()
        }
    }

    func cancel() {
        if let keyboardObservers {
            notificationCenter.removeObserver(keyboardObservers.show)
            notificationCenter.removeObserver(keyboardObservers.hide)
        }
    }

    func watchKeyboardChange() {
        let showObserver = notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in

            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            self?.requested -= .max(1)
            _ = self?.susbscriber.receive(.show(height: value.cgRectValue.height))
        }

        let hideObserver = notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.requested -= .max(1)
            _ = self?.susbscriber.receive(.hide)

        }
        
        keyboardObservers = (show: showObserver, hide: hideObserver)
    }
}

enum KeyboardState {
    case show(height: CGFloat)
    case hide
}
```