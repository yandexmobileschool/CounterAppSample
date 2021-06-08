import UIKit


final class CounterViewController: UIViewController {

    let counter = Counter()
    private var counterValueObservation: NSKeyValueObservation?

    @IBOutlet var counterLabel: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        subscribeToCounter()
    }

}

extension CounterViewController {
    private func subscribeToCounter() {
        counterValueObservation = counter.observe(\.value, options: [.initial]) {
            [weak self] _, _ in

            self?.updateCounterLabelValue()
        }
    }
}

extension CounterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        updateCounterLabelValue()
        updateCounterLabelScale(for: traitCollection.verticalSizeClass)
    }

    override func willTransition(
        to newCollection: UITraitCollection,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.willTransition(to: newCollection, with: coordinator)

        coordinator.animate { _ in
            self.updateCounterLabelScale(for: newCollection.verticalSizeClass)
        }
    }
}

extension CounterViewController {
    private func updateCounterLabelValue() {
        guard isViewLoaded else { return }

        counterLabel.text = "\(counter.value)"
        counterLabel.textColor = color(for: counter.value)
    }

    private func color(for value: Int) -> UIColor {
        if value > 0 {
            return UIColor(named: "PositiveColor")!
        }
        if value < 0 {
            return UIColor(named: "NegativeColor")!
        }
        return UIColor(named: "ZeroColor")!
    }

    private func updateCounterLabelScale(for verticalSizeClass: UIUserInterfaceSizeClass) {
        let transform: CGAffineTransform
        if verticalSizeClass == .compact {
            transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        } else {
            transform = .identity
        }
        counterLabel.transform = transform
    }
}

extension CounterViewController {
    @IBAction func incrementCounter() {
        counter.increment()
    }

    @IBAction func decrementCounter() {
        counter.decrement()
    }
}
