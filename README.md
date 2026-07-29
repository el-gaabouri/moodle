# Moodle — Flutter Coursework

## Overview

This repository contains a coursework meant to recreate a mobile-optimised version of the Moodle platform using Flutter.
This is a dummy test application.

## Table of Contents

- [Overview](#overview)
- [Functionality](#functionality)
- [Run the Application](#run-the-application)
- [View the application in mobile view](#view-the-application-in-mobile-view)
- [Run tests](#run-tests)

## Functionality

- Login page with university branding and entry into the Moodle dashboard.
- Responsive AppBar and side drawer navigation for Dashboard, My courses, My assessments, Calendar, and Profile.
- Account menu from the profile initials with Profile and Logout actions.
- Dashboard containing a timeline, latest announcements, and the reusable calendar widget.
- Course overview with responsive course cards, course images, and course filtering.
- Course details pages populated from course data models, including Course, Module Info, and Reading Lists sections.
- Assessment overview populated from assessment data models with upcoming and past assessment cards.
- Assignment details pages with dynamic submission status and time remaining based on the assessment due date.
- Interactive calendar with month navigation, day selection, deadline filtering, date picker, and clickable deadline items.
- Global AppBar search across courses, resources, reading lists, referral activities, and assessments.

## Run the Application

### Clone the repository

```bash
git clone https://github.com/el-gaabouri/moodle
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run -d chrome
```

Alternatively, click on the run button in the `main.dart` as shown below and make sure the device is set to Chrome:

![Step 4: Run the Application](images/step4_terminal.png)

The application will build and open in a new Chrome browser window, displaying the Dashboard.

### View the application in mobile view

To view the responsive layout and test the application in mobile view in DevTools:

***Press F12 (or right-click anywhere and select Inspect) in Chrome to open Developer Tools.***

***Click the Toggle Device Toolbar icon (or press Ctrl+Shift+M / Cmd+Shift+M) to emulate a mobile screen.***

***From the left-hand side dropdown, select an iPhone (e.g., iPhone 12 Pro) to emulate a mobile layout. See the screenshot below for reference.***

![Step 5: Emulate Mobile Layout in DevTools](images/step5_devtools_open.png)

## Run tests

To test the application functionalities, run:
```bash
flutter test
```
