//
//  ViewController.swift
//  OmikujiApp
//
//  Created by 森園王 on 2021/11/06.
//

import UIKit
import AVFoundation //この1行を追記


class ViewController: UIViewController {

    @IBOutlet weak var stickView: UIImageView!
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var bigLabel: UILabel!
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()

    
    let resultTexts: [String] = [
        "K",
        "Q",
        "J",
        "10",
        "9",
        "8",
        "7",
        "6",
        "5",
        "4",
        "3",
        "2",
        "A"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSound() //この1行を追加

    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        if motion != UIEvent.EventSubtype.motionShake {
            // シェイクモーション以外では動作させない
            return
        }

        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
        stickLabel.text = resultTexts[resultNum]
        stickBottomMargin.constant = stickHeight.constant * -1

        UIView.animate(withDuration: 1, animations: {

            self.view.layoutIfNeeded()

            }, completion: { (finished: Bool) in
                self.bigLabel.text = self.stickLabel.text
                self.overView.isHidden = false
                self.resultAudioPlayer.play()
            })
    }
    
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
    }
    //この下から追記！→ 結果表示するときに鳴らす音の準備
    func setupSound() {
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3") {
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
}

