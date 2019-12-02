FROM python:3.6-stretch

EXPOSE 4002

# install build utilities
RUN apt-get update && \
	apt-get install -y gcc make apt-transport-https ca-certificates build-essential

# check our python environment
RUN python3 --version
RUN pip3 --version

# COPY requirements_api.txt /app
# COPY model_svm /app
# COPY vectorizer /app
# COPY run_api.py /app

# set the working directory for containers
WORKDIR  /app
COPY ./api/requirements_api.txt .

RUN pip install --no-cache-dir -r requirements_api.txt

CMD ["python3", "run_api.py"]