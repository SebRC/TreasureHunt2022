//
//  ViewController.swift
//  TreasureHunt2022
//
//  Created by Sebastian Christiansen on 24/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lowerStackView: UIStackView!
    @IBOutlet weak var upperStackView: UIStackView!
    @IBOutlet weak var bathroomView: UIView!
    @IBOutlet weak var kitchenView: UIView!
    @IBOutlet weak var officeView: UIView!
    @IBOutlet weak var gamingRoomView: UIView!
    @IBOutlet weak var livingRoomView: UIView!
    @IBOutlet weak var hobbyRoomView: UIView!
    @IBOutlet weak var bedroomView: UIView!
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var balconyStackView: UIStackView!
    
    var currentStepIndex = 0
    
    var steps = [Step(answer: "Smooth", location: Location(name: "Bedroom", upper: true)), // Nutella: I skabet
                 Step(answer: "Sjov", location: Location(name: "Living Room", upper: true)), // Tegning/Trøje: I lampeskærm
                 Step(answer: "Blød", location: Location(name: "Gaming Room", upper: false)), // Vafler: I skab med hylder
                 Step(answer: "Forfriskende", location: Location(name: "Kitchen", upper: false)), // Cola: Over køleskab
                 Step(answer: "Sød", location: Location(name: "Bathroom", upper: false)), // Gifler: Over skabet
                 Step(answer: "Sprød", location: Location(name: "Hobby Room", upper: true)), // Chips: Bag jakker
                 Step(answer: "Nice", location: Location(name: "Office", upper: false)) // Airpods: Oven på skabe
                 ]
    
    var locationMap: [String: UIView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMap = ["Bathroom": bathroomView, "Kitchen": kitchenView, "Office": officeView, "Gaming Room": gamingRoomView, "Living Room": livingRoomView, "Hobby Room": hobbyRoomView, "Bedroom": bedroomView]
        for room in locationMap.values {
            room.layer.cornerRadius = 5
            for detail in room.subviews {
                detail.layer.cornerRadius = 2
            }
        }
        
        for balcony in balconyStackView.subviews {
            balcony.layer.cornerRadius = 5
        }
        
        advanceToNextStep(step: steps[currentStepIndex])
    }
    
    private func advanceToNextStep(step: Step) {
        let room = locationMap[step.location.name]
        //room?.layer.borderColor = UIColor.systemYellow.cgColor
        //room?.layer.borderWidth = 5
        let stackView = step.location.upper ? upperStackView : lowerStackView
        let x = room!.frame.minX + (room!.frame.size.width / 2) + 5
        let y = stackView!.frame.minY + (room!.frame.size.height / 2) - 15
        
        if let viewWithTag = self.view.viewWithTag(100) {
            UIView.animate(withDuration: 1.5, animations: {
                viewWithTag.frame = CGRect(x: x, y: y, width: 30, height: 30)
                })
            }
        else {
            let presentView = UILabel(frame: CGRect(x: x, y: y , width: 30, height: 30))
            presentView.tag = 100
            presentView.text = "🎁"
            presentView.font = UIFont.systemFont(ofSize: CGFloat(30))
            view.addSubview(presentView)
            view.bringSubviewToFront(presentView)
            addAnimation(circleView: presentView)
        }
    }
    
    private func addAnimation(circleView: UIView) {
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")

        scaleAnimation.duration = 0.8
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.2;
        scaleAnimation.toValue = 0.8;

        circleView.layer.add(scaleAnimation, forKey: "scale")
    }

    private func createEmojis(emojis: [String: Int]) {
        for _ in 1...100 {
            let size = emojis.randomElement()!.value
            let startingPoint = Int.random(in: 0..<Int(self.view.frame.width))
            let endPoint = Int.random(in: -20..<Int(self.view.frame.width))
            let emojiLabelView = UILabel(frame: CGRect(x: startingPoint, y: Int(self.view.frame.height), width: size, height: size))
            emojiLabelView.font = UIFont.systemFont(ofSize: CGFloat(size))
            self.view.addSubview(emojiLabelView)
            emojiLabelView.text = emojis.randomElement()!.key
            
            UIView.animate(withDuration: Double.random(in: 1..<5), animations: {
                emojiLabelView.frame.origin.x = CGFloat(endPoint)
                emojiLabelView.frame.origin.y = -100
            }, completion: {_ in
                emojiLabelView.removeFromSuperview()
            })
            
        }
    }

    @IBAction func nextStepPressed(_ sender: Any) {
        
        let step = steps[currentStepIndex]
        if(true || answerTextField.text?.lowercased() == step.answer.lowercased()) {
            createEmojis(emojis: ["🇩🇰": 50, "✨": 30, "🎁": 40, "🥳": 50])
            currentStepIndex = currentStepIndex + 1
            if(currentStepIndex > steps.count - 1) {
                currentStepIndex = 0
                if let viewWithTag = self.view.viewWithTag(100) {
                    UIView.animate(withDuration: 1.5, animations: {
                        viewWithTag.alpha = 0.0
                        })
                    }
            }
            else {
                advanceToNextStep(step: steps[currentStepIndex])
            }
        }
    }
}

