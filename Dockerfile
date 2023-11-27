######################################################################
                      #stage 1
######################################################################
#Base image
FROM python:3.9 AS backend-builder

# Location of storage within the container
WORKDIR /app

# Copy code from your locate file systen into the container directory
COPY backend/requirements.txt ./

#Get the application binaries and compile the application
RUN pip install --no-cache-dir -r requirements.txt

####################################################################
                   #stage 2
####################################################################

#Get a smaller base image
FROM python:3.9-slim-buster

# Location of storage within the container
WORKDIR /app

RUN pip install flask
# Copy the Artifacts from stage1 (code + dependecies compiled = Artifact)
COPY --from=backend-builder /app /app

EXPOSE 5000

CMD ["python","app.py"]
