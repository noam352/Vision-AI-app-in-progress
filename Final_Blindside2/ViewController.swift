import Foundation
import UIKit
import Firebase

class ViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var viewer: UIImageView!
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            viewer.contentMode = .scaleToFill
            viewer.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savePhoto(_ sender: Any) {
        let imageData = viewer.image!.jpegData(compressionQuality: 0.5)
        let compressedData = UIImage(data: imageData!)
        /*
        let img2 : UIImage = UIImage(named: (viewer.image?.accessibilityIdentifier!)!)!
        let img3: NSData = img2.pngData()
        */
        let strBase64 = imageData?.base64EncodedString()
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("test1.json")
        
       
            let string1:String =  strBase64!
            
            let file = "test1.json" //this is the file. we will write to and read from it
            let text = string1//just a text
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let fileURL = dir.appendingPathComponent(file)
                 //let fileURL=URL(string: "/TEMPO.json")
                do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {/* error handling here */}
                //reading
                do {
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    
                    // Create a root reference
                    let storageRef = storage.reference()
                    
                    // Create a reference to "mountains.jpg"
                    let mountainsRef = storageRef.child("mountains.jpg")
                    
                    // Create a reference to 'images/mountains.jpg'
                    let mountainImagesRef = storageRef.child("images/mountains.jpg")
                    
                    // While the file names are the same, the references point to different files
                    mountainsRef.name == mountainImagesRef.name;            // true
                    mountainsRef.fullPath == mountainImagesRef.fullPath;    // false
                    
                    
                }
                catch {
                }
                

            print("JSON data was written to teh file successfully!")
        }
        
        
        
        UIImageWriteToSavedPhotosAlbum(compressedData!, nil, nil, nil)
    }
    
    
}
/*
let alertController = UIAlertController(title: "Welcome to my first app",
                                        message: "hello world",preferredStyle: UIAlertController.Style.alert)
alertController.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default, handler: nil))
present(alertController, animated: true, completion:nil)
*/
