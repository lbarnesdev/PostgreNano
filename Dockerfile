FROM mcr.microsoft.com/powershell:6.2.1-nanoserver-1803

#### set powershell for RUN
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

### copy required files into img
WORKDIR /RequiredSoftware
COPY RequiredSoftware .
COPY Scripts ./Scripts

### unzip postgresql
### copy c++ redistributable
### cleanup files
RUN .\Scripts\build.ps1


### run entry point
ENV PGDATA 'C:\Data'
ENV POSTGRES_USER 'postgres'
ENV PGPASS 'P@ssw0rd'
ENV PGLOG 'C:\pg_log'

ENTRYPOINT .\scripts\entrypoint.ps1

EXPOSE 5432
### default int powershell on docker run
CMD ["postgres.exe"]