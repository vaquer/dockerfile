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
RUN apk add --no-cache python3 && \
    apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 && \
    apk del build-dependencies wget

# Default command
CMD ["python3"]
