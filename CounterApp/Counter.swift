import Foundation


final class Counter: NSObject {
    @objc dynamic private(set) var value: Int = 0

    func increment() {
        value += 1
    }

    func decrement() {
        value -= 1
    }
}
