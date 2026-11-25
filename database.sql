CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE pegawai (
    nip VARCHAR(15) PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50) NOT NULL,
    divisi VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20) NOT NULL,
    sisa_cuti INT DEFAULT 12
);

CREATE TABLE pengajuan_cuti (
    id_cuti SERIAL PRIMARY KEY,
    nip VARCHAR(15) REFERENCES pegawai(nip) ON DELETE CASCADE,
    jenis_cuti VARCHAR(50) NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    lama_hari INT NOT NULL,
    alasan TEXT NOT NULL,
    status_atasan VARCHAR(20) DEFAULT 'Menunggu',
    status_hrd VARCHAR(20) DEFAULT 'Menunggu'
);

ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE pegawai DISABLE ROW LEVEL SECURITY;
ALTER TABLE pengajuan_cuti DISABLE ROW LEVEL SECURITY;

INSERT INTO users (username, password, role) VALUES
('hrd_sains', '12345', 'hrd'),
('atasan_sains', '12345', 'atasan'),
('pegawai_sains', '12345', 'pegawai');

INSERT INTO pegawai (nip, nama_lengkap, jabatan, divisi, email, no_hp, sisa_cuti) VALUES
('SGK-001', 'Indra Yunar Maa', 'Direktur Operasional', 'Manajemen', 'indra.maa@sainsgroup.co.id', '081234560001', 12),
('SGK-002', 'Maria Goreti Bria', 'Manajer HRD', 'SDM & Umum', 'maria.bria@sainsgroup.co.id', '081234560002', 12),
('SGK-003', 'Yohanes Baptista Leki', 'Kepala Divisi Perencanaan', 'Perencanaan', 'yohanes.leki@sainsgroup.co.id', '081234560003', 10),
('SGK-004', 'Fransiskus Xaverius Tefa', 'Konsultan Senior Bisnis', 'Bisnis & Proyek', 'frans.tefa@sainsgroup.co.id', '081234560004', 12),
('SGK-005', 'Elisabeth Ndun', 'Staf Keuangan', 'Keuangan', 'elisabeth.ndun@sainsgroup.co.id', '081234560005', 11),
('SGK-006', 'Petrus Kanisius Kelen', 'Analis Proyek Pemerintah', 'Bisnis & Proyek', 'petrus.kelen@sainsgroup.co.id', '081234560006', 12),
('SGK-007', 'Agustina Rambu Podu', 'Perencana Wilayah', 'Perencanaan', 'agustina.podu@sainsgroup.co.id', '081234560007', 9),
('SGK-008', 'Melkianus Benu', 'Konsultan Manajemen', 'Manajemen', 'melki.benu@sainsgroup.co.id', '081234560008', 12),
('SGK-009', 'Veronika Lomi', 'Administrasi Arsip', 'SDM & Umum', 'veronika.lomi@sainsgroup.co.id', '081234560009', 12),
('SGK-010', 'Stefanus Neno', 'Surveyor Lapangan', 'Perencanaan', 'stefanus.neno@sainsgroup.co.id', '081234560010', 8),
('SGK-011', 'Kornelis Taka', 'Konsultan Bisnis', 'Bisnis & Proyek', 'kornelis.taka@sainsgroup.co.id', '081234560011', 12),
('SGK-012', 'Yuliana Manek', 'Akuntan Pajak', 'Keuangan', 'yuliana.manek@sainsgroup.co.id', '081234560012', 12),
('SGK-013', 'Benediktus Dhae', 'Analis Data Proyek', 'Perencanaan', 'benediktus.dhae@sainsgroup.co.id', '081234560013', 10),
('SGK-014', 'Theresia Oematan', 'Staf Rekrutmen', 'SDM & Umum', 'theresia.oematan@sainsgroup.co.id', '081234560014', 12),
('SGK-015', 'Dominikus Sogen', 'Konsultan Teknik', 'Bisnis & Proyek', 'dominikus.sogen@sainsgroup.co.id', '081234560015', 11),
('SGK-016', 'Magdalena Kase', 'Staf Legal & Kontrak', 'Manajemen', 'magdalena.kase@sainsgroup.co.id', '081234560016', 12),
('SGK-017', 'Antonius Watu', 'Perencana Tata Ruang', 'Perencanaan', 'antonius.watu@sainsgroup.co.id', '081234560017', 12),
('SGK-018', 'Kristina Meko', 'Staf Administrasi Proyek', 'Bisnis & Proyek', 'kristina.meko@sainsgroup.co.id', '081234560018', 7),
('SGK-019', 'Paulus Riwu', 'IT Support & Sistem', 'SDM & Umum', 'paulus.riwu@sainsgroup.co.id', '081234560019', 12),
('SGK-020', 'Marselina Adu', 'Auditor Internal', 'Keuangan', 'marselina.adu@sainsgroup.co.id', '081234560020', 12),
('SGK-021', 'Ignatius Bau', 'Konsultan Kebijakan Publik', 'Manajemen', 'ignatius.bau@sainsgroup.co.id', '081234560021', 12),
('SGK-022', 'Dorotea Tukan', 'Asisten Perencana', 'Perencanaan', 'dorotea.tukan@sainsgroup.co.id', '081234560022', 10),
('SGK-023', 'Lambertus Hurek', 'Koordinator Lapangan', 'Bisnis & Proyek', 'lambertus.hurek@sainsgroup.co.id', '081234560023', 12),
('SGK-024', 'Rosalia Fanggidae', 'Sekretaris Eksekutif', 'Manajemen', 'rosalia.fanggidae@sainsgroup.co.id', '081234560024', 12),
('SGK-025', 'Nikolaus Seran', 'Analis Anggaran', 'Keuangan', 'nikolaus.seran@sainsgroup.co.id', '081234560025', 9),
('SGK-026', 'Helena Ga', 'Staf Humas & Kemitraan', 'Bisnis & Proyek', 'helena.ga@sainsgroup.co.id', '081234560026', 12),
('SGK-027', 'Vinsensius Bere', 'Drafter CAD & GIS', 'Perencanaan', 'vinsensius.bere@sainsgroup.co.id', '081234560027', 12),
('SGK-028', 'Katarina Lado', 'Staf Logistik & Aset', 'SDM & Umum', 'katarina.lado@sainsgroup.co.id', '081234560028', 11),
('SGK-029', 'Gregorius Nahak', 'Konsultan Keuangan Daerah', 'Keuangan', 'gregorius.nahak@sainsgroup.co.id', '081234560029', 12),
('SGK-030', 'Susana Djami', 'Analis SDM', 'SDM & Umum', 'susana.djami@sainsgroup.co.id', '081234560030', 12),
('SGK-031', 'Sebastianus Klau', 'Konsultan Infrastruktur', 'Perencanaan', 'sebastianus.klau@sainsgroup.co.id', '081234560031', 12),
('SGK-032', 'Bernadeta Nggadas', 'Staf Pengadaan', 'Bisnis & Proyek', 'bernadeta.nggadas@sainsgroup.co.id', '081234560032', 10),
('SGK-033', 'Silvester Taolin', 'Estimator Biaya Proyek', 'Keuangan', 'silvester.taolin@sainsgroup.co.id', '081234560033', 12),
('SGK-034', 'Anastasia Modok', 'Staf Dokumentasi', 'SDM & Umum', 'anastasia.modok@sainsgroup.co.id', '081234560034', 12),
('SGK-035', 'Blasius Ulu', 'Konsultan Pengembangan UMKM', 'Bisnis & Proyek', 'blasius.ulu@sainsgroup.co.id', '081234560035', 12),
('SGK-036', 'Filomena Mau', 'Asisten Keuangan', 'Keuangan', 'filomena.mau@sainsgroup.co.id', '081234560036', 8),
('SGK-037', 'Bonifasius Lake', 'Ahli Lingkungan', 'Perencanaan', 'bonifasius.lake@sainsgroup.co.id', '081234560037', 12),
('SGK-038', 'Imelda Bano', 'Staf Pelayanan Klien', 'Manajemen', 'imelda.bano@sainsgroup.co.id', '081234560038', 12),
('SGK-039', 'Aloysius Kefi', 'Surveyor Topografi', 'Perencanaan', 'aloysius.kefi@sainsgroup.co.id', '081234560039', 11),
('SGK-040', 'Sisilia Haba', 'Staf Payroll & Gaji', 'Keuangan', 'sisilia.haba@sainsgroup.co.id', '081234560040', 12),
('SGK-041', 'Mateus Tallo', 'Konsultan Manajemen Risiko', 'Manajemen', 'mateus.tallo@sainsgroup.co.id', '081234560041', 12),
('SGK-042', 'Yosefina Bria', 'Analis Pasar', 'Bisnis & Proyek', 'yosefina.bria@sainsgroup.co.id', '081234560042', 12),
('SGK-043', 'Pius Siki', 'Teknisi Lapangan', 'Perencanaan', 'pius.siki@sainsgroup.co.id', '081234560043', 10),
('SGK-044', 'Esterina Manafe', 'Staf Kearsipan Digital', 'SDM & Umum', 'esterina.manafe@sainsgroup.co.id', '081234560044', 12),
('SGK-045', 'Gabriel Kore', 'Konsultan Pariwisata', 'Bisnis & Proyek', 'gabriel.kore@sainsgroup.co.id', '081234560045', 12),
('SGK-046', 'Regina Lede', 'Kasir & Perbendaharaan', 'Keuangan', 'regina.lede@sainsgroup.co.id', '081234560046', 12),
('SGK-047', 'Adrianus Mauk', 'Perencana Transportasi', 'Perencanaan', 'adrianus.mauk@sainsgroup.co.id', '081234560047', 9),
('SGK-048', 'Lusia Nitti', 'Staf Pengembangan SDM', 'SDM & Umum', 'lusia.nitti@sainsgroup.co.id', '081234560048', 12),
('SGK-049', 'Rafael Kono', 'Analis Kelayakan Proyek', 'Bisnis & Proyek', 'rafael.kono@sainsgroup.co.id', '081234560049', 12),
('SGK-050', 'Clara Boleng', 'Asisten Manajemen', 'Manajemen', 'clara.boleng@sainsgroup.co.id', '081234560050', 12);

INSERT INTO pengajuan_cuti (nip, jenis_cuti, tanggal_mulai, tanggal_selesai, lama_hari, alasan, status_atasan, status_hrd) VALUES
('SGK-007', 'Cuti Tahunan', '2026-12-01', '2026-12-03', 3, 'Urusan keluarga di Sumba', 'Disetujui', 'Menunggu'),
('SGK-010', 'Cuti Sakit', '2026-11-28', '2026-11-29', 2, 'Demam dan rawat jalan', 'Menunggu', 'Menunggu');