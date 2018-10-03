@testable import JPShrinkingButton

class MockUIViewAnimator: UIViewAnimator {
    var animateWasCalled = false

    var givenDuration: Double? = nil
    var givenAnimations: (() -> Void)?
    var givenCompletion: ((Bool) -> Void)?

    override func animate(withDuration duration: Double, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        animateWasCalled = true
        givenDuration = duration
        givenAnimations = animations
        givenCompletion = completion
    }
}
