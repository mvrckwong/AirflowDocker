# Getting the base image
FROM apache/airflow:2.7.1

# Copying the requirements
COPY requirements.txt /opt/requirements.txt

# Upgrade the latest pip
RUN pip install --no-cache-dir --upgrade pip

# Install the latest dependencies
RUN pip install --no-cache-dir -r /opt/requirements.txt

# Copy the token retrieval script into the image
COPY retrieve_token.sh /opt/retrieve_token.sh

# Set the entry point to the script
RUN ["/opt/retrieve_token.sh"]