# Feefi (alpha)
Feefi, a not-so-giant sized CLI for AWS Elastic Beanstalk

## Installation

    ```
    $ gem install feefi
    ```

## Usage

1. Create a the skeleton config directory and file.

    ```
    $ feefi setup
    ```

2. Edit ~/.feefi/feefi.conf and add your own Beanstalk apps(s) and AWS credentials
for each. 

3. You'll have to manage your own SSH keys for the moment using ssh-add
   or an agent for deploys and logging into systems.

4. Start using it!

    $ feefi help


## TODO

0. TESTS!
1. Add interactive add/delete of apps and credentials
2. Install git hooks into current repo
3. pem/key management
4. delete versions
5. zero-downtime deploy: create environment using template, incremnent
   name-number +1, deploy.
6. zero-downtime cut over - with DNS plugin too?


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


