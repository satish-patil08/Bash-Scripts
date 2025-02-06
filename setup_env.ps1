# Update System
Write-Host "Updating System..."

# Install Chocolatey if not already installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install IntelliJ IDEA Community Edition
choco install intellijidea-community -y

# Install Postman
choco install postman -y

# Install MongoDB Compass
choco install mongodb-compass -y

# Install Google Chrome
choco install googlechrome -y

# Install Java JDK
choco install openjdk --version=21 -y
$Env:JAVA_HOME = "C:\Program Files\OpenJDK\jdk-21"
[System.Environment]::SetEnvironmentVariable('JAVA_HOME', $Env:JAVA_HOME, [System.EnvironmentVariableTarget]::Machine)

# Install Maven
choco install maven -y
$Env:MAVEN_HOME = "C:\ProgramData\chocolatey\lib\maven\tools\apache-maven-3.8.5"
[System.Environment]::SetEnvironmentVariable('MAVEN_HOME', $Env:MAVEN_HOME, [System.EnvironmentVariableTarget]::Machine)

# Install DataGrip
choco install datagrip -y

# Restart System
Write-Host "Environment setup is complete. The system will restart in 30 seconds. Save your work."
Start-Sleep -Seconds 30
Restart-Computer -Force

