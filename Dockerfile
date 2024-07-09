# Stage 1: Build
FROM python:3.9 as builder
# Set the working directory to /app
WORKDIR /app
# Copy the program files into the container at /app
COPY app.py requirements.txt /app/
# Install the dependencies
RUN pip install --user --no-cache-dir -r requirements.txt
# Stage 2: Application Image
FROM python:latest
# Set the working directory to /app
WORKDIR /app
# Copy installed packages from the builder
COPY --from=builder /root/.local /root/.local
# Ensure scripts in .local are available
ENV PATH=/root/.local/bin:$PATH
# Copy the application files
COPY --from=builder /app /app

# Install pymongo module
RUN pip install pymongo

# Make port 3000 reachable
EXPOSE 3000
# This runs the server
CMD ["python", "app.py"]

