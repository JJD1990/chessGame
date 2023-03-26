FROM ruby:3.1.2

# Update and install dependencies
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Create a directory for the app and set it as the working directory
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port and start the server
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-t", "5:5", "-p", "3000", "-e", "production"]
