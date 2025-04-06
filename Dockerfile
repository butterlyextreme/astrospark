RUN apt update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Dynamically set JAVA_HOME based on architecture
RUN if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then \
        echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64" >> /etc/profile.d/java.sh; \
    else \
        echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/profile.d/java.sh; \
    fi && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile.d/java.sh && \
    chmod +x /etc/profile.d/java.sh


# Verify installation
RUN java -version && javac -version
