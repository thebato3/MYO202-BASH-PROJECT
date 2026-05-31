#!/bin/bash

# Nebi Batuhan Atmaca
# 2420171022
# https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=bx1hL8oZ9G
# https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=ax1hrL0PzV
# https://credsverse.com/credentials/f884d8c5-41f9-4424-8f72-c0a8c0496dc8

LOGFILE="report.log"

echo "$(date -Iseconds) Script Baslatildi" > "$LOGFILE"

read -s -p "Parola giriniz: " PAROLA
echo ""

echo "===================================" >> "$LOGFILE"
echo "DONANIM BILGILERI" >> "$LOGFILE"
echo "===================================" >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "CPU BILGISI" >> "$LOGFILE"

if command -v wmic >/dev/null 2>&1
then
    wmic cpu get name >> "$LOGFILE"
else
    powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name" >> "$LOGFILE"
fi

echo "" >> "$LOGFILE"
echo "RAM BILGISI" >> "$LOGFILE"

powershell -Command "Get-CimInstance Win32_PhysicalMemory | Select Capacity" >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "ANAKART BILGISI" >> "$LOGFILE"

powershell -Command "Get-CimInstance Win32_BaseBoard | Select Manufacturer,Product" >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "DISK UUID" >> "$LOGFILE"

powershell -Command "Get-CimInstance Win32_DiskDrive | Select SerialNumber" >> "$LOGFILE"

echo "" >> "$LOGFILE"
echo "MAC ADRESLERI" >> "$LOGFILE"

getmac >> "$LOGFILE"

gpg --batch \
--yes \
--passphrase "$PAROLA" \
--cipher-algo AES256 \
--symmetric \
"$LOGFILE"

rm -f "$LOGFILE"

echo ""
echo "Sifreleme tamamlandi."
echo "report.log.gpg olusturuldu."
```
