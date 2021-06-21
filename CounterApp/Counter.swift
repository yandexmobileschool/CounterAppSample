import Foundation


protocol CounterDelegate: AnyObject {
    func counterValueDidChange(_ sender: Counter)
}

final class Counter: NSObject {
    weak var delegate: CounterDelegate?

    @objc dynamic private(set) var value: Int = 0


    func increment() {
        value += 1
        delegate?.counterValueDidChange(self)
    }

    func decrement() {
        value -= 1
        delegate?.counterValueDidChange(self)
    }
}
