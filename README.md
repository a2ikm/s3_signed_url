# s3_signed_url

s3_signed_url generates signed URLs to get S3 objects.

Our backend is described in [official documetns](http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 's3_signed_url'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install s3_signed_url

Ands 3_signed_url requires `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION`.
So you should get them from AWS IAM, and set in `~/.aws/credentials` or environment variables.

## Usage


Generate URL for s3://examplebucket/test.txt:

    $ s3_signed_url s3://examplebucket/test.txt
    https://s3.amazonaws.com/examplebucket/test.txt?...

The generated uses HTTPS by default. To use HTTP, append `--no-secure` option:

    $ s3_signed_url s3://examplebucket/test.txt --no-secure
    http://s3.amazonaws.com/examplebucket/test.txt?...

And generated URLs expires in 15 minutes by default. If you want to set it manually, append `--expire` option with the number of seconds:

    $ s3_signed_url s3://examplebucket/test.txt --expire 1800
    https://s3.amazonaws.com/examplebucket/test.txt?...

If you want to upload a new file and generated a signed url for it, append `--upload` option with the path to file:

    $ s3_signed_url s3://examplebucket/test.txt --upload /path/to/test.txt
    https://s3.amazonaws.com/examplebucket/test.txt?...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/a2ikm/s3_signed_url/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
