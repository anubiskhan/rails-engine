# Rails Engine
  An API developed in order for users to be able to easily retrieve data relevant to an online shop. Information includes analytics regarding:
  - Customers
  - Invoice Items
  - Invoices
  - Items
  - Merchants
  - Transactions

### Setup
In order to consume the API, take the following steps:
  1. Clone down this repository to your local machine
  ```
  git clone git@github.com:anubiskhan/rails_engine.git
  ```
  and head into the directory
  ```
  cd rails_engine/
  ```
  2. Run the following on your command line in order
  ```
  bundle install
  ```
  ```
  bundle update
  ```

  3. In order to get the database established run the following on your command line to make sure that you'll have all of the necessary gems
  ```
  rails db:{drop,create,migrate}
  ```

  4. Next, you'll want to populate the database. Run the following on your command line
  ```
  rake import:all
  ```
  5. Initialize the server by running the following on your command line
  ```
  rails s
  ```

### Utilization

Visit the url associated with locally hosted servers on your machine (traditionally http://localhost:3000/) and you're ready to get some data!

Endpoints can be found [here](http://backend.turing.io/module3/projects/rails_engine#check-ins-and-milestones).

#### Testing
Run ```rspec``` on the command line

#### Database

![](db/rails-engine-schema.png?raw=true)

#### Contributors

  [Adam Lusk](https://github.com/Vadlusk)  
  [Kelly Schroeder](https://github.com/anubiskhan)
#### Versions

factory_bot 4.8.2  
faker 1.8.7  
json 2.1.0  
pg (>= 0.18, < 2.0)  
rails (~> 5.1.6)  
rspec 3.7.1  
ruby 2.4.1p111  
shoulda-matchers 3.1.2  
simplecov 0.16.1  
