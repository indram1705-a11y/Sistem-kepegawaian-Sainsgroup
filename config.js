const SUPABASE_URL = 'https://supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_g4hrPzEod4S3VuAn5lWoaA_Txfw0Vgn';

const db = {
    from(table) {
        const headers = {
            'apikey': SUPABASE_ANON_KEY,
            'Authorization': 'Bearer ' + SUPABASE_ANON_KEY,
            'Content-Type': 'application/json',
            'Prefer': 'return=representation'
        };
        let url = `${SUPABASE_URL}/rest/v1/${table}?`;
        let filters = [];
        let orderStr = '';
        let isSingle = false;

        const builder = {
            select(cols = '*') {
                url += `select=${cols}&`;
                return builder;
            },
            eq(col, val) {
                filters.push(`${col}=eq.${encodeURIComponent(val)}`);
                return builder;
            },
            order(col, { ascending = true } = {}) {
                orderStr = `order=${col}.${ascending ? 'asc' : 'desc'}`;
                return builder;
            },
            single() {
                isSingle = true;
                return builder.then();
            },
            async then(resolve) {
                const query = [url + filters.join('&'), orderStr].filter(Boolean).join('&');
                try {
                    const res = await fetch(query, { headers });
                    const json = await res.json();
                    const singleRow = (Array.isArray(json) && json.length > 0) ? json[0] : null;
                    const result = isSingle
                        ? { data: singleRow, error: null }
                        : { data: json, error: null };
                    if (resolve) return resolve(result);
                    return result;
                } catch (err) {
                    const errorRes = { data: null, error: err };
                    if (resolve) return resolve(errorRes);
                    return errorRes;
                }
            },
            async insert(rows) {
                const res = await fetch(`${SUPABASE_URL}/rest/v1/${table}`, {
                    method: 'POST', headers, body: JSON.stringify(rows)
                });
                return { data: await res.json(), error: null };
            },
            update(values) {
                return {
                    async eq(col, val) {
                        const res = await fetch(`${SUPABASE_URL}/rest/v1/${table}?${col}=eq.${encodeURIComponent(val)}`, {
                            method: 'PATCH', headers, body: JSON.stringify(values)
                        });
                        return { data: await res.json(), error: null };
                    }
                };
            },
            delete() {
                return {
                    async eq(col, val) {
                        const res = await fetch(`${SUPABASE_URL}/rest/v1/${table}?${col}=eq.${encodeURIComponent(val)}`, {
                            method: 'DELETE', headers
                        });
                        return { data: null, error: null };
                    }
                };
            }
        };
        return builder;
    }
};