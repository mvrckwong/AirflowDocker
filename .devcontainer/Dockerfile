# Getting the base image
FROM apache/airflow:2.7.1

# Copying the requirements
COPY requirements.txt /opt/requirements.txt

# Upgrade the latest pip
RUN pip install --no-cache-dir --upgrade pip

# Install the latest dependencies
RUN pip install --no-cache-dir -r /opt/requirements.txt

# Copying the requirements
COPY auth.sh /etc/auth.sh

# Make the script executable
CMD ["chmod +x /etc/auth.sh"]

# Specify the command to run the script
ENTRYPOINT ["/bin/sh", "-c", "/etc/auth.sh"]