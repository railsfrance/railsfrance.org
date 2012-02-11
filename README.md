# railsfrance.org [![Build Status](https://secure.travis-ci.org/railsfrance/railsfrance.org.png)](http://travis-ci.org/railsfrance/railsfrance.org)

[railsfrance.org](http://www.railsfrance.org) is the French Ruby on Rails community website.

This Git repository is the the current Rails application of railsfrance.org.

## Installation

railsfrance.org is built on the top of Rails 3.1.

### Prerequisites

    sudo aptitude install redis-server
    sudo aptitude install libmagickwand-dev imagemagick
    sudo easy_install pygments

### Configuring

    git clone git://github.com/railsfrance/railsfrance.org.git
    cd railsfrance.org
    cp config/database.yml{.sample,}
    cp config/settings/development.yml{.sample,}
    bundle install
    rake db:setup

### Running the test suite

    rake test spec

## Contributing

If you have any questions, comments, or concerns, please use the Google Group instead of the GitHub issue tracker : http://groups.google.com/group/railsfrance

Contributions are welcome, here how to contribute :

#### 1. Clone the repo

    git clone git://github.com/railsfrance/railsfrance.org.git


#### 2. Run the tests

railsfrance.org uses Test:Unit and Capybara for testing.

    rake test

#### 3. Write some test-driven code

The tests are in `test/unit`, `test/functional` and `test/integration`.

#### 4. Create a pull request

If your code is tested and fits with the goals of the project, we will enjoy merging it !

#### Note

If you want your company / project logo to appear on the homepage slideshow please drop us an email to railsfrance.org[at]gmail[dot]com.

## Thanks to

Everyone on this [list](http://github.com/railsfrance/railsfrance.org/contributors) !

## License

Copyright (C) 2011  Aylic Petit

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License v3 as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

See the LICENSE file for the full license.

