# iOS Development Environment Setup

This is the guide to setup your iOS development environment. Please follow the instructions carefully.

## Before You Begin

1. Get access to [1Password](https://start.1password.com/open/i?a=KQ4D7LWWSFCYDMVV2JG5EPFV6E&v=rypss6e6gzukrkmjcrh7tr5vzq&i=jmqqonydepbdrpdkzkuplay7mi&h=alltrails.1password.com).
2. Post in the #help-itsupport Slack channel to be added to the AllTrails GitHub org. Specify access to the iOS repo: [alltrails_ios_3](https://github.com/alltrails/alltrails_ios_3).
3. Request that your phone (+ watch, if applicable) are registered as Apple dev devices.
4. Make sure you're using zsh on your dev machine. Commands in this doc are in zsh. If you're not already using it, follow these steps to switch. 
    1. (Option 1) If run `Terminal` run `chsh -s /bin/zsh`.
    2. (Option 2) Install [iTerm](https://iterm2.com) and [Oh My Zsh](https://ohmyz.sh) for a generally better terminal experience.

## New Machine Setup

Step 1. [Install Xcode](#install-xcode)  
Step 2. [Install HomeBrew](#install-homebrew)  
Step 3. [Create a Personal Access Token on GitHub](#create-personal-access-token)  
Step 4. [Register an SSH key in GitHub](#register-ssh-key)  
Step 5. [Clone the repo](#clone-the-repo)  
Step 6. [Update submodules](#update-submodules)  
Step 7. [Install JDK](#install-jdk)  
Step 8. [Setup secrets](#setup-secrets)  

1. Install the latest version of Xcode from the App Store. Pick the latest major (non-beta) version. <a id="install-xcode"></a>
    1. The version of git on your machine is sufficient. You can use it from the command line, or a graphical client of your choice (e.g. [SourceTree](https://www.sourcetreeapp.com) or [GitKraken](https://www.gitkraken.com) ).
    2. Post in the `#team-ios` Slack channel. Ask to be added to AllTrails' dev team. Specify that `Access to Certificates, Identifiers & Profiles` permissions must be checked in App Store Connect.

2. Install the [Homebrew](https://brew.sh) package manager.<a id="install-homebrew"></a>
    1. Follow the installation directions on the website
    2. Follow the instructions at the end of the installation to finish integrating with your shell (should be zsh)
    3. Run `brew doctor` and follow any instructions. Repeat this process until you see “Your system is ready to brew”

3. Create a Personal Access Token in GitHub<a id="create-personal-access-token"></a>
    1. **Navigate to GitHub:** Visit [Github's](https://github.com/) website.
    2. **Access Developer Settings:**
        * Click on your profile icon in the top right corner.
        * Go to Settings -> Developer Settings -> Personal access tokens -> Tokens (classic).
    3. **Generate a New Token:**
        * Click on the "Generate new token (classic)".
        * **Note:** Give your token a descriptive name (e.g., "Xcode Swift Package Access").
        * **Expiration:** Choose an expiration date. For security reasons, we recommend against choosing "No expiration".
        * **Select Scopes:** This is crucial. Grant permissions for the token to access private repositories. **Select the** `repo` `admin:public_key` & `user` **scopes.** This grants read & write access to public and private repositories.
        * Click the "Generate token" button.
        * **Important:** GitHub will display the generated token only once. Store it in a secure place and copy the value. You need it for the next step.
    4. **Configure Xcode to Use your Personal Access Token**
        1. **Open Xcode:** Launch Xcode on your machine.
        2. **Access Account Preferences:**
            * Go to "Xcode" in the menu bar.
            * Select "Settings..." (or "Preferences..." in older Xcode versions).
        3. **Navigate to Accounts:**
            * Click on the "Accounts" tab.
        4. **Add a GitHub Account:**
            * Click the "+" button in the bottom left corner.
            * Select "GitHub" from the dropdown menu.
        5. **Authenticate with your Token:**
            * In the authentication dialog, select "Personal Access Token".
            * Enter your GitHub username.
            * Paste the Personal Access Token you created into the "Password" field.
        6. **Sign In:**
            * Click "Sign In".
        7. **Verify Configuration:**
            * You should see your GitHub account in the Accounts tab. This means Xcode is setup to use your Personal Access Token.
    5. **Specify that you want Github notifications to go to your work email address**
        1. Click the Profile icon in the top-right corner.
        2. Go to Settings -> Notifications.
        3. Set your Default Notifications email to your AllTrails email.

4. <a id="register-ssh-key"></a>Register an SSH key in GitHub for your development machine. (Optionally, this can also be done [manually](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh))
    1. Install the GitHub CLI with `brew install gh` in your terminal.
    2. Run `gh auth login`.
    3. Follow the prompts. Set SSH as your preferred protocol (for the rest, defaults will do)
    4. Authorize the newly created SSH with SSO (cloning will fail otherwise). This can be done on [github.com](http://github.com) -> Your Profile Icon -> Settings -> SSH & GPG Keys -> Authentication Keys -> Configure SSO beside the AllTrails key

5. <a id="clone-the-repo"></a>Clone the [alltrails_ios_3](https://github.com/alltrails/alltrails_ios_3) repository from GitHub.

6. <a id="update-submodules"></a>From the `alltrails_ios_3` folder in your terminal, run:
    1. `git submodule update --init`. This will clone our submodule repos.
    2. Our submodules update automatically. They don't need manual updates (`git pull`). This includes our Analytics events repo [Analytics Definitions](https://github.com/alltrails/alltrails_analytics_definition). Our design tokens repo [Denali](https://github.com/alltrails/denali). And the [Kotlin multiplatform](https://github.com/alltrails/alltrails_kmp) submodule.

7. <a id="install-jdk"></a>JDK Installations
    1. JDK installation required to build ATUtilKit library. Run scripts/install_kmp_dependencies.sh

8. <a id="setup-secrets"></a>Setup Secrets
    1. AllTrails secrets (API keys, tokens, etc) live in 1password. You need 1password CLI and developer mode in order to sync your secrets and build the app. Follow these steps [1password CLI setup](https://developer.1password.com/docs/cli/get-started/).
    2. You need access to the "Mobile" vault in 1password. If you don't already, ask an admin for access.
    3. Run this script in your shell: `scripts/secret_manager_sync.sh`. This initiates a sync via `secret_manager`. It copies secrets from 1password into your local mac keychain. There's a build phase in Xcode that then loads secrets from your kechain into the AllTrails iOS app. The script might ask you to authenticate via 1password. Do it (ensure the AllTrails account is selected). You will be prompted to authenticate your keychain. Enter your mac password. This syncs the secrets into your mac keychain so you don't have to enter your password every time you build. See [secret_manager docs](https://github.com/alltrails/mobile_util/blob/main/secret_manager/README.md) for more details. You will need to run this any time a new secret is added.

9. Build the App
    1. Open `AllTrails.xcodeproj` and try to build & run the app. Do this for the simulator and your tethered device (must be connected by wire). If you run into issues just ask for help!
    2. On your first time building, you may be prompted for your mac password. This unlocks the keychain so Xcode can access secrets. Enter your password & click "Always allow".

Sometimes artifacts can't be resolved or errors occur (e.g., “invalid archive returned…”). In this case: from Xcode, select **File** > **Packages** > **Reset Package Cache** and **Update To Latest Package Versions**

## Set up PR Automation

1. Update `scripts/github_slack_user_id_conversion.yml` with your GitHub and Slack usernames.

## You're all set! Below steps are for more info, troubleshooting, or setting up custom workflows.

## Working with Swift Package Manager

The installation of packages to pinned versions happens automatically via Swift Package Manager. But failures can happen. If the build fails because packages can’t be installed, try resetting the package cache in Xcode. File → Packages → Reset Package Cache.

The Report navigator tab has SPM logs to troubleshoot further.

![Report Navigator Tab](docs/images/report-navigator-tab.png)

SPM sometimes updates package versions by itself. This changes the project’s `Package.resolved` file. You can revert these updates if they're unintended.

# iOS Development Guide

## Architecture & Patterns

All architecture patterns, code standards, and best practices are documented in `AGENTS.md` at the repository root. This includes:

- **MVVM + Finite State Machine architecture** - How we structure ViewModels and Views
- **Coordinator Pattern** - Managing navigation flows in SwiftUI
- **Dependency Injection** - Protocol-based DI with default implementations
- **Async/Await patterns** - Modern concurrency patterns
- **Core Data rules** - Required patterns for safe data persistence
- **Testing standards** - What and how to test with XCTest
- **File organization** - Where things go and why
- **Code quality standards** - Swift best practices, SwiftLint, and Denali design system

Read [AGENTS.md](/AGENTS.md) before starting any work in this codebase.

## Creating New Modules

For instructions on creating a new Swift Package module, see:

[Creating New Modules](/docs/creating-new-modules.md)

## Working with AI Coding Assistants

This codebase includes instructions for AI coding assistants like Claude Code, Cursor, GitHub Copilot, and others. All development standards are centralized in `AGENTS.md` so that every tool can access the same information.

### Why AGENTS.md?

We maintain a single source of truth for how code should be written in this project. Rather than having different instructions for different tools (Cursor rules, Claude Code settings, etc.), everything lives in one place. This makes it easier to keep standards up to date and ensures consistency across the team regardless of which AI tool you use.

### What's in AGENTS.md?

The file contains everything an AI (or human) needs to know to work on this project:

- Build commands and how to run tests
- Required architecture patterns and when to use them
- Code organization and file structure
- Testing requirements and patterns
- Security and performance standards
- Git workflow and commit style
- Common anti-patterns to avoid

### Using AGENTS.md with Your AI Tool

Most modern AI coding assistants will automatically detect and use `AGENTS.md` when working in this codebase. If you're using a tool that doesn't automatically load it:

- **Claude Code**: Automatically loads `AGENTS.md` as project context
- **Cursor**: References `AGENTS.md` from `.cursor/rules/` files
- **Other tools**: Point your AI assistant to read `AGENTS.md` at the start of a session

### Updating AGENTS.md

When you introduce new patterns, change architecture decisions, or establish new standards:

1. Update `AGENTS.md` with the new information
2. Place it in the appropriate section (or create a new one if needed)
3. Keep explanations clear and include code examples
4. Update the table of contents if you add new sections
5. Get your changes reviewed like any other code

The file is maintained by the iOS team and should evolve as our practices evolve. If something in `AGENTS.md` is outdated or unclear, fix it in your PR.

## Download Code Signing Certificates and Profiles

This section is only needed for specific workflows like creating ad hoc distribution builds from the local environment or for rotating the certificates in the code signing repo for CI. Code signing certificates and provisioning profiles used by CI are available in a private git repo and can be accessed and refreshed with fastlane match. You can install development certificates & provisioning profiles from the command line using Fastlane. 

1. Navigate to the `alltrails_ios_3/AllTrails` folder in your Terminal.
2. Select your Xcode build tools by running the command `sudo xcode-select -s /Applications/Xcode.app`
3. Open the [iOS FastLane Commands](https://alltrails.1password.com/vaults/ytulmkv5six4atx5tp5fxxg624/allitems/qvihr7i7hfsg72oxzajhlr66oe) doc in 1Password. Read it carefully.
    1. There are 3 commands to run. **They must be run one at a time; not as a batch.**
    2. The first command will prompt you for a `Passphrase for Match storage`. This can be found in the aforementioned `iOS Build Credentials` doc.
    3. If the commands stall with a warning about the authenticity of the [Github](http://github.com) host, kill them (repeated ^c), and then issue the command `ssh-keyscan github.com >> ~/.ssh/known_hosts`. Then try again.
4. When you execute the first command you'll be prompted for various credentials. The match encryption key and the Apple ID password for `dev@alltrails.com` live in the [iOS Build Credentials](https://alltrails.1password.com/vaults/ytulmkv5six4atx5tp5fxxg624/allitems/3stkjhe7qu7ev6kj532jteevkq) doc. When prompted for the password for the login keychain enter your mac password. You may be prompted for 2FA via SMS to a known phone number. If so, post in the #ios-tech-talk Slack channel to have your number added, or for a code to be relayed to you. 

If you run into issues, just ask for help! Don't guess.

### The Nuclear Option

The [iOS Fastlane Commands](https://alltrails.1password.com/vaults/ytulmkv5six4atx5tp5fxxg624/allitems/qvihr7i7hfsg72oxzajhlr66oe) doc in 1Password has details for how to revoke Development and Distribution certificates for iOS, and remove provisioning profiles from Apple’s servers. When these commands are run you will need to re-run the fastlane commands to pull down the new certs and provisioning profiles.

The following these steps can help if you run into code signing errors:

1. Exit Xcode
2. Delete all files in the `~/Library/MobileDevice/Provisioning Profiles` folder
3. Delete signing certs from the keychain
    1. Launch the Keychain Access app
    2. Select the “login” keychain on the left, and then select the “My Certificates” tab. 
    3. Delete any certs that look like these:

    ![Certs](docs/images/cert.png)

4. Install the latest certs and provisioning profiles using step 10 above 
5. Open Xcode and clean your build folder
6. You should now be able to build!

This doc is current as of May 2026. Last edits to this doc were made in PR: https://github.com/alltrails/alltrails_ios_3/pull/20123
