# infoEdge_Task
This SwiftUI project implements three screens based on the Figma design and API requirements
provided by Aisle.
It demonstrates phone number login, OTP verification, and fetching profile notes using authenticated
API calls.
Figma Design:
https://www.figma.com/file/Mh6Jb8gBxT9MewfWkKNwOV/Tech-Challenge?node-id=0%3A1
Screens Implemented
1. Phone Number Screen:
- Fields: Country Code (pre-filled as +91), Phone Number
- On tapping 'Continue', a POST request is made to:
/users/phone_number_login with {'number': '+919876543212'}
- On success, navigates to OTP screen.
2. OTP Verification Screen:
- Enter OTP (1234) and tap 'Continue'
- POST request to /users/verify_otp with {'number': '+919876543212', 'otp': '1234'}
- On success, receives auth_token and navigates to Notes screen.
3. Notes Screen:
- GET request to /users/test_profile_list with Header {'Authorization': 'auth_token'}
- Displays invited and liked profiles (blurred unless upgraded).
Technologies Used:
- SwiftUI, Combine, MVVM architecture
- URLSession for API calls
- SDWebImageSwiftUI for image handling
- Core Data (optional for token persistence)
Installation:
1. Clone repo: git clone https://github.com/yourusername/aisle-tech-challenge.git
2. Open in Xcode: open AisleTechChallenge.xcodeproj
3. Set iOS deployment target to 15.0+
Notes:
- Test with number +919876543212 and OTP 1234
- Use received auth_token for Notes screen
- Use ephemeral URLSession if image timeout issues occur
Features:
- Figma-aligned UI
- Clean MVVM pattern
- Navigation and network logic properly separated
