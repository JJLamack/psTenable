Remove-Module psTenable -ErrorAction SilentlyContinue
Copy-Item H:\Projects\psTenable\psTenable\ H:\WindowsPowerShell\Modules\ -Force -Recurse
Import-Module psTenable