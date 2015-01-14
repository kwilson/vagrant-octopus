$ErrorActionPreference = "Stop"

import-module servermanager
echo "Enabling .NET Framework"
add-windowsfeature as-net-framework