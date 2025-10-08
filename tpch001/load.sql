COPY customer FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/customer.json' (FORMAT 'json');
COPY lineitem FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/lineitem.json' (FORMAT 'json');
COPY nation FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/nation.json' (FORMAT 'json');
COPY orders FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/orders.json' (FORMAT 'json');
COPY part FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/part.json' (FORMAT 'json');
COPY partsupp FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/partsupp.json' (FORMAT 'json');
COPY region FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/region.json' (FORMAT 'json');
COPY supplier FROM '/Users/marinfotache/My Drive/duckdb_ducklake/datasets/tpch001/json/supplier.json' (FORMAT 'json');
