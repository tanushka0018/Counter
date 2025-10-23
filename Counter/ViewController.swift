//
//  ViewController.swift
//  Counter
//
//  Created by Tatiana on 10/19/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var historyTextView: UITextView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    private var counter = 0

    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        historyTextView.isEditable = false
        historyTextView.text = "История изменений:"
        counter = 0
        updateCounterLabel()
        
        historyTextView.alwaysBounceVertical = true
    }

    // MARK: - Actions
    
    @IBAction func plusTapped(_ sender: UIButton) {
        counter += 1
        updateCounterLabel()
        appendLog("значение изменено на +1")
    }
    
    @IBAction func minusTapped(_ sender: UIButton) {
        if counter > 0 {
            counter -= 1
            updateCounterLabel()
            appendLog("значение изменено на -1")
        } else {
            appendLog("попытка уменьшить значение счётчика ниже 0")
        }
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        counter = 0
        updateCounterLabel()
        appendLog("значение сброшено")
    }
    
    // MARK: - Helpers
    
    private func updateCounterLabel() {
        counterLabel.text = "Значение счётчика: \(counter)"
    }
    
    private func appendLog(_ text: String) {
        let ts = dateFormatter.string(from: Date())
        historyTextView.text += "\n[\(ts)]: \(text)"
        let range = NSRange(location: (historyTextView.text as NSString).length - 1, length: 1)
        historyTextView.scrollRangeToVisible(range)
    }
    
    private func configureButtons() {
        plusButton.role = .normal
        minusButton.role = .normal
        resetButton.role = .normal

        var plusCfg = UIButton.Configuration.plain()
        plusCfg.image = UIImage(systemName: "plus")
        plusCfg.baseForegroundColor = .systemRed
        plusCfg.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(pointSize: 28, weight: .bold)
        plusButton.configuration = plusCfg
        
        var minusCfg = UIButton.Configuration.plain()
        minusCfg.image = UIImage(systemName: "minus")
        minusCfg.baseForegroundColor = .systemBlue
        minusCfg.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(pointSize: 28, weight: .bold)
        minusButton.configuration = minusCfg
        
        var resetCfg = UIButton.Configuration.plain()
        resetCfg.image = UIImage(systemName: "arrow.counterclockwise")
        resetCfg.baseForegroundColor = .systemGray
        resetCfg.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(pointSize: 28, weight: .bold)
        resetButton.configuration = resetCfg
    }
}
