FROM posos-application_train

EXPOSE 4002

# set the working directory for containers
WORKDIR  /app
COPY ./api/requirements_api.txt .

RUN pip install --no-cache-dir -r requirements_api.txt

CMD ["python3", "run_api.py"]
