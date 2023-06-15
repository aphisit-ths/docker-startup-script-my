# Log in to the Docker registry
$loginOutput = docker login 
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to log in to Docker registry. Aborting script."
    exit 1
}
Write-Host "Docker login successful."

# Start Docker service with elevated privileges
$processInfo = Start-Process -FilePath "wsl" -ArgumentList "sudo service docker start" -PassThru -Wait
if ($processInfo.ExitCode -ne 0) {
    Write-Host "Failed to start Docker service. Aborting script."
    exit 1
}
Write-Host "Docker service started successfully."

# Start PostgreSQL container
$containerStartOutput = docker container start postgres
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to start PostgreSQL container. Aborting script."
    exit 1
}
Write-Host "PostgreSQL container started successfully."

# Follow the logs of the PostgreSQL container
Write-Host "PostgreSQL container logs:"
docker container logs --follow postgres
