# How to Localize an iOS App

1. Add localization languages in the `.xcodeproj -> Localizations`

2. create a new file with `.strings` format and call it `Localizable`

3. open Localizable.string and write the keyworad and translations like this:

   ```swift
   // keyworld : actual localized string ;
   "hello-world" : "salam donya";
   "button" : "dokme";
   ```

4. in the same file open the left panel and click on Localize button then select the Localization that this file is belong to.

5. use keywords instead of actual string across the app.

6. build and run to see keyworld to see keywords would translate to the selected language of device.

**Happy Localizating! 🌍**

