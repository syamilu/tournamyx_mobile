# tournamyx_mobile

## MAD LADS
| Name     | Matric No           | Tasks  |
| :------------- |:-------------| :-----|
| Wan Muhammad Syamil bin W Mohd Yusof| 2220561 | login page, favourite team page, setup firebase, setup repository |
| Luqman Alhakim bin Malik Arman |2211145| registration page, profile page, api setup and calling, favoriting team feature |
| Nabil bin Muhd Nordin | 2210859 | navigation bar, tournament page, tournament detail page, firestore docs and collection setup |

## Group Project : Tournamyx Mobile
Tournamyx Mobile is a application designed for participants and spectators of robotic competitions(our current focus is IIUM Robotic Competition). This mobile app brings the excitement of robotic tournaments to users fingertips, offering a comprehensive suite of features to enhance competition experience. Main features of this mobile app is fixture and schedule, tournament standings, live updates and favourite teams.

### Objective
1. Enhancing user experience
2. Improve ingormation acceessibility
3. Facilitate competition management

### Features and functionalities
1. Firebase authentication
2. ⁠Change password
3. ⁠⁠Display all tournaments
4. ⁠⁠Select categories
5. ⁠⁠Display scores for teams by group in table view
6. ⁠⁠Add team to favorite

### Screen Navigation and Widgets Implementation
- Screen Navigation:
  - Authentication:
    - Login page :
      - First page displayed when user enter the apps
      - User need to enter correct email and password to login
      <br><br>
      <img src="screenshot/login_page.png" width="200" height="500" />
<br><br>
    
    - Register page :
      - User can register using email and password.
      - They also need to provide username
<br><br>
      <img src="screenshot/register_page.png" width="200" height="500" />
<br><br>
  - Favourite:
    - Favourite page :
      - This page display user's favorite team.
      - Their leaderboard and upcoming match.
      - The team also highlighted inside the leaderboard.
   <br><br>
    <img src="screenshot/fav_page.png" width="200" height="500" />
  <br><br>

  - Profile:
    - Profile page :
      - User profile page, user can sign out or change password here
   <br><br>
    <img src="screenshot/profile_page.png" width="200" height="500" />
  <br><br>
    - Change password page :
      - User input new password to change
   <br><br>
    <img src="screenshot/change_pass.png" width="200" height="500" />
  <br><br>

  - Tournament:
    - Tournament page
      - This page displays the list of the tournaments that are currently held and will be held.
      - We plan in the future to so the user will add their own tournament.
      - In the card there's an arrow that will be redirected to the Tournaments Details Page.
      - The page is as follows:
        <br><br>
     <img src="screenshot/tournament_page.png" width="200" height="500" />
       <br><br>

    - Tournament Details page
      - This page will display the table for categories for this specific tournament named "IIUM Robotic Competition 2024"
      - As for this case, we will have a button that will popup a dialog that let the user choose the categories. For this case which will be "Soccer Primary" and "Soccer Secondary".
      - By default, it will show the table for "Soccer Memory".
      - In the table it will show stats of the tournaments in their respective groups which will be based on:
        - Team Name
        - Wins
        - Draws
        - Losses
        - Points
        - Goals Success
        - Goals Conceded

    <br><br>
    <img src="screenshot/tour_detaills_page.png" width="200" height="500" />
    <br><br>
- Widgets Implementation:
  - General use:
    - Top App Bar
      - To display current page title
    - Bottom Navigation Bar
      - To navigate between each main page 
    - Loading screen
      - Displayed when data fetching is not finish 
   
  - Favourite page:
    - Table to view all matches from your favourite team
      - Show the leaderboard of the user's favourite team 

  - Profile page:
    - Button to change password and sign out
      - Reusable button widget
   
  - Tournament page:
    - Categories dialog button
      - To select between different category and different table
    - Table for both primary and secondary
      - Display leaderboard for current category and team selected
    - Tournament Card
      - Show current tournament available  

### Sequence Diagram

<img src="screenshot/SD_mad.jpg" width="400" height="600" />

<img src="screenshot/sitemap_app.png" width="1000" height="400" />

### Plugin and Packages
1. Dart http packages
2. Ionicons packages
3. Firebase Firestore

### References
1. Flutter. (n.d.). Flutter documentation. Docs.flutter.dev. https://docs.flutter.dev/
2. Google. (2023). Firebase. Firebase. https://firebase.google.com/
3. Ionic. (n.d.). Ionicons: The premium icon pack for Ionic Framework. Ionic.io. https://ionic.io/ionicons
4. http | Dart Package. (n.d.). Dart Packages. https://pub.dev/packages/http
5. Flutter - Read and Write Data on Firebase. (2020, November 8). GeeksforGeeks. https://www.geeksforgeeks.org/flutter-read-and-write-data-on-firebase/

## Weekly Progress Report
<img src="screenshot/weeklyprogress1.jpg" width="600" height="400" />

<img src="screenshot/weeklyprogress2.jpg" width="600" height="400" />

