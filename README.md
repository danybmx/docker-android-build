# Docker Android Build

A Docker image for building Android applications in CI/CD pipelines.

## Overview

This image provides a pre-configured environment with:
- Eclipse Temurin JDK 21
- Android SDK command-line tools
- Android platform tools and build tools

## Build Arguments

The following build arguments are required when building the image:

| Argument | Description | Example |
|----------|-------------|---------|
| `ANDROID_SDK_TOOLS` | Version of Android SDK command-line tools | `11076708` |
| `ANDROID_COMPILE_SDK` | Android SDK version to compile against | `34` |
| `ANDROID_BUILD_TOOLS` | Build tools version | `34.0.0` |

## Building the Image

```bash
docker build \
  --build-arg ANDROID_SDK_TOOLS=11076708 \
  --build-arg ANDROID_COMPILE_SDK=34 \
  --build-arg ANDROID_BUILD_TOOLS=34.0.0 \
  -t android-build .
```

## Usage

### In GitLab CI

```yaml
image: your-registry/android-build:latest

build:
  script:
    - ./gradlew assembleRelease
```

### In GitHub Actions

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: your-registry/android-build:latest
    steps:
      - uses: actions/checkout@v4
      - run: ./gradlew assembleRelease
```

### Local Development

```bash
docker run --rm -v $(pwd):/app -w /app android-build ./gradlew build
```

## Environment Variables

- `ANDROID_SDK_ROOT`: `/opt/android-sdk`
- `PATH`: Includes Android SDK tools and platform-tools

## License

MIT
