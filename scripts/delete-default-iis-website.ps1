$ErrorActionPreference = "Stop"
echo "Deleting the default IIS website..."

import-module webadministration
Stop-WebSite 'Default Web Site'
Remove-Website 'Default Web Site'

echo "Default website deleted."