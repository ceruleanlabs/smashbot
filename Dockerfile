FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app
COPY . ./

# Restore packages as separate layer
RUN dotnet restore

# Run tests
RUN dotnet test

# Run code analysis
RUN dotnet tool install --global dotnet-sonarscanner --version 4.5.0
RUN dotnet-sonarscanner \
  -Dsonar.projectKey=${SONAR_PROJECT} \
  -Dsonar.organization=${SONAR_ORG} \
  -Dsonar.sources=. \
  -Dsonar.host.url=${SONAR_HOST} \
  -Dsonar.login=${SONAR_TOKEN}

# Copy everything else and build
RUN dotnet publish src/SmashBot.csproj -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/src/out .
ENTRYPOINT ["dotnet", "SmashBot.dll"]
