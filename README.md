# Bandwidth Monitor Script

Bu betik, belirtilen ağ arayüzü üzerinden geçen veri trafiğini izlemek için kullanılan bir Bash betiğidir. RX (gelen) ve TX (giden) veri miktarını belirli bir aralıkla kontrol eder ve belirlenen bir eşik değeri aştığında bir e-posta bildirimi gönderir.

## Özellikler

- Belirlenen arayüzdeki RX ve TX hızlarını ölçer.
- Eşik değeri aşıldığında otomatik e-posta bildirimi gönderir.
- Çalışma sırasında arayüz ve bant genişliği kullanımını konsolda gösterir.

## Gereksinimler

- Linux işletim sistemi
- `mail` komutu için gerekli olan `mailutils` (veya benzeri) paketinin kurulu olması gerekir.

## Kurulum

Betiği kullanmadan önce, sisteminizde `mail` komutunun düzgün bir şekilde çalıştığından emin olun. `mailutils` paketini aşağıdaki komut ile kurabilirsiniz:

```bash
sudo apt-get install mailutils
```

## Kullanım

Betiği çalıştırmadan önce, betik içindeki bazı değişkenleri (örneğin, `ARAYUZ`, `ARALIK`, `ESIK_DEGERI` ve `alici` e-posta adresi) kendi ihtiyaçlarınıza göre ayarlayın.

Betiği çalıştırmak için:

```bash
chmod +x bandwidth_monitor.sh
./bandwidth_monitor.sh
```

## Ayarlar

- `ARAYUZ`: İzlemek istediğiniz ağ arayüzünü belirtir. Örneğin, `eth0`.
- `ARALIK`: RX ve TX değerlerinin ne sıklıkla kontrol edileceğini belirten süre (saniye cinsinden).
- `ESIK_DEGERI`: E-posta bildiriminin tetikleneceği RX veya TX değerinin eşiği (byte cinsinden).
