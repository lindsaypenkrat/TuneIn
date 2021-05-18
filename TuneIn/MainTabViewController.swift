//
//  MainTabViewController.swift
//  TuneIN
//
//  Created by Lindsay Penkrat on 5/4/21.
// 

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn //authentication with Google

class MainTabViewController: UITabBarController {
    //var spots: Spots! //rename to user that will contain the master information.
    var authUI: FUIAuth!
    var partyUser: PartyUser!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
//        showAlert(title: "What!!!", message: "Fantastic I Loaded")
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
//        showAlert(title: "What!!!", message: "Fantastic I Will disappear")
    }
    
    //triggered on appearance
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: add logic if we are signed in already then we do not need to sign in again. not sure why I did this
//        showAlert(title: "What!!!", message: "Fantastic I appeared")
        signIn()
    }
    
    //TODO: any additional setup after loading the view.
    //control tab bar
    //'set a variable for the tab bar
    let UIMainTabViewItem = UITabBarItem()
    
    //need to set destination party user variable to ensure we can navigate.
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print ("\(self.selectedIndex )")
        switch self.tabBarItem.title    {
        case "Profile":
//            showAlert(title: "Tab 1", message: "You are Cool")
//            set the destiantion tab view controller to have a user property filled
            return
        case "Message":
//            set the destiantion tab view controller to have a user property filled
            return
        case "Home":
            return
        case "":
            return
        default:
            return
        }
    }
    
    //alert or the image picker
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //sign into google  so we can access information for the mapping
    func signIn() {
        let providers: [FUIAuthProvider] = [FUIGoogleAuth(),]
        let currentUser = authUI.auth?.currentUser
        if authUI.auth?.currentUser == nil {
            self.authUI?.providers = providers
            let loginViewController = authUI.authViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
        } else {
           //Logic Rule: saves user if they are new
            partyUser = PartyUser(user: currentUser!)
            partyUser.saveIfNewUser()
        }
        //Logic Rule: sets global variable of the user that is logged in.
        setPartyUser(PartyUser: partyUser)
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do {
            try authUI!.signOut()
            print("^^^ Successfully signed out!")
            //            tableView.isHidden = true
            exit(0)
            //signIn()
        } catch {
            //            tableView.isHidden = true
            print("*** ERROR: Couldn't sign out")
        }
    }
}
extension MainTabViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            //                tableView.isHidden = false
            print("*** We signed in with the user \(user.email ?? "unknown e-mail")")
        }
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        let marginInsets: CGFloat = 16.0 // amount to indent UIImageView on each side
        let topSafeArea = self.view.safeAreaInsets.top
        
        // Create an instance of the FirebaseAuth login view controller
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        
        // Set background color to white
        loginViewController.view.backgroundColor = UIColor.white
//        loginViewController.view.backgroundColor = #colorLiteral(red: 0.8496006131, green: 0.7486783862, blue: 0.5343332887, alpha: 1)
        
        //clear the cancel button
        loginViewController.navigationItem.leftBarButtonItem?.isEnabled = false
        loginViewController.navigationItem.leftBarButtonItem?.tintColor = .clear
        
        // Create a frame for a UIImageView to hold our logo
        let x = marginInsets
        let y = marginInsets + topSafeArea
        let width = self.view.frame.width - (marginInsets * 2)
        //        let height = loginViewController.view.subviews[0].frame.height - (topSafeArea) - (marginInsets * 2)
        let height = UIScreen.main.bounds.height - (topSafeArea) - (marginInsets * 2)
        
        let logoFrame = CGRect(x: x, y: y, width: width, height: height)
        
        // Create the UIImageView using the frame created above & add the "logo" image
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "eagle")
        logoImageView.contentMode = .scaleAspectFit // Set imageView to Aspect Fit
        loginViewController.view.addSubview(logoImageView) // Add ImageView to the login controller's main view
        return loginViewController
    }
}
