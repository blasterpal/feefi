# Feefi (alpha)
Feefi, a not-so-giant sized CLI for AWS Elastic Beanstalk

** Notice ** This project is dormant at the moment. Amazon's latest
CLI and other tools since gaining momentum, i.e. Docker, make this less important. I might
revisit as landscape changes.

## Installation

    $ gem install feefi

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
    
      ```
      $ feefi help
      ```

## TODO

### High: 

* Tests
* setup git deployment
* zero-downtime deploy: 
  - create environment using template
  -  incremnent name-number +1
  - create convention for environment names (env-app-vX), there is
    length limit on hostname.


## Low:

* Add interactive add/delete of apps and credentials
* pem/key management
* zero-downtime cut over - DNS swing


## Contributing

Fork it

Create your feature branch (`git checkout -b my-new-feature`)

Commit your changes (`git commit -am 'Add some feature'`)

Push to the branch (`git push origin my-new-feature`)

Create new Pull Request


