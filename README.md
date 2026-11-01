# Ritim

Mobil uyumlu günlük kategori ve checkpoint planlayıcısı.

Yayın adresi: https://serhatserter.github.io/ritim/

## Özellikler

- Sınırsız günlük takvim
- Kategori, varsayılan checkpoint ve tekrar günü yönetimi
- Günlük checkpoint tamamlama ve ilerleme özeti
- Açık/koyu tema ve ana renk seçimi
- Misafir modu, JSON yedek ve Supabase hesap desteği
- Şimdi eşitle ile elle bulut eşitlemesi ve çakışma kontrolü

## Yayınlama

GitHub Settings → Pages → Source: GitHub Actions. main dalındaki güncellemeler .github/workflows/pages.yml üzerinden dist klasörünü yayımlar. Sunucu veya build bağımlılığı gerekmez. Tüm varlık yolları /ritim/ altında çalışacak şekilde görecelidir.

## Veri ve hesaplar

Misafir kayıtları tarayıcıda kalır. Her hesabın yerel kayıtları ayrıdır; misafir verileri otomatik yüklenmez. Bulut eşitlemesi elle yapılır. Gerçek kayıt/giriş için Supabase doğrulama adresi ve SMTP ayarları tamamlanmalıdır. dist/config.js yalnızca tarayıcıya açık publishable anahtar içerir. Gizli anahtar veya veritabanı şifresi depoya konulmamalıdır.

Çakışmada otomatik birleştirme yapılmaz; önce JSON yedeği alın. Aynı kaydın farklı cihazlarda eşzamanlı değiştirilmesi eşitlemeyi durdurur.

## Kontrol

node validate.cjs
node validate-appearance.cjs
node validate-cloud.cjs

Cloud testleri taklit istemci kullanır; gerçek kullanıcı oturumlarıyla uçtan uca test yerine geçmez.
