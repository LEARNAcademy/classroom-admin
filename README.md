# LEARN Academy Student Application

The purpose of the LEARN Academy student application is to streamline workflow and facilitate communication between instructors and students.

### ⚡️ Getting Started

- Clone the repository
- Install dependencies by running:
  - `brew install redis`
  - `bundle`
  - `yarn`
  - `rails db:setup`

### 🚧 Troubleshooting 🚜

- If Ruby version is not 3.1
  - `rvm install 3.1.0`
- When Running bundle, If error: "Your bundle is locked to administrate..."
  - `bundle update`
  - `bundle`
- When `rails db:setup`, let the command finish.

### 🏁 Start the App

Start the server by running `yarn build`

### 🚗 Testing

Execute the existing testing suite by running `rspec spec`

### 🛁 Linting

This project uses [standard](https://github.com/testdouble/standard) as the project linter.

Execute the linter by running `standardrb`

Fix basic linting mistakes by running `standardrb --fix`

### ✅ Pull Requests

Elements of the commit message:

1. Gitmoji that represents the main objective of the PR

- :lipstick: Adds or fixes UI
- :bulb: Adds or updates code comments
- :wrench: Adds or updates config files
- :memo: Adds or updates documentation
- :heavy_plus_sign: Adds or updates dependencies
- :seedling: Adds or updates seed files or mock data
- :white_check_mark: Adds or updates tests
- :bug: Bug
- :pencil2: Fix typos
- :technologist: Improve developer experience
- :truck: Move or rename files or resources
- :sparkles: New feature
- :recycle: Refactor code
- :mute: Remove console logs
- :iphone: Responsive design
- :construction: Work in progress

2. Ticket ID within brackets: `[2]`
3. Brief description of the content, should be similar to the branch and ticket name

```
📝 [21] updates README
```

Fill out the Pull Request template.

### 📚 Resources and References

Project in managed in Notion. Reach out to a member of the team to gain access.

You can view more about the accessability workflow for GitHub Actions here:

- [accessibility insights action](https://github.com/microsoft/accessibility-insights-action/blob/main/docs/gh-action-usage.md)
- [accessibility insights action usage](https://github.com/microsoft/accessibility-insights-action/blob/main/docs/gh-action-usage.md)

### Jumpstart Framework

Once a scaffold has been generated for a model, a directory for that model will be generated with views, controllers, and specs. The views have partials (usually starts with an underscore \_ ) that are rendered and must be modified to specification.

The controllers need to be modified to handle newly generated columns otherwise turbo_stream will be unable to access those properties.

The specs need to be modified so that forms with changed inputs (such as select) have different assertions.

The general workflow can be broken down into 3 steps.

- The specs

app/spec/models
app/spec/requests
app/spec/views

- The view page

app/views/your_model

- The controller

app/controllers/users/your_model.rb

### 💫 Development Useful Commands

- If you're not seeing an updated page mid development.

  ```
  $ yarn build:update
  ```

### Rails classroom-admin

- For the admin side of the app, only controllers namespaced to Admin will have modify the behaviour of the app.
- please keep in mind unused controllers and routes to see if we can get rid of at a later time
  - app/models/concerns/user_agreements.rb
    ```ruby
    # validates :terms_of_service, presence: true, acceptance: true, on: [:create, :invitation_accepted]
    ```
  - config/routes.rb
    ```ruby
    # resources :accounts
    ```
