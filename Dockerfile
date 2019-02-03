FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app
COPY . ./

# Restore packages as separate layer
RUN dotnet restore

# Run tests
RUN dotnet test

# Copy everything else and build
RUN dotnet publish src/SmashBot.csproj -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/src/out .
ENTRYPOINT ["dotnet", "SmashBot.dll"]
