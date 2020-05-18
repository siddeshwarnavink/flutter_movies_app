![App Banner](./dev_assets/movies-banner.png)

A sample app build using [flutter](https://www.flutter.dev) & [firebase](https://firebase.google.com)

## 🤑 Getting Started
### Step 1: Clone the project
First clone this repository using git
```
git clone <repository-url>
```

### Step 2: Connect to your firebase app
Then you need to change the firebase urls in ``lib/providers/*.dart`` for example in `movies_provider.dart`

```
https://<your-project-name>.firebaseio.com/movies.json
```

Also in ``lib/providers/auth_provider.dart`` you need to change the firebase api key to your own key

### Step 3: Setup Realtime database
Import ``dev_assets/cinema-ticket-bookings-export.json`` to your firebase realtime database.

### Step 4: Enable email-password authentication
Under Authentication > Sign-in method enable enable email-password authentication.

### Step 5: You are good to go!
Now run the project using:
```
cd <project-dir>
flutter run
```
You will see the running app 🤩

## 🤝 Contributing
You need to folk this project first and work on this locally. After your done with:

```
git checkout -b my-fix
# fix some code...

git commit -m "fix: corrected a typo"
git push origin my-fix
```

Lastly, open a pull request on Github.