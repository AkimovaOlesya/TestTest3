//
//  ViewController.swift
//  PomidoroTestProject1
//
//  Created by o.akimova on 30.11.2021.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var isStarted = false
    var isWorkedTime = true
    var isTimerStarted = false
    var currentValueTimer = 10
    var time = 0

    private lazy var labelTime: UILabel = {
        var label = UILabel()

        label.text = formatTime(from: currentValueTimer)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.99, green: 0.50, blue: 0.00, alpha: 1)
        label.font = UIFont(name: "Optima" , size: 70)

        return label
    }()

    private lazy var buttonPlayAndPause: UIButton = {
        var button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.setImage(Icon.IconWork.iconPlay, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(2.6, 2.6, 2.6)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)

        return button
    }()

    @objc private func tappedButton() {
        if !isStarted {
            startTimer()
            isStarted = true
            configureButtonsState()
        } else {
            timer.invalidate()
            isStarted = false
            configureButtonsState()
            //pauseAnimation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()
        setupView()
    }

    private func setupHierarchy() {
        view.addSubview(labelTime)
        view.addSubview(buttonPlayAndPause)

    }

    private func setupLayout() {
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelTime.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true

        buttonPlayAndPause.translatesAutoresizingMaskIntoConstraints = false
        buttonPlayAndPause.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonPlayAndPause.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true

    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func configureButton(button: UIButton, iconImage: UIImage?) {
        button.setImage(iconImage, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(2.4, 2.4, 2.4)
    }

    private func configureButtonsState() {
        if isStarted {
            isWorkedTime ? configureButton(button: buttonPlayAndPause, iconImage: Icon.IconWork.iconPause) : configureButton(button: buttonPlayAndPause, iconImage: Icon.IconRest.iconPause)
        } else {
            isWorkedTime ? configureButton(button: buttonPlayAndPause, iconImage: Icon.IconWork.iconPlay) : configureButton(button: buttonPlayAndPause, iconImage: Icon.IconRest.iconPlay)
        }
    }

    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
    }

    @objc private func tickTimer() {
        currentValueTimer -= 1
        labelTime.text = formatTime(from: currentValueTimer)
        configureTimer()
    }

    private func configureTimer() {
        if currentValueTimer == 0 && isWorkedTime{
            timer.invalidate()
            currentValueTimer = 10
            labelTime.text = formatTime(from: currentValueTimer)
            labelTime.textColor = Colors.greenColor
         //   isAnimationStarted = false
            configureButton(button: buttonPlayAndPause, iconImage: Icon.IconRest.iconPlay)
          //  createCircularRest()
            isStarted = false
            isWorkedTime = false
        }

        if currentValueTimer == 0 && !isWorkedTime {
            timer.invalidate()
            currentValueTimer = 30
            labelTime.text = formatTime(from: currentValueTimer)
            labelTime.textColor = Colors.orangeColor
          //  isAnimationStarted = false
            configureButton(button: buttonPlayAndPause, iconImage: Icon.IconWork.iconPlay)
         //   createCircularWork()
            isStarted = false
            isWorkedTime = true
        }
    }

    private func formatTime(from time: Int) -> String {
        let minute = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02i:%02i", minute, seconds)
    }

    enum Colors {
        static let orangeColor = UIColor(red: 0.99, green: 0.50, blue: 0.00, alpha: 1)
        static let greenColor = UIColor(red: 0.34, green: 0.62, blue: 0.17, alpha: 1)
    }

    enum Icon {
        enum IconWork {
        static let iconPlay = UIImage(systemName: "play")?.withTintColor(UIColor(red: 0.99, green: 0.50, blue: 0.00, alpha: 1), renderingMode: .alwaysOriginal)
        static let iconPause = UIImage(systemName: "pause")?.withTintColor(UIColor(red: 0.99, green: 0.50, blue: 0.00, alpha: 1), renderingMode: .alwaysOriginal)
        }

        enum IconRest {
            static let iconPlay = UIImage(systemName: "play")?.withTintColor(UIColor(red: 0.34, green: 0.62, blue: 0.17, alpha: 1), renderingMode: .alwaysOriginal)
            static let iconPause = UIImage(systemName: "pause")?.withTintColor(UIColor(red: 0.34, green: 0.62, blue: 0.17, alpha: 1), renderingMode: .alwaysOriginal)
        }
    }
}

