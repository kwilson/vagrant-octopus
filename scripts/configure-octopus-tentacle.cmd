echo Configuring Octopus tentacle instance...
cd "C:\Program Files\Octopus Deploy\Tentacle"
 
Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle\Tentacle.config" --console
Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
Tentacle.exe new-squid --instance "Tentacle" --console
Tentacle.exe configure --instance "Tentacle" --reset-trust --console
Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
Tentacle.exe configure --instance "Tentacle" --trust "5BF1B7093DBD1EB1B7000EA9769484541E44A8A9" --console

"netsh" advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
Tentacle.exe service --instance "Tentacle" --install --start --console

echo Finished configuring Octopus tentacle instance.