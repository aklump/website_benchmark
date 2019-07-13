# Website Benchmark

![website_benchmark](images/{{ __i-instance }}.jpg)

## Summary

Generate quick reports based on page-load times for your website.

**Visit <https://aklump.github.io/website_benchmark> for full documentation.**

## Quick Start

- Install in your repository root using `cloudy pm-install aklump/website_benchmark`
- Open _bin/config/website_benchmark.yml_ and modify as needed.

## Requirements

You must have [Cloudy](https://github.com/aklump/cloudy) installed on your system to install this package.

## Installation

The installation script above will generate the following structure where `.` is your repository root.

    .
    ├── bin
    │   ├── website_benchmark -> ../opt/website_benchmark/website_benchmark.sh
    │   └── config
    │       └── website_benchmark.yml
    ├── opt
    │   ├── cloudy
    │   └── aklump
    │       └── website_benchmark
    └── {public web root}

    
### To Update

- Update to the latest version from your repo root: `cloudy pm-update aklump/website_benchmark`

## Configuration Files

| Filename | Description | VCS |
|----------|----------|---|
| _website_benchmark.yml_ | Configuration shared across all server environments: prod, staging, dev  | yes |

### Custom Configuration

* lorem
* ipsum

## Usage

* To see all commands use `./bin/website_benchmark`

## Contributing

If you find this project useful... please consider [making a donation](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4E5KZHDQCEUV8&item_name=Gratitude%20for%20).
