# danger-mobiledevops

A plugin that reports statistics to mobile devops dashboard.

## Installation
add this gem to your Gemfile:

    gem 'danger-mobiledevops', git: 'https://github.com/netguru/mobile_devops_danger'

## Usage

Add step to your CI setup that downloads google access json file and use its name like below:

```
mobiledevops.account_key_file_name = "service_access_file.json"
mobiledevops.post_to_dash("netugur-android-template", code_cov)
```

Alternatively you can upload JSON to specified URL:

```
mobiledevops.request_url = "https://example.com/put/json"
mobiledevops.upload(json_content)
```

## Configuration

* **request_url** - required, url to write to
* **request_method** - optional, default `:post`; possible values: `:post`, `:put` - method to use for request
* **bearer_token** - optional token; when provided request will add bearer authentication header

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
