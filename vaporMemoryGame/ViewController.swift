//
//  ViewController.swift
//  vaporMemoryGame
//
//  Created by wizO on 03/11/2018.
//  Copyright © 2018 Carlos Agundez Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var seconds = 15
    var indexImage: Int = 0
    var indexSolution: Int = 0
    
    var indexImageSolution: [Int] = [0,0,0,0,0,0,0,0,0]
    var indexImageUser: [Int] = [0,0,0,0,0,0,0,0,0]
    
    @IBOutlet weak var secondsLeft: UILabel!
    @IBOutlet weak var timeLeftLbl: UILabel!
    @IBOutlet weak var youWinLbl: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let imageArray: [UIImage] = [#imageLiteral(resourceName: "photoone"),#imageLiteral(resourceName: "phototwo"),#imageLiteral(resourceName: "photothree"),#imageLiteral(resourceName: "photofive")]
    var buttonArray = [UIButton] ()

    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonArray = [buttonOne,buttonTwo,buttonThree,buttonFour,buttonFive,buttonSix,buttonSeven,buttonEight,buttonNine]
        
        youWinLbl.text = ""
    }
    
    
    //Actúa como contador restando segundos y la lógica de si este contador llega a 0
    @objc func counter(){
        
        seconds -= 1
        secondsLeft.text = String(seconds)
        
        if (seconds == 0) && (startButton.isHidden == false){
            putInitialImage()
            startButton.isHidden = true
            seconds = 20
            
        }
        
        if (seconds == 0) && (startButton.isHidden == true){
            timer.invalidate()
            timeLeftLbl.text = ""
            secondsLeft.text = ""
            compareSolution()
        }
    }
    
    
    //Es el botón de inicio, empieza la cuenta atrás y el juego
    @IBAction func startButton(_ sender: Any) {
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        
        randomImage()
        
        youWinLbl.text = ""
    }
    
    
    //Se encarga de poner una imagen random(generando un número random) en el array de botones a partir de su indice
    func randomImage(){
        var randomIndex:Int
        
        for i in 0...8{
            randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
            indexImageSolution[i] = randomIndex
            buttonArray[i].setImage(imageArray[randomIndex], for: UIControlState.normal)
            
        }
        
        print(indexImageSolution)
    }
    
    
    //Coloca una imagen inicial en todos los botones
    func putInitialImage(){
        for i in 0...8{
            buttonArray[i].setImage(#imageLiteral(resourceName: "coverimage"), for: UIControlState.normal)
        }
    }
    
    
    //Compara el index de la solución con el que ha puesto el usuario diciendo si has ganado o perdido
    func compareSolution(){
        
        if (indexImageUser == indexImageSolution){
            youWinLbl.text = "YOU WIN"
        }else{
            
            youWinLbl.text = "YOU LOSE"
        }
        
            seconds = 15
            startButton.isHidden = false
            putInitialImage()
    }
    
    
    //Se encarga de pasar a la siguiente foto del array de imágenes cuando se presiona cualquier botón y de actualizar el estado de su index en una variable para poder compararla(si has ganado o perdido)
    @IBAction func buttonImageTapped(_ sender: UIButton) {
        
        indexImage = indexImage + 1
        if (indexImage>=imageArray.count) {
            indexImage = 0;
        }
        
        
        sender.setImage(imageArray[indexImage], for: UIControlState.normal)
        
        let indexSender = sender.tag - 1
        
        indexImageUser[(indexSender)] = indexImage

        
    }
    




}

