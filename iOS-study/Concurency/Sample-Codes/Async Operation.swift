
extension AsyncOperation {
  enum State: String {
    case ready, executing, finished

    fileprivate var keyPath: String {
      return "is\(rawValue.capitalized)"
    }
  }
}

class AsyncOperation: Operation {
  // Create state management
  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }

  // Override properties
  override var isReady: Bool {
    return super.isReady && state == .ready
  }

  override var isExecuting: Bool {
    return state == .executing
  }

  override var isFinished: Bool {
    return state == .finished
  }

  override var isAsynchronous: Bool {
    return true
  }

  // Override start
  override func start() {
    main()
    state = .executing
  }
}

/*:
 AsyncSumOperation simply adds two numbers together asynchronously and assigns the result. It sleeps for two seconds just so that you can
 see the random ordering of the operation.  Nothing guarantees that an operation will complete in the order it was added.

 - important:
 Notice that `self.state` is being set to `.finished`. What would happen if you left this line out?
 */
class AsyncSumOperation: AsyncOperation {
  let rhs: Int
  let lhs: Int
  var result: Int?

  init(lhs: Int, rhs: Int) {
    self.lhs = lhs
    self.rhs = rhs

    super.init()
  }

  override func main() {
    DispatchQueue.global().async {
      Thread.sleep(forTimeInterval: 2)
      self.result = self.lhs + self.rhs
      self.state = .finished
    }
  }
}

//: Now that you've got an `AsyncOperation` base class and a `AsyncSumOperation` subclass, run it through a small test.
let queue = OperationQueue()
let pairs = [(2, 3), (5, 3), (1, 7), (12, 34), (99, 99)]

pairs.forEach { pair in
  let op = AsyncSumOperation(lhs: pair.0, rhs: pair.1)
  op.completionBlock = {
    guard let result = op.result else { return }
    print("\(pair.0) + \(pair.1) = \(result)")
  }

  queue.addOperation(op)
}

//: This prevents the playground from finishing prematurely.  Never do this on a main UI thread!
queue.waitUntilAllOperationsAreFinished()

