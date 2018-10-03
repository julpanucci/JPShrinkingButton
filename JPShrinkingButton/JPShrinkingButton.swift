import UIKit


class UIViewAnimator {
    func animate(withDuration duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
}

public class JPShrinkingButton: UIView {

    //MARK: - Constants

    let imageAndTitleSpacing: CGFloat = 20.0
    let expandedCornerRadius: CGFloat = 3.0
    let animationDuration = 0.5

    //MARK: - Public Variables

    public override var backgroundColor: UIColor? {
        didSet {
            self.button?.backgroundColor = self.backgroundColor
        }
    }
    public override var tintColor: UIColor? {
        didSet {
            self.button?.tintColor = self.tintColor
        }
    }
    public var font: UIFont? {
        didSet {
            self.button?.titleLabel?.font = self.font
        }
    }

    public private(set) var isShrunk = false

    //MARK: - Internal Variables

    var buttonTitle: String?
    var button: UIButton?
    var animator = UIViewAnimator()
    var buttonHeight: CGFloat = 50.0
    var expandedFrame: CGRect!
    var shrunkenFrame: CGRect {
        get {
            return CGRect(x: expandedFrame.maxX - buttonHeight, y: expandedFrame.origin.y, width: buttonHeight, height: buttonHeight)
        }
    }

    //MARK: - Initializers

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return nil
    }

    public override init(frame: CGRect) {
        buttonHeight = frame.size.height
        expandedFrame = frame
        super.init(frame: frame)

        button = UIButton(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        self.addSubview(button!)

        self.addShadow()
        self.setUpButton()
    }

    //MARK: - Button Methods

    public func setTitle(_ title: String?, for state: UIControlState) {
        if let title = title, !title.isEmpty {
            buttonTitle = title
        }
        self.button?.setTitle(title, for: state)
    }

    public func setImage(_ image: UIImage, for state: UIControlState) {
        self.button?.setImage(image, for: state)
    }

    public func addTarget(_ target: Any?, action: Selector, for events: UIControlEvents) {
        self.button?.addTarget(target, action: action, for: events)
    }

    //MARK: - Animation Methods

    public func expand() {
        animator.animate(withDuration: animationDuration, animations: {
            self.frame = self.expandedFrame
            self.layer.cornerRadius = self.expandedCornerRadius

            self.setTitle(self.buttonTitle, for: .normal)
            self.button?.layer.cornerRadius = self.expandedCornerRadius
            self.button?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        }) { (done) in
            self.isShrunk = false
        }
    }

    public func shrink() {
        animator.animate(withDuration: animationDuration, animations: {
            self.frame = self.shrunkenFrame
            self.layer.cornerRadius = self.bounds.size.width * 0.5

            self.button?.setTitle("", for: .normal)
            self.button?.layer.cornerRadius = self.bounds.size.width * 0.5
            self.button?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        }) { (done) in
            self.isShrunk = true
        }
    }

    public func toggleAnimation() {
        isShrunk ? self.expand() : self.expand()
        isShrunk = !isShrunk
    }

    //MARK: - Private Methods

    private func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
    }

    private func setUpButton() {
        self.layer.cornerRadius = expandedCornerRadius
        self.button?.layer.cornerRadius = expandedCornerRadius
        self.button?.clipsToBounds = true
        self.button?.titleEdgeInsets = UIEdgeInsetsMake(0, imageAndTitleSpacing, 0, 0)
    }
}

