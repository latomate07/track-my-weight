# Use the official Ruby image from the Docker Hub
FROM ruby:3.4

# Set the working directory in the container
WORKDIR /app

# Install dependancies 
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm

# Copy the Gemfile and Gemfile.lock into the working directory
COPY app/Gemfile app/Gemfile.lock ./

# Install the dependencies
RUN bundle install

# Copy the rest of the application code into the working directory
COPY ./app ./

# Expose the port the app runs on
EXPOSE 3000

RUN chmod +x entrypoint.sh

# Install Node.js and Yarn
RUN npm install -g yarn

CMD ["rails", "server", "-b","0.0.0.0"]

