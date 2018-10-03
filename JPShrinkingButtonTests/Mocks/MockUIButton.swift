import Quick
import Nimble

class MockUIButton: UIButton {

    var setTitleWasCalled = false
    var addTargetWasCalled = false
    var setImageWasCalled = true

    var givenTitle: String?
    var givenState: UIControlState?
    var givenTarget: Any?
    var givenAction: Selector?
    var givenControlEvents: UIControlEvents?
    var givenImage: UIImage?

    override func setTitle(_ title: String?, for state: UIControlState) {
        setTitleWasCalled = true
        givenTitle = title
        givenState = state
    }

    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        addTargetWasCalled = true
        givenTarget = target
        givenAction = action
        givenControlEvents = controlEvents
    }

    override func setImage(_ image: UIImage?, for state: UIControlState) {
        setImageWasCalled = true
        givenImage = image
        givenState = state
    }

    @objc func testAction() {}
}
