FROM python:3.6-stretch

# Use the passphrase
ARG password

# install build utilities
RUN apt-get update && \
	apt-get install -y gcc make apt-transport-https ca-certificates build-essential gnupg

# check our python environment
RUN python3 --version
RUN pip3 --version

# set the working directory for containers
WORKDIR  /usr/src/train_model



# Installing python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all the files from the project’s root to the working directory
COPY train_model.py .
COPY data .

RUN ls -la .

# Running Python Application
CMD ["python3", "train_model.py"]
