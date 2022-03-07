# custom-alert

## capture image
<img src="https://user-images.githubusercontent.com/43785575/157088488-6d076917-ef77-44af-bd36-3c2b1fb19978.png" width="300" height="649">

<br>

## how to use
```swift
let alertVC = UAlertController(title: "Alert", message: "message ...")
let alertActionYes = UAlertAction(title: "Yes", style: .standard) {
    print("click yes")
}
let alertActionNo = UAlertAction(title: "No", style: .standard) {
    print("click no")
}
alertVC.addAction(alertActionYes)
alertVC.addAction(alertActionNo)

self.present(alertVC, animated: true, completion: nil)
```
