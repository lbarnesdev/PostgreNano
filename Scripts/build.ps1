$items = 'C:\pgsql\doc','C:\pgsql\include','C:\pgsql\pgadmin*','C:\pgsql\StackBuilder'

Expand-Archive '.\postgresql-11.4.zip' -DestinationPath 'C:\'
Copy-Item '.\vcruntime140.dll' -Destination 'C:\pgsql\bin\.'
Copy-Item '.\Scripts\build.ps1' -Destination 'C:\entrypoint.ps1'

foreach($item in $items){
    Remove-Item -Recurse -Force -Path $item;
}