# Use an official Node.js runtime as a base image to build the app
FROM node:20-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy the rest of the application code to the working directory
COPY . .

# Install dependencies
RUN npm install

# Build the React app for production
RUN npm run build

# Use nginx to serve the build folder
FROM nginx:alpine

# Copy the built app to the nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
