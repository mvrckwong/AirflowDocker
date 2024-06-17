# Getting the base image
FROM apache/airflow:2.7.1

# Copying the requirements files
COPY . /opt

# Upgrade the latest pip
RUN pip install --no-cache-dir --upgrade pip

# Install the latest dependencies
RUN pip install --no-cache-dir -r /opt/requirements.txt

# Set the entry point to the script
# RUN ["/opt/retrieve_token.sh"]