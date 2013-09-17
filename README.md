gratitude
=========
[![Gem Version](https://badge.fury.io/rb/gratitude.png)](http://badge.fury.io/rb/gratitude)
[![Build Status](https://travis-ci.org/JohnKellyFerguson/gratitude.png?branch=master)](https://travis-ci.org/JohnKellyFerguson/gratitude)
[![Dependency Status](https://gemnasium.com/JohnKellyFerguson/gratitude.png)](https://gemnasium.com/JohnKellyFerguson/gratitude)
[![Code Climate](https://codeclimate.com/github/JohnKellyFerguson/gratitude.png)](https://codeclimate.com/github/JohnKellyFerguson/gratitude)
[![Coverage Status](https://coveralls.io/repos/JohnKellyFerguson/gratitude/badge.png)](https://coveralls.io/r/JohnKellyFerguson/gratitude)


A simple Ruby wrapper for the [Gittip API](https://github.com/gittip/www.gittip.com#api).

**Note**: This gem is currently under development and is not ready for use in a production environment. A stable version is planned for v0.1.0. Please follow the [Changelog](CHANGELOG.md) to check the status of the project.


# Installation
--------------
    gem install gratitude

# Usage
-------
The gratitude gem has four different components that interact with different aspects of the Gittip API. They are as follows:

* [Paydays](#paydays-source-code)
* [Statistics](#statistics)
* [Profile](#profile-source-code)
* [Tips](#tips)

##Paydays ([source code](https://github.com/JohnKellyFerguson/gratitude/blob/master/lib/gratitude/payday.rb))

The Gittip API provides access to the historical data of all its paydays. To retrieve this information, simply use the following command:

	Gratitude::Payday.all

The above will return an array of Payday objects. Each Payday object responds to the following methods:

* `ach_fees_volume`
* `ach_volume`
* `charge_fees_volume`
* `charge_volume`
* `number_of_achs`
* `number_active`
* `number_of_failing_credit_cards`
* `number_of_missing_credit_cards`
* `number_of_charges`
* `number_of_participants`
* `number_of_tippers`
* `number_of_transfers`
* `transfer_volume`
* `ts_end`
* `ts_start`

You can then iterate through this array of payday objects to persist them to a database or get whatever information you neeed.

	paydays = Gratitude::Payday.all
	paydays.each do |payday|
	  # get whatever information you want from the payday object
	  # using the above mentioned methods.
	end

Finally, if you just want to get the most recent payday, you can do so by using:

	Gratitude::Payday.most_recent

##Statistics
* **TODO:** Implement Gittip's Statistics API into gratitude.

##Profile ([source code](https://github.com/JohnKellyFerguson/gratitude/blob/master/lib/gratitude/profile.rb))

The Profile aspect of the Gittip API allows you to get the public profile information of any Gittip user. To do so, just pass their username as an initialization argument to the `Gratitude::Profile` class.

	Gratitude::Profile.new("johnkellyferguson")

The following will retrieve the public profile of the above user. You can then access all of the different information with the following methods:

* `avatar_url`
* `bitbucket_api_url`
  * returns the user's bitbucket api url if they have connected a bitbucket account.
  * otherwise, returns `nil`.
* `bitbucket_username`
  * returns the user's bitbucket username if they have connected a bitbucket account.
  * otherwise, returns `nil`.
* `bountysource_api_url`
  * returns the user's bountysource api url if they have connected a bountysource account.
  * otherwise, returns `nil`.
* `bountysource_username`
  * returns the user's bountysource username if they have connected a bountysource account.
  * otherwise, returns `nil`.
* `github_api_url`
  * returns the user's github api url if they have connected a github account.
  * otherwise, returns `nil`.
* `github_username`
  * returns the user's github username if they have connected a github account.
  * otherwise, returns `nil`.	
* `twitter_api_url`
  * returns the user's twitter api url if they have connected a twitter account.
  * otherwise, returns `nil`.
* `amount_giving`
  * returns the amount (as a float) the user has pledged to give this week.
* `amount_receiving`
  * returns an estimate as a float of what the given user is expected to receive this week.
* `goal`
  * returns the amount (as a float) that the user would like to receive weekly if the user set such a goal.
  * returns `nil` if the user has defined themselves as a patron or has not set a specific monetary goal.
* `number`
  * returns either `'singular'` or `'plural'` representing the type of account the user has.
* `id`
  * the id of the user.

**TODO:** Implement the `my_tip` method into the Profile section once client authentication is finished.

##Tips
* **TODO:** Implement Gittip's Statistics API into gratitude.


#### Copyright and License

Copyright John Kelly Ferguson and Contributors, 2013

[MIT Licence](LICENSE.txt)



