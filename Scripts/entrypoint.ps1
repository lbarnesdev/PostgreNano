$env:Path += ";C:\pgsql\bin"

if (-Not (Test-Path $env:PGDATA )){

    Write-Host "Data file not found at $env:PGDATA. Creating $env:PGDATA folder."
    New-Item $env:PGDATA -ItemType "directory"

}

if (-Not (Test-Path "$env:PGDATA\PG_Version")){
    
    New-Item C:\.pgpass -ItemType File
    Add-Content C:\.pgpass -Value $env:PGPASS
    Get-Content c:\.pgpass

    Write-Host "running initdb data: $env:PGDATA user: $env:POSTGRES_USER"
    Start-Process initdb -ArgumentList "-U $env:POSTGRES_USER -D $env:PGDATA -A md5 --pwfile=c:\.pgpass" -NoNewWindow -Wait

    $hba = Get-Content -Path "$env:PGDATA\pg_hba.conf"
    $hba[79] = "host`tall`t`tall`t`t0.0.0.0/0`t`tmd5"
    Set-Content -Path "$env:PGDATA\pg_hba.conf" -Value $hba

    Remove-Item c:\.pgpass
    
}
Write-Host starting postgres
Start-Process pg_ctl -ArgumentList "-U $env:POSTGRES_USER -l $env:PGLOG -o `"-h * -p 5432`" start"