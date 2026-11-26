const SUPABASE_URL = 'https://supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_g4hrPzEod4S3VuAn5lWoaA_Txfw0Vgn';

const NAMA_PEGAWAI = [
    "Indra Yunar Maa", "Maria Goreti Bria", "Yohanes Baptista Leki", "Fransiskus Xaverius Tefa", "Elisabeth Ndun",
    "Petrus Kanisius Kelen", "Agustina Rambu Podu", "Melkianus Benu", "Veronika Lomi", "Stefanus Neno",
    "Kornelis Taka", "Yuliana Manek", "Benediktus Dhae", "Theresia Oematan", "Dominikus Sogen",
    "Magdalena Kase", "Antonius Watu", "Kristina Meko", "Paulus Riwu", "Marselina Adu",
    "Ignatius Bau", "Dorotea Tukan", "Lambertus Hurek", "Rosalia Fanggidae", "Nikolaus Seran",
    "Helena Ga", "Vinsensius Bere", "Katarina Lado", "Gregorius Nahak", "Susana Djami",
    "Sebastianus Klau", "Bernadeta Nggadas", "Silvester Taolin", "Anastasia Modok", "Blasius Ulu",
    "Filomena Mau", "Bonifasius Lake", "Imelda Bano", "Aloysius Kefi", "Sisilia Haba",
    "Mateus Tallo", "Yosefina Bria", "Pius Siki", "Esterina Manafe", "Gabriel Kore",
    "Regina Lede", "Adrianus Mauk", "Lusia Nitti", "Rafael Kono", "Clara Boleng"
];
const DIVISI_LIST = ["Manajemen", "SDM & Umum", "Perencanaan", "Bisnis & Proyek", "Keuangan"];
const JABATAN_LIST = ["Konsultan Senior", "Manajer Divisi", "Analis Proyek", "Staf Administrasi", "Perencana Wilayah"];

const DATA_50_PEGAWAI = NAMA_PEGAWAI.map((nama, i) => {
    const nomor = String(i + 1).padStart(3, '0');
    return {
        nip: `SGK-${nomor}`,
        nama_lengkap: nama,
        jabatan: JABATAN_LIST[i % JABATAN_LIST.length],
        divisi: DIVISI_LIST[i % DIVISI_LIST.length],
        email: nama.toLowerCase().replace(/[^a-z]/g, '').slice(0, 12) + '@sainsgroup.co.id',
        no_hp: '081234560' + nomor,
        sisa_cuti: (i % 4 === 0) ? 10 : 12
    };
});

localStorage.setItem('db_pegawai', JSON.stringify(DATA_50_PEGAWAI));
if (!localStorage.getItem('db_cuti')) {
    localStorage.setItem('db_cuti', JSON.stringify([
        { id_cuti: 1, nip: 'SGK-007', jenis_cuti: 'Cuti Tahunan', tanggal_mulai: '2026-12-01', tanggal_selesai: '2026-12-03', lama_hari: 3, alasan: 'Urusan keluarga di Sumba', status_atasan: 'Disetujui', status_hrd: 'Menunggu' },
        { id_cuti: 2, nip: 'SGK-010', jenis_cuti: 'Cuti Sakit', tanggal_mulai: '2026-11-28', tanggal_selesai: '2026-11-29', lama_hari: 2, alasan: 'Demam dan rawat jalan', status_atasan: 'Menunggu', status_hrd: 'Menunggu' }
    ]));
}

const db = {
    from(table) {
        const headers = { 'apikey': SUPABASE_ANON_KEY, 'Authorization': 'Bearer ' + SUPABASE_ANON_KEY, 'Content-Type': 'application/json', 'Prefer': 'return=representation' };
        let url = `${SUPABASE_URL}/rest/v1/${table}?`;
        let orderStr = '';
        const builder = {
            select(cols = '*') { url += `select=${cols}&`; return builder; },
            eq() { return builder; },
            order(col, { ascending = true } = {}) { orderStr = `order=${col}.${ascending ? 'asc' : 'desc'}`; return builder; },
            async then(resolve) {
                try {
                    const res = await fetch([url, orderStr].filter(Boolean).join('&'), { headers });
                    const json = await res.json();
                    if (res.ok && Array.isArray(json) && json.length > 0) {
                        const result = { data: json, error: null };
                        return resolve ? resolve(result) : result;
                    }
                } catch (e) {}
                const fallback = JSON.parse(localStorage.getItem('db_' + table) || '[]');
                const result = { data: fallback, error: null };
                return resolve ? resolve(result) : result;
            },
            async insert(rows) {
                try { await fetch(`${SUPABASE_URL}/rest/v1/${table}`, { method: 'POST', headers, body: JSON.stringify(rows) }); } catch (e) {}
                const list = JSON.parse(localStorage.getItem('db_' + table) || '[]');
                rows.forEach((r, i) => list.push({ id_cuti: Date.now() + i, status_atasan: 'Menunggu', status_hrd: 'Menunggu', ...r }));
                localStorage.setItem('db_' + table, JSON.stringify(list));
                return { data: rows, error: null };
            },
            update(values) {
                return {
                    async eq(col, val) {
                        try { await fetch(`${SUPABASE_URL}/rest/v1/${table}?${col}=eq.${encodeURIComponent(val)}`, { method: 'PATCH', headers, body: JSON.stringify(values) }); } catch (e) {}
                        const list = JSON.parse(localStorage.getItem('db_' + table) || '[]').map(item => String(item[col]) === String(val) ? { ...item, ...values } : item);
                        localStorage.setItem('db_' + table, JSON.stringify(list));
                        return { data: list, error: null };
                    }
                };
            },
            delete() {
                return {
                    async eq(col, val) {
                        try { await fetch(`${SUPABASE_URL}/rest/v1/${table}?${col}=eq.${encodeURIComponent(val)}`, { method: 'DELETE', headers }); } catch (e) {}
                        const list = JSON.parse(localStorage.getItem('db_' + table) || '[]').filter(item => String(item[col]) !== String(val));
                        localStorage.setItem('db_' + table, JSON.stringify(list));
                        return { data: null, error: null };
                    }
                };
            }
        };
        return builder;
    }
};