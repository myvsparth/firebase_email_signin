# firebase_email_signin

    Google Firebase Login using Flutter. 

## Introduction

    Google firebase is trending nowadays. Google firebase has around 10 signin methods which includes email, google, facebook, phone, twitter, yahoo etc login. We are covering only on email login in this article. We will cover other login methods in next articles. I would like to say that email login method is one of the easiest login methods using google firebase. Now, we are going step by step. I have given git repository link in the bottom as well.

## Steps:
- First and basic step to create new application in flutter. If you are a beginner in flutter then you can check my blog Create a first app in Flutter. I have created app named as “flutter_email_signin”
- Now, You need to setup a project in Google Firebase. Follow below steps for that. Please follow the step very carefully.
- Goto https://console.firebase.google.com/ and add new project. I will share screenshot how it looks so you will get a better idea.
- Click on Add Project to add new project in Google Firebase. Then you will find below form
 


- Give a project name and accept the terms and condition and click on the Create Project. It will take some time to create a new project and redirect you to project overview page.

- Now, you need to add android app in this project [Please check below screenshot]. You can add new android project from clicking on android icon. You can also add ios project if you want to create ios application for the same.



- In Project Overview add android app for that click on the android icon. It will open new form please check below screenshot.


 
- Android package name you will find in the AndroidManifest.xml file in the Android => App => main folder of your project.
- App nickname is optional
- For SHA-1 generation goto https://developers.google.com/android/guides/client-auth

- In step 2 download google-service.json and put in android => App folder of your project
- In step 3 you can see you need to configure some dependencies
- Project-level build.gradle (<project>/build.gradle): means build.gradle file in Android folder directly
    buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.2.0'
    
    }
    App-level build.gradle (<project>/<app-module>/build.gradle): means build.gradle file in Android = > App folder
    // Add to the bottom of the file
    apply plugin: 'com.google.gms.google-services’

- Note: Don’t need to add  implementation 'com.google.firebase:firebase-core:16.0.9' in dependencies
- In Step 4 It will try to verify your app. For that you need to run your app once or you can skip this step.
- Hurrey :) your android app has been created.


- Now, you need to enable Email/Password Sign In method in firebase. For that you need to go to the Authentication tab and then Signin method tab. From there enable Email/Password sign in method. Please check the screenshot.



- You are all done with firebase Setup. Congratulations…. :)

- Get back to the project and Open pubspec.yaml file in the root of the project. Pubspec.yaml is used to define all the dependencies and assets of the project.

- Add below dependencies and save the file
    firebase_auth:
- Please check below screenshot you will get more idea where to add the dependency



- Run flutter packages get in terminal OR If you are using Visual Studio Code then after saving file it will automatically runs the flutter packages get command.

- Now, we are done with all dependency setup at project side as well…. :)

- Now, we need to programmatically handle signup and signin in google firebase. For that we create 2 pages login_page.dart and registration_page.dart and signup and signin in both page. I have attached a link of git repo in the bottom of the article, you can take reference from there. Here I will just define signin and signup methods for understanding.

    import 'package:firebase_auth/firebase_auth.dart';

    SignUp Programmatically in Google Firebase:
            Future<FirebaseUser> signUp(email, password) async {
    try {
        FirebaseUser user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        assert(user != null);
        assert(await user.getIdToken() != null);
        return user;
    } catch (e) {
        handleError(e);
        return null;
   
 

    SignIn Programmatically in Google Firebase:
            Future<FirebaseUser> signIn(String email, String password) async {
    Try {
        FirebaseUser user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        assert(user != null);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await auth.currentUser();
        assert(user.uid == currentUser.uid);
        return user;
    } catch (e) {
        handleError(e);
        return null;
   
 
- When you sign up successfully you can check that google firebase store the user detail in server. Please check the screenshot.



## NOTE:
    PLEASE CHECK OUT GIT REPO FOR FULL SOURCE CODE. YOU NEED TO ADD YOUR google-services.json FILE IN ANDROID => APP FOLDER.

Git Repo: https://github.com/myvsparth/firebase_email_signin

## Conclusion:
- Google firebase is very good service provider in terms of data validation, data store, realtime data, push notification. We have only used google firebase for sign in feature. We can do more out of it.


For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
