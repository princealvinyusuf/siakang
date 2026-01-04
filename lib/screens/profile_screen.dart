import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notifyReports = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(title: 'About'),
                            const SizedBox(height: 12),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  SwitchListTile(
                                    title: const Text(
                                      'Notify when new report is published',
                                    ),
                                    value: notifyReports,
                                    onChanged: (val) =>
                                        setState(() => notifyReports = val),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent,
                                    ),
                                    child: ExpansionTile(
                                      leading: const Icon(Icons.info_outline),
                                      title: const Text('About SIPKer'),
                                      subtitle: const Text('by PASKER.ID'),
                                      childrenPadding:
                                          const EdgeInsets.fromLTRB(
                                        16,
                                        0,
                                        16,
                                        12,
                                      ),
                                      children: const [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Tentang SIPKer',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'SIPKer (Sistem Informasi Pasar Kerja) adalah platform digital nasional yang dikembangkan untuk menyediakan informasi pasar kerja yang akurat, terintegrasi, dan berbasis data bagi masyarakat, dunia usaha, dan pemerintah.',
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'SIPKer berfungsi sebagai pusat pengelolaan dan analisis data ketenagakerjaan Indonesia, yang mencakup informasi lowongan kerja, karakteristik tenaga kerja, kebutuhan industri, tren pasar kerja, serta proyeksi ketenagakerjaan di tingkat nasional maupun daerah.',
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Melalui SIPKer, pemerintah berupaya mendukung:',
                                        ),
                                        SizedBox(height: 8),
                                        _Bullet(
                                          text:
                                              'pencari kerja dalam memperoleh informasi dan peluang kerja yang relevan,',
                                        ),
                                        _Bullet(
                                          text:
                                              'dunia usaha dalam menemukan tenaga kerja sesuai kebutuhan,',
                                        ),
                                        _Bullet(
                                          text:
                                              'perumusan kebijakan ketenagakerjaan yang berbasis bukti dan data.',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 0),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent,
                                    ),
                                    child: ExpansionTile(
                                      leading: const Icon(
                                        Icons.privacy_tip_outlined,
                                      ),
                                      title: const Text('Privacy & Terms'),
                                      subtitle: const Text(
                                        'Read how we protect your data',
                                      ),
                                      childrenPadding:
                                          const EdgeInsets.fromLTRB(
                                        16,
                                        0,
                                        16,
                                        12,
                                      ),
                                      children: const [
                                        SelectableText(
                                          _privacyTermsText,
                                          style: TextStyle(height: 1.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Copyright © 2026 Pusat Pasar Kerja Indonesia',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: TextStyle(
              height: 1.4,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

const String _privacyTermsText = '''
Pusat Pasar Kerja (“Kami”) mengoperasikan Portal Pasker ID.

Kami menggunakan data Anda dengan tujuan untuk menyediakan dan memberikan Layanan Aplikasi yang optimal. Dengan menggunakan layanan kami, Anda telah menyetujui pengumpulan dan penggunaan Informasi dari Anda sesuai dengan Kebijakan Privasi dan Ketentuan yang kami terapkan.


Pengumpulan dan Penggunaan Informasi

Kami mengumpulkan beberapa jenis informasi yang berbeda untuk berbagai tujuan untuk menyediakan dan meningkatkan layanan kami kepada Anda.


JENIS DATA YANG DIKUMPULKAN

1. Data Pribadi

Saat menggunakan Layanan kami, kami dapat meminta Anda untuk memberikan kami informasi identitas pribadi tertentu yang dapat digunakan untuk menghubungi atau mengidentifikasi Anda (“Data Pribadi”). Informasi Identitas pribadi dapat mencakup, tetapi tidak terbatas pada :

a. Nomor Induk Kependudukan,
b. Alamat Email,
c. Nama depan dan Nama Belakang,
d. Nomor Telepon,
e. Cookie dan Data Penggunaan,
f. Nama Perusahaan dan Alamat Perusahaan.

2. Data Penggunaan

Kami juga mengumpulkan informasi yang dikirimkan browser Anda setiap kali Anda mengunjungi Layanan kami atau saat Anda mengakses Layanan oleh atau melalui perangkat seluler (“Data Penggunaan “).

Data Penggunaan ini dapat mencakup informasi seperti alamat Protokol Internet Komputer Anda (misalnya alamat IP), jenis peramban, versi peramban, laman layanan kami yang Anda kunjungi waktu, dan tanggal kunjungan Anda, waktu yang , dihabiskan untuk laman tersebut, unit pengindentifikasi perangkat dan data diagnostic lainnya.

Saat Anda mengakses layanan oleh atau melalui perangkat seluler, Data penggunaan ini dapat mencakup Informasi seperti jenis perangkat seluler yang Anda gunakan, ID unik perangkat Seluler Anda, alamat IP perangkat seluler Anda, system operasi seluler Anda, jenis peramban internet seluler yang Anda gunakan, pengenal perangkat unik, dan data diagnostic lainnya.

3. Data Pelacakan & Cookie

Kami menggunakan cookie dan teknologi pelacakan serupa untuk melacak aktivitas di Layanan kami dan menyimpan informasi tertentu,

Cookie adalah file dengan sejumlah kecil data yang mungkin pengidentifikasi unik anonym. Cookie dikirim ke browser Anda dari situs Web dan disimpan di perangkat Anda. Teknologi pelacakan juga digunakan adalah beacon, tag, dan skrip untuk mengumpulkan dan melacak informasi dan untuk meningkatkan dan menganalisis Layanan kami.

Anda dapat menginstruksikan browser Anda menolak semua cookie atau untuk menunjukan saat cookie sedang dikirim. Namun jika anda tidak menerima cookie, Anda mungkin tidak dapat menggunakan beberapa bagian dari Layanan Kami.

Contoh Cookie yang kami gunakan :

a. Cookie Sesi. Kami menggunakan Cookie Sesi untuk mengoperasikan Layanan kami.
b. Cookie Prefensi, Kami menggunakan Cookies Prefensi untuk mengingat prefensi Anda dan berbagai pengaturan.
c. Cookie Keamanan, Kami menggunakan Cookie Keamanan untuk tujuan keamanan.

4. Penggunaan Data

Kami menggunakan data yang dikumpulkan untuk berbagi tujuan :

a. Untuk menyediakan dan memelihara Layanan
b. Untuk memberitahukan Anda tentang perubahan di dalam pelayanan kami.
c. Untuk memungkinkan Anda berpartisipasi dalam fitur interaktif dari Layanan kami ketika Anda memilih untuk melakukannya.
d. Untuk memberikan layanan dan dukungan pelanggan
e. Untuk memberikan Analisis atau Informasi berharga agar kami dapat meningkatkan Layanan
f. Untuk memantau penggunan Layanan
g. Untuk mendeteksi, mencegah, dan mengatasi masalah teknis.

5. Transfer Data

Informasi Anda, termasuk Data Pribadi, dapat ditransfer ke- dan dipelihara di- computer yang terletak di luar Negara bagian Anda, provinsi, Negara atau yuridiksi pemerintah lainny dimana undang- undang perlindungan data dapat berbeda dari yang berasal dari yurisdiksi Anda.

Jika Anda Berada di Luar Indonesia dan memilih untuk memberikan informasi kepada kami, harap dicatat bahwa kami mentransfer data, termasuk Data Pribadi, ke Indonesia dan memproses di sana.

Persetujuan Anda terhadap Kebijakan Privasi ini diikuti dengan penyerahan atas informasi tersebut merupakan persetujuan Anda untuk transfer.

Kami akan mengambil semua langkah yang diperlukan secara wajar untuk memastikan bahwa data Anda diperlakukan dengan aman dan sesuai dengan Kebijakan Privasi. Kami tidak akan mengalihkan Data Pribadi Anda ke Organisasi atau Negara kecuali ada control yang memadai serta keamanan atas data dan informasi pribadi lainya.


PENGUMPULAN DATA

1. Persyaratan Hukum

Pusat Pasar Kerja dapat mengungkapkan Data Pribadi Anda Dengan Iktikad baik bahwa tindakan tersebut diperlukan untuk:

a. Untuk mematuhi kewajiban hukum.
b. Untuk melindungi dan membela hak atau milik Pusat Pasar Kerja
c. Untuk mencegah atau menyelidiki kemungkinan kesalahan sehubungan dengan Layanan.
d. Untuk melindungi keamanan pribadi pengguna Layanan atau public
e. Untuk melindungi terhadap tanggungjawab hukum.

2. Kemanan Data

Kemananan data Anda penting bagi kami, tetapi ingat bahwa tidak ada metode transmisi melalui internet, atau metode penyimpanan elektronik yang memiliki keamanan 100%. Meskipun kami berusaha menggunakan sarana yang dapat diterima secara komersial untuk melindungi Data Pribadi Anda, Kami tidak dapat menjamin keaman secara mutlak.

3. Penyedia Layanan

Kami dapat mempekerjakan perusahaan dan individu pihak ketiga untuk memfasilitasi Kami, untuk melakukan layanan terkait Layanan atau untuk membantu kami dalam menganalisis bagaimanana Layanan kami digunakan.

Pihak ketiga ini memiliki akses ke Data Pribadi Anda hanya untuk melakukan tugas ini atas nama kami dan berkewajiban untuk tidak mengungkapkan atau menggunakan untuk tujuan lain


ANALYSTIC

Google Analystic adalah layanan analis web yang ditawarkan oleh google yang melacak dan melaporkan lalu lintas situs web. Google menggunakan data yang dikumpulkan untukmelacak dan memantau penggunaan Layanan Kami. Data ini dibagikan dengan layanan google lainya. Google dapat menggunakan data jyang dikumpulkan untuk mengontekstualisasikan dan mempersonalisasi iklan dari jaringan periklananya sendiri.

Untuk informasi lebih lanjut tentang praktik privasi Google, kunjungi halaman web Privasi Google & ketentuan : https://police.google.com/privacy?h!=id


TAUTAN KE SITUS

Layanan Lain kami mungkin berisi tautan ke situs lain yang tidak dioperasikan oleh kami. Jika Anda Mengklik tautan pihak ketiga, Anda akan diarahkan kesitus pihak ketiga tersebut. Kami sangat menyarankan Anda untuk meninjau Kebijakan Privasi dari setiap situs yang Anda kunjungi.

Kami tidak memiliki kendali atas dan tidak bertanggung jawab atas konten, kebijakan privasi, atau praktik dari situs atau layanan pihak ketiga mana pun.


PRIVASI ANAK-ANAK

Layanan Kami tidak ditujukan kepada siapa pun yang berusia dibawah 15 tahun (“Anak-Anak”)

Kami tidak dengan sengaja mengumpulkan informasi identifikasi pribadi dari siapa pun yang berusia dibawah 15 tahun. Jika Anda adalah orang tua atau wali dan Anda sadar bahwa Anak-Anak Anda telah memberi kami Data Pribadi, silahkan hubungi kami. Jika Kami mengetahui bahwa kami telah mengumpulkan Data Pribadi dari anak-anak tanpa verifikasi izin orang tua, kami mengambil langkah-langkah untuk menghapus informasi tersebut dari server kami.


Perubahan Atas Kebijakan Privasi ini

Kami dapat memperbaharui kebijakan Privasi kami dari waktu ke waktu. Kami akan memberi tahu anda tentang perubahan apa pun dengan memposting kebijakan Privasi baru di halaman ini. Kami akan memberitahu Anda melalui email dan pemberitahuan yang menonjol di layanan kami, sebelum perubahan menjadi efektif dan memperbarui “tanggal efektif“ di bagian atas kebijakan Privasi ini. Anda untuk meninjau Kebijakan Privasi ini secara berkala untuk setiap perubahan. Perubahan pada kebijakan Privasi ini efektif ketika mereka diposting dihalaman ini.

Jika Anda memiliki pertanyaan atau saran mengenai layanan Pasker ID, Silahkan Hubungi

Pusat Pasar Kerja

Kementerian KetenagaKerjaan Republik Indonesia
''';

