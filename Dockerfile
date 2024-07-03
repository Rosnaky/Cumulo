# Use the official Dart image as the base image for building
FROM dart:stable AS build

# Install build dependencies
RUN apt-get update && apt-get install -y \
  git \
  unzip \
  xz-utils \
  zip

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter \
  && /usr/local/flutter/bin/flutter doctor

# Set Flutter environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Check Flutter doctor output for diagnostics (Stage 1 check)
RUN flutter doctor

# Pre-download Flutter dependencies (Optional)
RUN flutter precache

# Accept Android licenses (Optional, consider automation)
RUN yes | flutter doctor --android-licenses

# Copy project files into the build container
COPY . /app

# Set working directory
WORKDIR /app

# Stage 2: Build the Flutter app (Separate stage for troubleshooting)
FROM build AS build-stage

# Check Flutter doctor output again (Stage 2 check)
RUN flutter doctor

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter app
RUN flutter build /app apk --release

# Use a minimal base image for the final image
FROM debian:stable-slim

# Copy the build output from the build stage
COPY --from=build-stage /app/build/app/outputs/flutter-apk/app-release.apk /app/app-release.apk

# Set the default command to display the built APK location
CMD ["echo", "Flutter build is located at /app/app-release.apk"]
