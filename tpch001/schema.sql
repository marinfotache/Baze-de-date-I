


CREATE TABLE customer(c_custkey BIGINT NOT NULL, c_name VARCHAR NOT NULL, c_address VARCHAR NOT NULL, c_nationkey INTEGER NOT NULL, c_phone VARCHAR NOT NULL, c_acctbal DECIMAL(15,2) NOT NULL, c_mktsegment VARCHAR NOT NULL, c_comment VARCHAR NOT NULL);
CREATE TABLE lineitem(l_orderkey BIGINT NOT NULL, l_partkey BIGINT NOT NULL, l_suppkey BIGINT NOT NULL, l_linenumber BIGINT NOT NULL, l_quantity DECIMAL(15,2) NOT NULL, l_extendedprice DECIMAL(15,2) NOT NULL, l_discount DECIMAL(15,2) NOT NULL, l_tax DECIMAL(15,2) NOT NULL, l_returnflag VARCHAR NOT NULL, l_linestatus VARCHAR NOT NULL, l_shipdate DATE NOT NULL, l_commitdate DATE NOT NULL, l_receiptdate DATE NOT NULL, l_shipinstruct VARCHAR NOT NULL, l_shipmode VARCHAR NOT NULL, l_comment VARCHAR NOT NULL);
CREATE TABLE nation(n_nationkey INTEGER NOT NULL, n_name VARCHAR NOT NULL, n_regionkey INTEGER NOT NULL, n_comment VARCHAR NOT NULL);
CREATE TABLE orders(o_orderkey BIGINT NOT NULL, o_custkey BIGINT NOT NULL, o_orderstatus VARCHAR NOT NULL, o_totalprice DECIMAL(15,2) NOT NULL, o_orderdate DATE NOT NULL, o_orderpriority VARCHAR NOT NULL, o_clerk VARCHAR NOT NULL, o_shippriority INTEGER NOT NULL, o_comment VARCHAR NOT NULL);
CREATE TABLE part(p_partkey BIGINT NOT NULL, p_name VARCHAR NOT NULL, p_mfgr VARCHAR NOT NULL, p_brand VARCHAR NOT NULL, p_type VARCHAR NOT NULL, p_size INTEGER NOT NULL, p_container VARCHAR NOT NULL, p_retailprice DECIMAL(15,2) NOT NULL, p_comment VARCHAR NOT NULL);
CREATE TABLE partsupp(ps_partkey BIGINT NOT NULL, ps_suppkey BIGINT NOT NULL, ps_availqty BIGINT NOT NULL, ps_supplycost DECIMAL(15,2) NOT NULL, ps_comment VARCHAR NOT NULL);
CREATE TABLE region(r_regionkey INTEGER NOT NULL, r_name VARCHAR NOT NULL, r_comment VARCHAR NOT NULL);
CREATE TABLE supplier(s_suppkey BIGINT NOT NULL, s_name VARCHAR NOT NULL, s_address VARCHAR NOT NULL, s_nationkey INTEGER NOT NULL, s_phone VARCHAR NOT NULL, s_acctbal DECIMAL(15,2) NOT NULL, s_comment VARCHAR NOT NULL);




