# Gizmos

Rails Engine for inline editing with RailsAdmin


## Rails Setup

`Gemfile.rb`:

```ruby
gem 'seorel'

# the edge version can be had using:
# gem 'seorel', github: 'carloscortegagna/gizmos'
```

`Console`:
```bash
% bundle install
% bundle exec rake db:migrate
```


## Default configuration options

```bash
% rails generate gizmos:config
```

Will generate the `gizmos_config.rb` initializer to customize the default values:

```ruby
Gizmos.configure do |config|
  # config.admin_scope = current_user
end
```


## Contributing
Submitting a Pull Request:

1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Implement your feature or bug fix.
4. Add, commit, and push your changes.
5. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## This project rocks and uses MIT-LICENSE.

Copyright 2014 Carlo Scortegagna
