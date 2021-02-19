-- 1
DROP TABLE IF EXISTS country_gen_info ;

CREATE TABLE country_gen_info (
    country_code VARCHAR(26),
    country_name VARCHAR(100),
    region VARCHAR(128),
    country_income_group VARCHAR(100));

ALTER TABLE country_gen_info ADD PRIMARY KEY (country_code) ;
ALTER TABLE country_gen_info ADD UNIQUE (country_name) ;



INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('AFG', 'Afghanistan', 'South Asia', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ALB', 'Albania', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('DZA', 'Algeria', 'Middle East and  North Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('AND', 'Andorra', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('AGO', 'Angola', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ATG', 'Antigua and Barbuda', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ARG', 'Argentina', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ARM', 'Armenia', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('AUS', 'Australia', 'East Asia and  Pacific', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('AUT', 'Austria', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('AZE', 'Azerbaijan', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BHS', 'Bahamas, The', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BHR', 'Bahrain', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BGD', 'Bangladesh', 'South Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BRB', 'Barbados', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BLR', 'Belarus', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BEL', 'Belgium', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BLZ', 'Belize', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BEN', 'Benin', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BTN', 'Bhutan', 'South Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BOL', 'Bolivia', 'Latin America and  Caribbean', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BIH', 'Bosnia and Herzegovina', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BWA', 'Botswana', 'Sub-Saharan Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BRA', 'Brazil', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BRN', 'Brunei Darussalam', 'East Asia and  Pacific', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BGR', 'Bulgaria', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BFA', 'Burkina Faso', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('BDI', 'Burundi', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CPV', 'Cabo Verde', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KHM', 'Cambodia', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CMR', 'Cameroon', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CAN', 'Canada', 'North America', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CAF', 'Central African Republic', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TCD', 'Chad', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CHL', 'Chile', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CHN', 'China', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('COL', 'Colombia', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('COM', 'Comoros', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('COG', 'Congo, Rep.', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CRI', 'Costa Rica', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('HRV', 'Croatia', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CUB', 'Cuba', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CYP', 'Cyprus', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CZE', 'Czech Republic', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CIV', 'Cote d''Ivoire', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PRK', 'Korea, Dem. People’s Rep.', 'East Asia and  Pacific', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('COD', 'Congo, Dem. Rep.', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('DNK', 'Denmark', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('DJI', 'Djibouti', 'Middle East and  North Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('DMA', 'Dominica', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('DOM', 'Dominican Republic', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ECU', 'Ecuador', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('EGY', 'Egypt, Arab Rep.', 'Middle East and  North Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SLV', 'El Salvador', 'Latin America and  Caribbean', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GNQ', 'Equatorial Guinea', 'Sub-Saharan Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ERI', 'Eritrea', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('EST', 'Estonia', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ETH', 'Ethiopia', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('FJI', 'Fiji', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('FIN', 'Finland', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('FRA', 'France', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GAB', 'Gabon', 'Sub-Saharan Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GMB', 'Gambia, The', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GEO', 'Georgia', 'Europe and  Central Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('DEU', 'Germany', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GHA', 'Ghana', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GRC', 'Greece', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GRD', 'Grenada', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GTM', 'Guatemala', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GIN', 'Guinea', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GNB', 'Guinea-Bissau', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GUY', 'Guyana', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('HTI', 'Haiti', 'Latin America and  Caribbean', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('HND', 'Honduras', 'Latin America and  Caribbean', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('HUN', 'Hungary', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ISL', 'Iceland', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('IND', 'India', 'South Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('IDN', 'Indonesia', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('IRN', 'Iran, Islamic Rep.', 'Middle East and  North Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('IRQ', 'Iraq', 'Middle East and  North Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('IRL', 'Ireland', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ISR', 'Israel', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ITA', 'Italy', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('JAM', 'Jamaica', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('JPN', 'Japan', 'East Asia and  Pacific', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('JOR', 'Jordan', 'Middle East and  North Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KAZ', 'Kazakhstan', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KEN', 'Kenya', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KIR', 'Kiribati', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KWT', 'Kuwait', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KGZ', 'Kyrgyz Republic', 'Europe and  Central Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LAO', 'Lao PDR', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LVA', 'Latvia', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LBN', 'Lebanon', 'Middle East and  North Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LSO', 'Lesotho', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LBR', 'Liberia', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LBY', 'Libya', 'Middle East and  North Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LTU', 'Lithuania', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LUX', 'Luxembourg', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MDG', 'Madagascar', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MWI', 'Malawi', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MYS', 'Malaysia', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MDV', 'Maldives', 'South Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MLI', 'Mali', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MLT', 'Malta', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MRT', 'Mauritania', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MUS', 'Mauritius', 'Sub-Saharan Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MEX', 'Mexico', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('FSM', 'Micronesia, Fed. Sts.', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MNG', 'Mongolia', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MNE', 'Montenegro', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MAR', 'Morocco', 'Middle East and  North Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MOZ', 'Mozambique', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MMR', 'Myanmar', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NAM', 'Namibia', 'Sub-Saharan Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NRU', 'Nauru', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NPL', 'Nepal', 'South Asia', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NLD', 'Netherlands', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NZL', 'New Zealand', 'East Asia and  Pacific', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NIC', 'Nicaragua', 'Latin America and  Caribbean', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NER', 'Niger', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NGA', 'Nigeria', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('NOR', 'Norway', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('OMN', 'Oman', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PAK', 'Pakistan', 'South Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PAN', 'Panama', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PNG', 'Papua New Guinea', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PRY', 'Paraguay', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PER', 'Peru', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PHL', 'Philippines', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('POL', 'Poland', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('PRT', 'Portugal', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('QAT', 'Qatar', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KOR', 'Korea, Rep.', 'East Asia and  Pacific', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MDA', 'Moldova', 'Europe and  Central Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ROU', 'Romania', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('RUS', 'Russian Federation', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('RWA', 'Rwanda', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('KNA', 'St. Kitts and Nevis', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LCA', 'St. Lucia', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('VCT', 'St. Vincent and the Grenadines', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('WSM', 'Samoa', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('STP', 'Sao Tome and Principe', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SAU', 'Saudi Arabia', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SEN', 'Senegal', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SRB', 'Serbia', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SYC', 'Seychelles', 'Sub-Saharan Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SLE', 'Sierra Leone', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SGP', 'Singapore', 'East Asia and  Pacific', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SVK', 'Slovak Republic', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SVN', 'Slovenia', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SLB', 'Solomon Islands', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SOM', 'Somalia', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ZAF', 'South Africa', 'Sub-Saharan Africa', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ESP', 'Spain', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('LKA', 'Sri Lanka', 'South Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SDN', 'Sudan', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SUR', 'Suriname', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SWZ', 'Eswatini', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SWE', 'Sweden', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('CHE', 'Switzerland', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('SYR', 'Syrian Arab Republic', 'Middle East and  North Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TJK', 'Tajikistan', 'Europe and  Central Asia', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('THA', 'Thailand', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('MKD', 'Macedonia, FYR', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TLS', 'Timor-Leste', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TGO', 'Togo', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TON', 'Tonga', 'East Asia and  Pacific', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TTO', 'Trinidad and Tobago', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TUN', 'Tunisia', 'Middle East and  North Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TUR', 'Turkey', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TKM', 'Turkmenistan', 'Europe and  Central Asia', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('UGA', 'Uganda', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('UKR', 'Ukraine', 'Europe and  Central Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ARE', 'United Arab Emirates', 'Middle East and  North Africa', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('GBR', 'United Kingdom', 'Europe and  Central Asia', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('TZA', 'Tanzania', 'Sub-Saharan Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('USA', 'United States', 'North America', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('URY', 'Uruguay', 'Latin America and  Caribbean', 'High income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('UZB', 'Uzbekistan', 'Europe and  Central Asia', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('VUT', 'Vanuatu', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('VEN', 'Venezuela, RB', 'Latin America and  Caribbean', 'Upper middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('VNM', 'Vietnam', 'East Asia and  Pacific', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('YEM', 'Yemen, Rep.', 'Middle East and  North Africa', 'Low income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ZMB', 'Zambia', 'Sub-Saharan Africa', 'Lower middle income');

INSERT INTO country_gen_info (country_code, country_name, region, country_income_group)
VALUES ('ZWE', 'Zimbabwe', 'Sub-Saharan Africa', 'Low income');
