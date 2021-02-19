-- 2

DROP TABLE IF EXISTS country__pop_coord ;

CREATE TABLE country__pop_coord (
    country_code3 VARCHAR(26),
    population NUMERIC(12),
    latitude VARCHAR(26),
    longitude VARCHAR(26));

ALTER TABLE country__pop_coord ADD PRIMARY KEY (country_code3) ;

ALTER TABLE country__pop_coord ADD CONSTRAINT fk_cpc_countries
    FOREIGN KEY (country_code3) REFERENCES country_gen_info (country_code) ;



INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('AFG', 3.7172386E7, '33', '65');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('AGO', 3.0809762E7, '-11.2027', '17.8739');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ALB', 2866376.0, '41.1533', '20.1683');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('AND', 77006.0, '42.5063', '1.5218');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ARE', 9630959.0, '24', '54');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ARG', 4.4494502E7, '-38.4161', '-63.6167');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ARM', 2951776.0, '40.0691', '45.0382');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ATG', 96286.0, '17.0608', '-61.7964');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('AUS', 2.4982688E7, '-31.9961875', '141.2327875');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('AUT', 8840521.0, '47.5162', '14.5501');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('AZE', 9939800.0, '40.1431', '47.5769');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BDI', 1.1175378E7, '-3.3731', '29.9189');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BEL', 1.1433256E7, '50.8333', '4');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BEN', 1.1485048E7, '9.3077', '2.3158');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BFA', 1.9751535E7, '12.2383', '-1.5616');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BGD', 1.61356039E8, '23.685', '90.3563');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BGR', 7025037.0, '42.7339', '25.4858');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BHR', 1569439.0, '26.0275', '50.55');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BHS', 385640.0, '25.034300000000002', '-77.3963');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BIH', 3323929.0, '43.9159', '17.6791');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BLR', 9483499.0, '53.7098', '27.9534');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BLZ', 383071.0, '13.1939', '-59.5432');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BOL', 1.1353142E7, '-17', '-65');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BRA', 2.09469333E8, '-14.235', '-51.9253');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BRB', 286641.0, '13.1939', '-59.5432');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BRN', 428962.0, '4.5', '114.6666667');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BTN', 754394.0, '27.5142', '90.4336');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('BWA', 2254126.0, '-22.3285', '24.6849');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CAF', 4666377.0, '6.6111', '20.9394');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CAN', 3.7057765E7, '44.78404667', '-82.50859333');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CHE', 8513227.0, '46.8182', '8.2275');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CHL', 1.872916E7, '-35.6751', '-71.543');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CHN', 1.39273E9, '32.82838485', '111.6490818');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CIV', 2.5069229E7, '8', '-5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CMR', 2.5216237E7, '3.848', '11.5021');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('COD', 8.4068091E7, '0', '25');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('COG', 5244363.0, '-1', '15');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('COL', 4.9648685E7, '4.5709', '-74.2973');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('COM', 832322.0, '-12.1666667', '44.25');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CPV', 543767.0, '16', '-24');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CRI', 4999441.0, '9.7489', '-83.7534');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CUB', 1.1338138E7, '22', '-80');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CYP', 1189265.0, '35.1264', '33.4299');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('CZE', 1.0629928E7, '49.8037633', '15.4749126');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('DEU', 8.2905782E7, '51', '9');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('DJI', 958920.0, '11.8251', '42.5903');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('DMA', 71625.0, '15.415', '-61.371');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('DNK', 5793636.0, '56.26', '9.5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('DOM', 1.0627165E7, '18.7357', '-70.1627');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('DZA', 4.2228429E7, '28.0339', '1.6596');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ECU', 1.7084357E7, '-1.8312', '-78.1834');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('EGY', 9.8423595E7, '26', '30');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ERI', 5750433.0, '15.1794', '39.7823');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ESP', 4.679654E7, '40', '-4');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('EST', 1321977.0, '58.5953', '25.0136');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ETH', 1.09224559E8, '9.145', '40.4897');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('FIN', 5515525.0, '64', '26');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('FJI', 883483.0, '-17.7134', '178.065');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('FRA', 6.6977107E7, '46.23', '2.21');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GAB', 2119275.0, '-0.8037', '11.6094');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GBR', 6.6460344E7, '55.3781', '-3.436');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GEO', 3726549.0, '42.3154', '43.3569');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GHA', 2.9767108E7, '7.9465', '-1.0232');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GIN', 1.2414318E7, '9.9456', '-9.6966');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GMB', 2280102.0, '13.4432', '-15.3101');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GNB', 1874309.0, '11.8037', '-15.1804');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GNQ', 1308974.0, '1.5', '10');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GRC', 1.0731726E7, '39.0742', '21.8243');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GRD', 111454.0, '12.1165', '-61.679');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GTM', 1.7247807E7, '15.7835', '-90.2308');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('GUY', 779004.0, '5', '-58.75');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('HND', 9587522.0, '15.2', '-86.2419');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('HRV', 4087843.0, '45.1', '15.2');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('HTI', 1.1123176E7, '18.9712', '-72.2852');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('HUN', 9775564.0, '47.1625', '19.5033');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('IDN', 2.67663435E8, '-0.7893', '113.9213');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('IND', 1.352617328E9, '21', '78');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('IRL', 4867309.0, '53.1424', '-7.6921');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('IRN', 8.1800269E7, '32', '53');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('IRQ', 3.84336E7, '33', '44');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ISL', 352721.0, '64.9631', '-19.0208');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ISR', 8882800.0, '31', '35');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ITA', 6.042176E7, '43', '12');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('JAM', 2934855.0, '18.1096', '-77.2975');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('JOR', 9956011.0, '31.24', '36.51');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('JPN', 1.265291E8, '36', '138');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KAZ', 1.827243E7, '48.0196', '66.9237');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KEN', 5.139301E7, '-0.0236', '37.9062');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KGZ', 6322800.0, '41.2044', '74.7661');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KHM', 1.6249798E7, '11.55', '104.9167');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KNA', 52441.0, '17.357822', '-62.782998');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KOR', 5.1606633E7, '37', '127.5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('KWT', 4137309.0, '29.5', '47.75');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LAO', 7061507.0, '18', '105');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LBN', 6848925.0, '33.8547', '35.8623');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LBR', 4818977.0, '6.4281', '-9.4295');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LBY', 6678567.0, '25', '17');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LCA', 181889.0, '13.9094', '-60.9789');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LKA', 2.167E7, '7', '81');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LSO', 2108132.0, '-29.5', '28.5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LTU', 2801543.0, '55.1694', '23.8813');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LUX', 607950.0, '49.8153', '6.1296');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('LVA', 1927174.0, '56.8796', '24.6032');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MAR', 3.6029138E7, '31.7917', '-7.0926');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MDA', 2706049.0, '47', '29');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MDG', 2.6262368E7, '-18.7669', '46.8691');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MDV', 515696.0, '3.2028', '73.2207');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MEX', 1.26190788E8, '23.6345', '-102.5528');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MKD', 2082958.0, '41.833', '22');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MLI', 1.907769E7, '17.570692', '-3.996166');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MLT', 484630.0, '35.9375', '14.3754');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MMR', 5.3708395E7, '21.9162', '95.956');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MNE', 622227.0, '42.5', '19.3');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MNG', 3170208.0, '46.8625', '103.8467');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MOZ', 2.9495962E7, '-18.665695', '35.529562');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MRT', 4403319.0, '21.0079', '10.9408');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MUS', 1265303.0, '-20.2', '57.5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MWI', 1.8143315E7, '-13.254308', '34.301525');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('MYS', 3.1528585E7, '2.5', '112.5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NAM', 2448255.0, '-22.9576', '18.4904');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NER', 2.2442948E7, '17.6078', '8.0817');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NGA', 1.9587474E8, '9.082', '8.6753');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NIC', 6465513.0, '12.8654', '-85.2072');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NLD', 1.7231624E7, '52.1326', '5.2913');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NOR', 5311916.0, '60.472', '8.4689');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NPL', 2.8087871E7, '28.1667', '84.25');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('NZL', 4841000.0, '-40.9006', '174.886');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('OMN', 4829483.0, '21', '57');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PAK', 2.1221503E8, '30.3753', '69.3451');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PAN', 4176873.0, '8.538', '-80.7821');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PER', 3.1989256E7, '-9.19', '-75.0152');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PHL', 1.06651922E8, '13', '122');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PNG', 8606316.0, '-6.315', '143.9555');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('POL', 3.797475E7, '51.9194', '19.1451');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PRT', 1.0283822E7, '39.3999', '-8.2245');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('PRY', 6956071.0, '-23.4425', '-58.4438');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('QAT', 2781677.0, '25.3548', '51.1839');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ROU', 1.9466145E7, '45.9432', '24.9668');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('RUS', 1.4447805E8, '60', '100');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('RWA', 1.2301939E7, '-1.9403', '29.8739');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SAU', 3.3699947E7, '24', '45');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SDN', 4.1801533E7, '12.8628', '30.2176');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SEN', 1.585436E7, '14.4974', '-14.4524');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SGP', 5638676.0, '1.2833', '103.8333');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SLE', 7650154.0, '8.460555', '-11.779889');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SLV', 6420744.0, '13.7942', '-88.8965');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SOM', 1.5008154E7, '5.1521', '46.1996');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SRB', 6982604.0, '44.0165', '21.0059');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('STP', 211028.0, '0.18636', '6.613081');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SUR', 575991.0, '3.9193', '-56.0278');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SVK', 5446771.0, '48.669', '19.699');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SVN', 2073894.0, '46.1512', '14.9955');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SWE', 1.0175214E7, '63', '16');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SWZ', 1136191.0, '-26.5', '31.5');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SYC', 96762.0, '-4.6796', '55.492');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('SYR', 1.6906283E7, '35', '38');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TCD', 1.5477751E7, '15.4542', '18.7322');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TGO', 7889094.0, '8.6195', '0.8248');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('THA', 6.9428524E7, '15', '101');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TJK', 9100837.0, '39', '71');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TLS', 1267972.0, '-8.874217', '125.727539');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TTO', 1389858.0, '10.6918', '-61.2225');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TUN', 1.1565204E7, '34', '9');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TUR', 8.2319724E7, '38.9637', '35.2433');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('TZA', 5.6318348E7, '-6', '35');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('UGA', 4.2723139E7, '1', '32');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('UKR', 4.4622516E7, '48.3794', '31.1656');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('URY', 3449299.0, '-32.5228', '-55.7658');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('USA', 3.26687501E8, '38', '-97');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('UZB', 3.29554E7, '41.3775', '64.5853');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('VCT', 110210.0, '12.9843', '-61.2872');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('VEN', 2.8870195E7, '8', '-66');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('VNM', 9.5540395E7, '16.1666667', '107.8333333');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('YEM', 2.8498687E7, '15.552727', '48.516388');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ZAF', 5.7779622E7, '-30.5595', '22.9375');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ZMB', 1.7351822E7, '-15.4167', '28.2833');

INSERT INTO country__pop_coord (country_code3, population, latitude, longitude)
VALUES ('ZWE', 1.4439018E7, '-20', '30');
