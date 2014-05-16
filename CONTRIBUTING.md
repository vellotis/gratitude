Contributing to Gratitude
=====================

If you'd like to contribute to Gratitude, you're encouraged to submit [pull requests](https://github.com/JohnKellyFerguson/gratitude/pulls), [propose features and discuss issues](https://github.com/JohnKellyFerguson/gratitude/issues).

#### Fork the Project

Fork the [project on Github](https://github.com/JohnKellyFerguson/gratitude) and check out your copy.

```
git clone https://github.com/contributor/gratitude.git
cd gratitude
git remote add upstream https://github.com/JohnKellyFerguson/gratitude.git
```

#### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

#### Bundle Install and Test

Ensure that you can build the project and run tests.

```
bundle install
bundle exec rake
```

#### Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add to [spec/gratitude](spec/gratitude).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

#### Write Code

Implement your feature or bug fix.

Ruby style is enforced with [Rubocop](https://github.com/bbatsov/rubocop), run `bundle exec rubocop` and fix any style issues highlighted.

Make sure that `bundle exec rake` completes without errors.

#### Write Documentation

Document any external behavior in the [README](README.md).

#### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

#### Push

```
git push origin my-feature-branch
```

#### Make a Pull Request

Go to [Gratitude's Github Project Page](https://github.com/contributor/gratitude) and select your feature branch. Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed within a few days.

#### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```


#### Check on Your Pull Request

Go back to your pull request after a few minutes and check to see whether everything passed on Travis-CI. Everything should look green, otherwise fix any remaining issues.


#### Thank You

Your contributions are greatly appreciated. Thanks for helping out!
