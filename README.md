# Getting Started with Bonnie E2E Testing

## Setup Appium
To develop and execute Appium tests local or remotely (Sauce Labs) need to setup your local machine. Go to http://appium.io and scroll to the bottom of the home front to reference how to configure your local machine.

In order to setup the local Appium GUI tool, follow screen instructions after clicking **Download Appium** link in the above page. 

### Android
To build apps for local testing (from dev branch), inspect elements on the mobile app, or create virtual devices for local testing.
* Install [Android Studio](https://developer.android.com/studio/index.html)

## Setup the test repository
**DO NOT USE SYSTEM RUBY** for local test development and execution. We need to use a particular version of Ruby and recommend installing one of the following Ruby Version Managers; chruby, rbenv, or RVM. Each of the Ruby Version Managers have Pro's and Con's.

* To manage different versions of Ruby locally, I recommend installing the following tools; [chruby](https://github.com/postmodern/chruby), [ruby-install](https://github.com/postmodern/ruby-install#readme), and [ruby-build](https://github.com/rbenv/ruby-build#readme)
* To use chruby the repo needs .ruby-version file and include version of ruby need for this specific repo.
* Open Terminal
    * Go to testing repo

        ```
        $ cd $GITHUB_HOME/android-mobile-web
        ```
    * Install Ruby 2.2.4  

        ```
        $ ruby-install 2.2.4
        ```
    * Install Bundler

        ```
        $ gem install bundler
        ```
    * Execute Bundle Install

        ```
        $ bundle install
        ```

## Create an Virtual Device for Appium Testing
The following steps will demonstrate how to create virtual devices for local testing.

* Launch Android Studio
* Open project work/github/Bonnie-Android
* Select AVD Manager
* Create Device (Nexus_6_API_22)

## Schema Parser
* Schema Parser fetches a given properties most recent version from S3 and passes the returned config to a page object
* read_json will return the json string form of the object to be used within the page object

## Sauce Labs test execution support
### Basic Setup for access
* In case the testing requires any browser package, this must be uploaded to Sauce Labs. It is assumed all packages are located in the *$GITHUB_HOME/android-mobile-web/apks* directory.
    * Setup Sauce Credentials, inside ~/.bash_profile file export your Sauce Labs credentials and  as environmental variables:

      ```
      $ export SAUCE_USERNAME=<YourSauceLabsUsername>
      $ export SAUCE_ACCESS_KEY=<YourSauceLabsAccessKey>
      $ export UPLOAD_FILENAME=<package-name>.apk
      ```      
    * Upload APK package to sauce-storage

      ```
      $ cd $GITHUB_HOME/android-mobile-web
      $ curl -u $SAUCE_USERNAME:$SAUCE_ACCESS_KEY -X POST -H "Content-Type: application/octet-stream" https://saucelabs.com/rest/v1/storage/$SAUCE_USERNAME/$UPLOAD_FILENAME?overwrite=true --data-binary @apks/$UPLOAD_FILENAME
      ```      
    * Check sauce-storage

        ```
        $ curl -u $SAUCE_USERNAME:$SAUCE_ACCESS_KEY https://saucelabs.com/rest/v1/storage/$SAUCE_USERNAME
        ```

### Sauce Labs Test execution report
The present configuration of this project allows test execution in Sauce Labs environment. All tests generate XML reports in JUnit format at `test_results/results.xml`. This report can be used to track the CI results. Additionally the failed tests also generates a detailed report at `test_results/failed_tests.log`. This file can be used for debugging purposes only and re-running the failed only tests are not supported in the present configuration.

### Sauce Labs Test execution options
Testcases are executed through `Rakefile` using the `parallel_split_test` method. The following command executes all Android test cases:

  ```
  $ rake Android_Emulator
  ```
The tests can be filtered by using `tags` that are associated with either a single or a group of tests. The tags can exist in a test either in _description_ or in _it_ block as follows:

  ```
  describe 'feature name', :featuretag do

    it 'test name 1', :testtag1 do
      <test step 1>
      <test step 2>
      <test step 3>
    end

    it 'test name 2', :testtag2 do
      <test step 1>
      <test step 2>
    end

  end
  ```
All tests within a feature inherits the feature level tags. The tags can be also representated as `:tag1 => true` or `tag1: true`.
The tags are provided in the command line as follows:
* Single tag to include a feature - The command below executes all tests containing the tag `navigation`:

    ```
    $ rake Android_Emulator test_options="--tag @navigation"
    ```
* Single tag to exclude a feature - The command below executes all test cases that does not contain the tag `navigation`:

    ```
    $ rake Android_Emulator test_options="--tag ~@navigation"
    ```
* Multiple tags to add multiple features - The command below executes all test cases that contains either of the following tags:

    ```
    $ rake Android_Emulator test_options="--tag @navigation --tag @search"
    ```
* Multiple tags for logical AND condition - The command below executes the test cases with both @search and @navigation tags:

    ```
    $ rake Android_Emulator test_options="--tag @navigation,@search"
    ```

## Test execution in Local Environment

In order to run the tests in local environment simply execute the rake task `Local_Android` optionally with the tag filters. The output formating options are set in the `.rspec` file. All tests are executed in sequential manner (usig `rspec`). In addition, the application path name should be provided.

### Start Appium and Android Emulator
Please note that the *Appium server* and *Android emulator* **must** be started prior to test execution. The _appium server_ can be installed through `npm` in global scope. The command to install the package is
  ```
  $ npm install -g appium
  ```
Additional details are available in [this link](https://www.npmjs.com/package/appium#quick-start).

The local setup commands are:

  ```
  $ appium &

  $ emulator -avd Nexus_6_API_22 &
  ```
It is assumed that the Android Virtual device mentioned above already exists per [this](#create-an-virtual-device-for-appium-testing) step.

### Command details
The typical command for local test execution is

  ```
  $ rake Local_Android test_options="--tag @tagname" app=/Full_path_to_the_directory_containing_the_app/app-azcentral_sports-debug.apk
  ```
The log output settings are conigured in the `.rspec` file.

In case a browser app is required by the test, this should be installed beforehand. Here is the relevant command for doing so:

  ```
  $ avd install -e /full path the to app/<application-name>.apk
  ```

Filtering of tests works exactly the same way as in the case for Sauce Labs.
