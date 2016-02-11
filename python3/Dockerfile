# mxabierto Python 3
# Base python3 installation
# Build:
#   docker build -t mxabierto/python3 .
# Usage:
#   docker run --rm -it mxabierto/python3

# Base image
FROM mxabierto/alpine

MAINTAINER bcessa <ben@pixative.com>

# Install python 3 and pip
RUN \
  apk-install \
    curl \
    python3 && \
  curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python3

# Default command
CMD ["python3"]
