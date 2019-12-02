FROM python:3.6-stretch

# install build utilities
RUN apt-get update && \
	apt-get install -y gcc make apt-transport-https ca-certificates build-essential

# check our python environment
RUN python3 --version
RUN pip3 --version

# set the working directory for containers
# WORKDIR  /usr/src/train_model
WORKDIR /app
COPY ./trainer/requirements_trainer.txt .
RUN ls -la .

# Installing python dependencies
#COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements_trainer.txt

# Copy all the files from the project’s root to the working directory
#COPY train_model.py .
#COPY data .



# Running Python Application
CMD ["python3", "train_model.py"]
