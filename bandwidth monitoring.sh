#!/bin/bash

ARAYUZ="eth0"
ARALIK=5
ESIK_DEGERI=1000000  # Örnek bir eşik değeri (byte cinsinden)

declare -A bant_genisligi_sonuclari

email_gonder() {
    alici="email@address.com"  # Alıcı e-posta adresi
    konu="Bant Genişliği Eşiği Aşıldı"
    icerik="Arayüz: $ARAYUZ, RX: $rx_hizi bytes/s, TX: $tx_hizi bytes/s"
    
    echo "$icerik" | mail -s "$konu" "$alici"
}

while true; do
    rx_eski=$(cat "/sys/class/net/$ARAYUZ/statistics/rx_bytes")
    tx_eski=$(cat "/sys/class/net/$ARAYUZ/statistics/tx_bytes")
    sleep $ARALIK
    rx_yeni=$(cat "/sys/class/net/$ARAYUZ/statistics/rx_bytes")
    tx_yeni=$(cat "/sys/class/net/$ARAYUZ/statistics/tx_bytes")

    rx_hizi=$(( ($rx_yeni - $rx_eski) / $ARALIK ))
    tx_hizi=$(( ($tx_yeni - $tx_eski) / $ARALIK ))

    mevcut_zaman=$(date +"%Y-%m-%d %H:%M:%S")
    bant_genisligi_sonuclari["$ARAYUZ"]="$mevcut_zaman: RX: $rx_hizi bytes/s, TX: $tx_hizi bytes/s"

    clear
    printf "%-15s %-30s\n" "Arayüz" "Bant Genişliği"
    printf "========================================\n"

    for arayuz in "${!bant_genisligi_sonuclari[@]}"; do
        sonuc="${bant_genisligi_sonuclari[$arayuz]}"
        printf "%-15s %-30s\n" "$arayuz" "$sonuc"
    done

    if [[ $rx_hizi -gt $ESIK_DEGERI || $tx_hizi -gt $ESIK_DEGERI ]]; then
        email_gonder
    fi
done
