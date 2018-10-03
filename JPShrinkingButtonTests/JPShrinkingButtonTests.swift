import Quick
import Nimble
@testable import JPShrinkingButton

class JPShrinkingButtonSpec: QuickSpec {
    override func spec() {
        describe("JPShrinkingButon") {

            let testFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
            var uut: JPShrinkingButton?

            describe("when .init(coder: NSCoder") {
                beforeEach {
                    let data = NSMutableData()
                    let archiver = NSKeyedArchiver(forWritingWith: data)
                    archiver.finishEncoding()
                    let coder = NSKeyedUnarchiver(forReadingWith: data as Data)
                    uut = JPShrinkingButton(coder: coder)
                }

                it("returns nil") {
                    expect(uut).to(beNil())
                }
            }

            describe(".init(frame: CGRect)") {
                beforeEach {
                    uut = JPShrinkingButton(frame: testFrame)
                    uut?.animator = MockUIViewAnimator()
                }

                describe("when .backgroundColor gets set") {
                    beforeEach {
                        uut?.backgroundColor = UIColor.blue
                    }

                    it("sets .button.backgroundColor to UIColor.blue") {
                        expect(uut?.button?.backgroundColor).to(equal(UIColor.blue))
                    }
                }

                describe("when .tintColor gets set") {
                    beforeEach {
                        uut?.tintColor = UIColor.white
                    }

                    it("sets .button.tintColor to UIColor.white") {
                        expect(uut?.button?.tintColor).to(equal(UIColor.white))
                    }
                }

                describe("when .font gets set") {
                    beforeEach {
                        uut?.font = UIFont.systemFont(ofSize: 21)
                    }

                    it("sets .button.titleLabel.font equal to UIFont.dynamic(style: .title3)") {
                        expect(uut?.button?.titleLabel?.font).to(equal(UIFont.systemFont(ofSize: 21)))
                    }
                }

                describe(".shrunkenFrame") {
                    it("is eqaul to CGRect(x: expandedFrame.maxX - buttonHeight, y: expandedFrame.origin.y, width: buttonHeight, height: buttonHeight)") {
                        expect(uut?.shrunkenFrame).to(equal(CGRect(x: uut!.expandedFrame.maxX - uut!.buttonHeight, y: uut!.expandedFrame.origin.y, width: uut!.buttonHeight, height: uut!.buttonHeight)))
                    }
                }

                it("sets .buttonHeight equal to 50.0") {
                    expect(uut?.buttonHeight).to(equal(50.0))
                }

                it("sets .imageAndTitleSpacing equal to 20.0") {
                    expect(uut?.imageAndTitleSpacing).to(equal(20.0))
                }

                it("sets .expandedCornerRadius equal to 3.0") {
                    expect(uut?.expandedCornerRadius).to(equal(3.0))
                }

                it("sets .isShrunk to false") {
                    expect(uut?.isShrunk).to(beFalse())
                }

                it("sets .animationDuration equal to 0.5") {
                    expect(uut?.animationDuration).to(equal(0.5))
                }

                it("sets .buttonHeight to .frame.size.height") {
                    expect(uut?.buttonHeight).to(equal(testFrame.size.height))
                }

                it("sets .extendedFrame to .frame") {
                    expect(uut?.frame).to(equal(testFrame))
                }


                describe(".addShadow()") {
                    it("sets .layer.shadowColor to UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor") {
                        expect(uut?.layer.shadowColor).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor))
                    }

                    it("sets .layer.shadowOffset to CGSize(width: 2.0, height: 2.0)") {
                        expect(uut?.layer.shadowOffset).to(equal(CGSize(width: 0.0, height: 2.0)))
                    }

                    it("sets .layer.shadowOpacity to 1.0") {
                        expect(uut?.layer.shadowOpacity).to(equal(1.0))
                    }

                    it("sets .layer.shadowRadius to 5.0") {
                        expect(uut?.layer.shadowRadius).to(equal(5.0))
                    }
                }

                describe(".setupButton()") {
                    it("sets .layer.cornerRadius to .expandedCornerRadius") {
                        expect(uut?.layer.cornerRadius).to(equal(uut?.expandedCornerRadius))
                    }

                    it("sets .button.cornerRadius to .expandedCornerRadius") {
                        expect(uut?.button?.layer.cornerRadius).to(equal(uut?.expandedCornerRadius))
                    }

                    it("sets button.clipsToBounds to true") {
                        expect(uut?.button?.clipsToBounds).to(beTrue())
                    }

                    it("sets .button.titleEdgeInsets to UIEdgeInsetsMake(0,imageAndTitleSpacing,0,0)") {
                        expect(uut?.button?.titleEdgeInsets).to(equal(UIEdgeInsetsMake(0, uut!.imageAndTitleSpacing, 0, 0)))
                    }
                }

                describe("when .setTitle()") {
                    beforeEach {
                        uut?.buttonTitle = nil
                        uut?.button = MockUIButton()
                        uut?.setTitle("some title", for: .normal)
                    }

                    it("calls .button.setTitle()") {
                        let mockButton = uut?.button as? MockUIButton
                        expect(mockButton?.setTitleWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("sets .title to 'some title'") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenTitle).to(equal("some title"))
                        }

                        it("sets .state to .normal") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenState).to(equal(.normal))
                        }
                    }

                    describe("when .title is not nil or empty") {
                        beforeEach {
                            uut?.buttonTitle = nil
                            uut?.button = MockUIButton()
                            uut?.setTitle("some title", for: .normal)
                        }

                        it("sets .buttonTitle to 'some title' ") {
                            expect(uut?.buttonTitle).to(equal("some title"))
                        }
                    }

                    describe("when .title is nil") {
                        beforeEach {
                            uut?.buttonTitle = nil
                            uut?.setTitle(nil, for: .normal)
                        }

                        it("does not set .buttonTitle") {
                            expect(uut?.buttonTitle).to(beNil())
                        }
                    }

                    describe("when .title is empty") {
                        beforeEach {
                            uut?.buttonTitle = nil
                            uut?.setTitle("", for: .normal)
                        }

                        it("does not set .buttonTitle") {
                            expect(uut?.buttonTitle).to(beNil())
                        }
                    }
                }

                describe("when .setImage()") {
                    let testImage = UIImage()
                    beforeEach {
                        uut?.button = MockUIButton()
                        uut?.setImage(testImage, for: .normal)
                    }

                    it("calls .button.setImage") {
                        let mockButton = uut?.button as? MockUIButton
                        expect(mockButton?.setImageWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("sets .image to testImage passed in") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenImage).to(equal(testImage))
                        }

                        it("sets .state to .normal") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenState).to(equal(.normal))
                        }
                    }
                }

                describe("when .addTarget()") {
                    beforeEach {
                        uut?.button = MockUIButton()
                        let mockButton = uut?.button as? MockUIButton
                        uut?.addTarget(uut, action: #selector(mockButton?.testAction), for: .touchUpInside)
                    }

                    it("calls .button.addTarget()") {
                        let mockButton = uut?.button as? MockUIButton
                        expect(mockButton?.addTargetWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("sets .target to uut") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenTarget).to(be(uut))
                        }

                        it("sets .action to .testAction") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenAction).to(equal(#selector(mockButton?.testAction)))
                        }

                        it("sets .controlEvents to .touchUpInside") {
                            let mockButton = uut?.button as? MockUIButton
                            expect(mockButton?.givenControlEvents).to(equal(.touchUpInside))
                        }
                    }
                }

                describe("when .expand()") {
                    var animator: MockUIViewAnimator?
                    beforeEach {
                        uut?.button = MockUIButton()
                        uut?.expand()
                    }

                    it("calls .animator.animate()") {
                        animator = uut?.animator as? MockUIViewAnimator
                        expect(animator?.animateWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("has a duration equal to .animationDuration") {
                            animator = uut?.animator as? MockUIViewAnimator
                            expect(animator?.givenDuration).to(equal(uut?.animationDuration))
                        }

                        it("has .animations") {
                            expect(animator?.givenAnimations).toNot(beNil())
                        }

                        describe("when those animations runs") {
                            beforeEach {
                                animator = uut?.animator as? MockUIViewAnimator
                                animator?.givenAnimations?()
                            }

                            it("sets .frame to .expandedFrame") {
                                expect(uut?.frame).to(equal(uut?.expandedFrame))
                            }

                            it("sets .layer.cornerRadius to .expandedCornerRadius") {
                                expect(uut?.layer.cornerRadius).to(equal(uut?.expandedCornerRadius))
                            }

                            it("calls .button.setTitle") {
                                let mockButton = uut?.button as? MockUIButton
                                expect(mockButton?.setTitleWasCalled).to(beTrue())
                            }

                            it("sets .button.layer.cornerRadius to .expandedCornerRadius") {
                                expect(uut?.button?.layer.cornerRadius).to(equal(uut?.expandedCornerRadius))
                            }

                            it("sets .button.frame to CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)") {
                                expect(uut?.button?.frame).to(equal(CGRect(x: 0, y: 0, width: uut!.bounds.size.width, height: uut!.bounds.size.height)))
                            }

                            it("has a .completion") {
                                expect(animator?.givenCompletion).toNot(beNil())
                            }

                            describe("when that completion runs") {
                                beforeEach {
                                    animator = uut?.animator as? MockUIViewAnimator
                                    animator?.givenCompletion?(true)
                                }

                                it("sets .isShrunk to false") {
                                    expect(uut?.isShrunk).to(beFalse())
                                }
                            }
                        }
                    }
                }

                describe("when .shrink()") {
                    var animator: MockUIViewAnimator?
                    beforeEach {
                        uut?.button = MockUIButton()
                        uut?.shrink()
                    }

                    it("calls .animator.animate()") {
                        animator = uut?.animator as? MockUIViewAnimator
                        expect(animator?.animateWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("has a duration equal to .animationDuration") {
                            animator = uut?.animator as? MockUIViewAnimator
                            expect(animator?.givenDuration).to(equal(uut?.animationDuration))
                        }

                        it("has .animations") {
                            expect(animator?.givenAnimations).toNot(beNil())
                        }

                        describe("when those animations runs") {
                            beforeEach {
                                animator = uut?.animator as? MockUIViewAnimator
                                animator?.givenAnimations?()
                            }

                            it("sets .frame to .expandedFrame") {
                                expect(uut?.frame).to(equal(uut?.expandedFrame))
                            }

                            it("sets .layer.cornerRadius to uut.bounds.size.width * 0.5") {
                                expect(uut?.layer.cornerRadius).to(equal(uut!.bounds.size.width * 0.5))
                            }

                            it("calls .button.setTitle()") {
                                let mockButton = uut?.button as? MockUIButton
                                expect(mockButton?.setTitleWasCalled).to(beTrue())
                            }

                            it("sets .button.layer.cornerRadius equal to .bounds.size.width * 0.5") {
                                expect(uut?.button?.layer.cornerRadius).to(equal(uut!.bounds.size.width * 0.5))
                            }

                            it("sets .button.frame to CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)") {
                                expect(uut?.button?.frame).to(equal(CGRect(x: 0, y: 0, width: uut!.bounds.size.width, height: uut!.bounds.size.height)))
                            }

                            it("has a .completion") {
                                expect(animator?.givenCompletion).toNot(beNil())
                            }

                            describe("when that completion runs") {
                                beforeEach {
                                    animator = uut?.animator as? MockUIViewAnimator
                                    animator?.givenCompletion?(true)
                                }

                                it("sets .isShrunk to false") {
                                    expect(uut?.isShrunk).to(beTrue())
                                }
                            }
                        }
                    }
                }

                describe("when .toggleAnimation()") {
                    beforeEach {
                        uut?.toggleAnimation()
                    }

                    it("fal") {
                        expect(uut?.isShrunk).to(beTrue())
                    }
                }

            }
        }
    }
}

