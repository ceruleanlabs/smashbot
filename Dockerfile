FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app
COPY . ./

# Restore packages as separate layer
RUN dotnet restore

# Start code analysis
# TODO: add version /v:<version>
RUN dotnet tool install --global dotnet-sonarscanner --version 4.5.0
RUN dotnet-sonarscanner begin \
        /d:${SONAR_PROJECT} \
        /k:sonar.organization=${SONAR_ORG} \
        /d:sonar.sources=. \
        /d:sonar.host.url=${SONAR_HOST} \
        /d:sonar.login=${SONAR_TOKEN}

# Run tests
RUN dotnet test

# Build
RUN dotnet publish src/SmashBot.csproj -c Release -o out

# Finish code analysis
RUN dotnet-sonarscanner end \
        /d:sonar.login=${SONAR_TOKEN}

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/src/out .
ENTRYPOINT ["dotnet", "SmashBot.dll"]
