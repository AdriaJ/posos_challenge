FROM python:3.6-stretch

# set the working directory for containers
WORKDIR /app
COPY ./trainer/requirements_trainer.txt .

# Installing python dependencies
RUN pip install --no-cache-dir -r requirements_trainer.txt


# Running Python Application
CMD ["python3", "train_model.py"]
