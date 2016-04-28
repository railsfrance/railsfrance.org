# railsfrance.org [![Build Status](https://secure.travis-ci.org/railsfrance/railsfrance.org.png)](http://travis-ci.org/railsfrance/railsfrance.org) [![Code Climate](https://codeclimate.com/github/railsfrance/railsfrance.org.png)](https://codeclimate.com/github/railsfrance/railsfrance.org)

[railsfrance.org](http://www.railsfrance.org) is the French Ruby on Rails community website.

This Git repository is the current Rails application of railsfrance.org.

> **Before starting work on the project please read [contributing guidelines](CONTRIBUTING.md)**

## Installation

railsfrance.org is built on the top of Rails 3.2.

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

    rake spec

## Thanks to

[Laurent Noblet](https://twitter.com/#!/LaurentNoblet) for the design and everyone on this [list](http://github.com/railsfrance/railsfrance.org/contributors) !

## License

Copyright (C) 2011  Aylic Petit

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License v3 as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

See the LICENSE file for the full license.
