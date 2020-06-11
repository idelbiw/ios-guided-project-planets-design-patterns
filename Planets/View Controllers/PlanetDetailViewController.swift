//
//  PlanetDetailViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 9/20/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    var planet: Planet? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        guard let planet = planet, isViewLoaded else {
            imageView?.image = nil
            label?.text = nil
            return
        }
        
        imageView.image = planet.image
        label.text = planet.name
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let existingPlanet = planet else { return }
        
        do {
            let planetData = try PropertyListEncoder().encode(existingPlanet)
            coder.encode(planetData, forKey: "existing planet")
        } catch {
            NSLog("Could not encode planet data: \(error)")
            return
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        guard let planetData = coder.decodeObject(forKey: "existing planet") as? Data else { return }
        
        do {
            let savedPlanet = try PropertyListDecoder().decode(Planet.self, from: planetData)
            planet = savedPlanet
        } catch {
            NSLog("Could not decode planet data: \(error)")
        }
        
    }
    
} //End of class
