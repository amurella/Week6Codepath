//
//  CaptureViewController.swift
//  CodePath-Instagram
//
//  Created by Anisha Gupta on 3/5/16.
//  Copyright © 2016 amurella. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var caption: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cameraRoll(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func photoGallery(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
       
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        picker .dismissViewControllerAnimated(true, completion: nil)
        picView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
    @IBAction func addPhoto(sender: AnyObject) {
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["picture"] = getPFFileFromImage(picView.image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption.text
        //post["likesCount"] = 0
        //post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                
                print("There is an error")
            } else {
                self.tabBarController!.selectedIndex = 0
            }
        }
    }
    
        func getPFFileFromImage(image: UIImage?) -> PFFile? {
            // check if image is not nil
            if let image = image {
                // get image data and check if that is not nil
                
                let scaledImage = self.resize(image, newSize: CGSizeMake(750, 750))
                
                if let imageData = UIImageJPEGRepresentation(scaledImage, 0) {
                    return PFFile(name: "image.jpg", data: imageData)
                }
            }
            return nil
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImage = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImage.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImage.image = image
        
        UIGraphicsBeginImageContext(resizeImage.frame.size)
        resizeImage.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
