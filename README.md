
# SmartSteps
 
A native iOS health dashboard that reads step and weight data from Apple Health (HealthKit) and shows it in interactive, animated charts. Built with SwiftUI and Swift Charts.
 
> **Status: in progress.** Built following an online course (see [Credits](https://github.com/patelrohan/SmartSteps-SwiftUI/new/main?filename=README.md#credits)) and being extended with my own enhancements. The checklist below shows what is finished and what is next. (see "Planned enhancements").
 

<p align="center">
<img width="371" height="775" alt="Screenshot 2026-11-10 at 5 07 18 PM" src="https://github.com/user-attachments/assets/a05c08cf-6b12-4571-9517-774eb8eb1b87" />
</p>

 
## Tutorial scope
 
The course covers building a complete, portfolio-ready health app, including:
 
- HealthKit: requesting authorization, fetching data, and writing data back to Apple Health
- Swift Charts: bar, pie, and line charts with interactivity and animations
- Error handling, empty states, input validation, and haptics
- Accessibility basics (VoiceOver)
- Git and GitHub workflow: feature branches, pull requests, and releases
- Documentation with DocC
- Swift 6 concurrency and Swift Testing
- Liquid Glass UI and on-device AI with Foundation Models
## Progress
 
### Done
- [x] Xcode project, GitHub repository, and Main > Dev > Feature branching workflow
- [x] Dashboard UI and navigation
- [x] Data list view with date and number formatting
- [x] HealthKit permission priming screen
- [x] HealthKit authorization and fetching step data
- [x] Step bar chart with customization, interactivity, and animations
- [x] Average steps per weekday, shown in an interactive pie chart
### In progress / next
- [ ] Weight charts (line and bar) with interactivity
- [ ] Writing step and weight data to HealthKit
- [ ] Error handling with alerts that deep link to Settings
- [ ] Haptics, empty states (`ContentUnavailableView`), and input validation
- [ ] Refactoring and code organization
- [ ] Basic accessibility (VoiceOver)
- [ ] DocC documentation
- [ ] Swift 6 concurrency and Swift Testing
- [ ] Liquid Glass, Foundation Models
## Planned enhancements (beyond the course)
 
Once the course is complete, I plan to extend the project on my own. These are goals, not finished work, and I will check them off as they land.
 
- [ ] **Dependency injection and unit tests:** put protocols in front of the HealthKit manager (and later the AI coach), add mocks, and test data calculations such as averages and trends
- [ ] **Accessibility:** Dynamic Type support and VoiceOver descriptions for the charts, beyond the basics covered in the course
- [ ] **CI with GitHub Actions:** build and run tests on every pull request
- [ ] **AI coach with Foundation Models:** exploring structured output, tool calling, and fallbacks for devices where the on-device model is unavailable (scope to be decided after finishing the course chapters)
## Tech stack
 
- Swift, SwiftUI
- HealthKit
- Swift Charts
- Git and GitHub
## What I'm practicing
 
- Handling health data permissions in a way that explains the request before the system prompt appears
- Turning raw HealthKit samples into chart-ready data
- Building interactive charts with selection, annotations, and animation
- Working in small feature branches and reviewing my own pull requests
## Requirements
 
- Xcode (latest stable)
- iOS 18 or later (update this to match your project's deployment target)
- A simulator or device with the Health app. Sample data can be added through the Health app on the simulator.
## Running the project
 
1. Clone the repository.
2. Open the `.xcodeproj` in Xcode.
3. Select a simulator and run.
4. Allow Health access when prompted, then add sample step or weight data in the simulator's Health app.
## Credits
 
Based on the Portfolio Project course by Sean Allen. The course provides the structure and feature set. My own changes and enhancements will be listed here as I add them.
