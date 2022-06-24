CREATE TABLE hostname (
    hostname_id INTEGER PRIMARY KEY,
    from_https INTEGER NOT NULL, -- 0: http, 1: https
    from_domain TEXT NOT NULL,
    to_https INTEGER NOT NULL, -- 0: http, 1: https
    to_domain TEXT NOT NULL,
    status INTEGER DEFAULT 0, -- 0: disabled, 1: enabled, 2: enabled ROOT ONLY
    created_at TIMESTAMP CURRENT_TIMESTAMP
);

CREATE TABLE page (
    page_id INTEGER PRIMARY KEY,
    hostname_id INTEGER NOT NULL,
    from_path TEXT NOT NULL,
    to_path TEXT NOT NULL,
    created_at TIMESTAMP CURRENT_TIMESTAMP
);

