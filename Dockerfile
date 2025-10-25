FROM python:3.9-alpine3.13
LABEL maintainer="Jay Naik <jaynaik707@gmail.com>"

# Recommended python in docker. Output will not be buffered in console
ENV PYTHONUNBUFFERED 1

# Below sections copy requirements and app code. 
# Workdir sets default working directory, so app code can be referenced without full paths.
# expose port 8000
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
# Single command to avoid multiple image layers
# python -m venv /py --> Create virtual environment
# /py/bin/pip install --upgrade pip --> upgrade pip and install dependencies
# /py/bin/pip install -r /tmp/requirements.txt --> install dependencies
# rm -rf /tmp --> remove temporary files ( No extra dependencies. Light weight docker image)
# adduser --disabled-password --no-create-home django-user -->
# 
# Principle of least privilege:
# Avoid running as root - By default, Docker containers run as the root user (UID 0), which has full system privileges
# Minimize attack surface - If an attacker compromises your application, they only have the limited privileges of django-user, not root access
# Container security best practice - Running applications as non-root users is a widely recommended security practice
# The sequence in your Dockerfile is:
# Create the django-user
# Switch to django-user with USER django-user at the end

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

# Set the PATH environment variable. Dont need to specify full path to binaries
ENV PATH="/py/bin:$PATH"

# Run Django app as non-root user for security best practices
USER django-user
