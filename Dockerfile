FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

COPY src/AirportTicketBooking/AirportTicketBooking.csproj src/AirportTicketBooking/

RUN dotnet restore src/AirportTicketBooking/AirportTicketBooking.csproj

COPY src/AirportTicketBooking/ src/AirportTicketBooking/

RUN dotnet publish src/AirportTicketBooking/AirportTicketBooking.csproj -c Release -o /out --no-restore

FROM mcr.microsoft.com/dotnet/runtime:10.0

WORKDIR /app

COPY --from=build /out .

ENTRYPOINT ["dotnet", "AirportTicketBooking.dll"]