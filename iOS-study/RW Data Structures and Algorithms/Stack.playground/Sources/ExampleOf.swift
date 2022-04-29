import Foundation

public func example(of description: String, _ function: () -> Void) {
    print(description)
    function()
}
