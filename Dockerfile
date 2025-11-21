FROM eclipse-temurin:21-jdk-jammy

ARG ANDROID_SDK_TOOLS
ARG ANDROID_COMPILE_SDK
ARG ANDROID_BUILD_TOOLS

ENV ANDROID_SDK_ROOT=/opt/android-sdk

RUN apt-get --quiet update --yes && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN install -d $ANDROID_SDK_ROOT && \
    wget --output-document=$ANDROID_SDK_ROOT/cmdline-tools.zip \
    https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip && \
    unzip -d $ANDROID_SDK_ROOT/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools.zip && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/tools && \
    rm $ANDROID_SDK_ROOT/cmdline-tools.zip

ENV PATH=$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin:${ANDROID_SDK_ROOT}/platform-tools

RUN yes | sdkmanager --licenses || true && \
    sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" && \
    sdkmanager "platform-tools" && \
    sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
