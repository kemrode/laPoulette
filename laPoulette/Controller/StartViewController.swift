//
//  StartViewController.swift
//  laPoulette
//
//  Created by kevin fichou on 05/12/2022.
//

import UIKit

class StartViewController: UIViewController {
// MARK: - IBOutlets
    @IBOutlet weak var chickenView: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var chickenBtn: UIButton!
    @IBOutlet weak var notChickenBtn: UIButton!
    @IBOutlet weak var score: UILabel!
    
// MARK: - Properties
    private var _score: Int = 0
    private var _chickens: [Chicken] = []
    private var _chicken: Chicken!
    private var _answer: Bool!
    private var _chickenImgView: UIImageView!
    private var _chickenImg: UIImage!
    private var _centerView: CGPoint!

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self._chickens = ChickenData().allChicken
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._centerView = self.chickenView.center
        self.setupStartIBOutlets()
        self.setupStartChickenButton()
    }

// MARK: - Actions Methods
    @IBAction func letsPlayAction(_ sender: UIButton) {
        self.chickenBtn.isHidden = false
        self.notChickenBtn.isHidden = false
        self.randomChicken()
    }
    
    @IBAction func isChickenAction(_ sender: UIButton) {
        self._answer = true
        self.checkIfItIsChicken()
    }

    @IBAction func isNotChickenAction(_ sender: UIButton) {
        self._answer = false
        self.checkIfItIsChicken()
    }

// MARK: - Touch Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.checkIsView(touches: touches) else { return }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.checkIsView(touches: touches) else { return }
        let newCenter = touches.first!.location(in: self.view)
        if (newCenter.x - (self.chickenView.frame.width / 2)) <= 30 {
            self.view.backgroundColor = .green
            self._answer = true
        } else if (newCenter.x - (self.chickenView.frame.width / 2)) >= ((self.view.frame.width / 2) - 100) {
            self.view.backgroundColor = .red
            self._answer = false
        } else {
            self.view.backgroundColor = .white
        }
        self.chickenView.center = newCenter
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.checkIsView(touches: touches) else { return }
        self.chickenView.center = self._centerView
        self.checkIfItIsChicken()
    }
    
// MARK: - Private Methods
    private func setupStartIBOutlets() {
        self.startBtn.titleLabel?.text = "Jouer"
        self._chickenImg = UIImage(named: "accueil")
        self._chickenImgView = UIImageView(image: self._chickenImg)
        self._chickenImgView.contentMode = .scaleToFill
        self.chickenView.addSubview(self._chickenImgView)
        self._chickenImgView.translatesAutoresizingMaskIntoConstraints = false
        self._chickenImgView.widthAnchor.constraint(equalTo: self.chickenView.widthAnchor).isActive = true
        self._chickenImgView.heightAnchor.constraint(equalTo: self.chickenView.heightAnchor).isActive = true    }

    private func setupStartChickenButton() {
        self.chickenBtn.titleLabel?.textColor = .white
        self.chickenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.chickenBtn.tintColor = .green
        self.chickenBtn.isHidden = true
        self.notChickenBtn.titleLabel?.textColor = .white
        self.notChickenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.notChickenBtn.tintColor = .red
        self.notChickenBtn.isHidden = true
    }

    private func randomChicken() {
        let chickenIndex = Int.random(in: (0...(self._chickens.count - 1)))
        self._chicken = self._chickens[chickenIndex]
        self._chickenImgView.image = UIImage(named: self._chicken.imgName)
    }

    private func checkIfItIsChicken() {
        if self._chicken.isChicken {
            self.view.backgroundColor = .green
        } else {
            self.view.backgroundColor = .red
        }
        self.checkAnswer()
        self.randomChicken()
        self.view.backgroundColor = .white
    }

    private func checkAnswer() {
        if self._chicken.isChicken == self._answer {
            self._score += 1
            self.score.text = String(self._score)
        }
    }

    private func checkIsView(touches: Set<UITouch>) -> Bool {
        guard let touch = touches.first else { return false }
        guard let view = touch.view else { return false }
        guard view == self.chickenView else { return false }
        guard self._chickenImgView.image != UIImage(named: "accueil") else { return false }
        return true
    }
}
