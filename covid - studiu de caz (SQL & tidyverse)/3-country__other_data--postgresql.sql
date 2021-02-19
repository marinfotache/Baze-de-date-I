
DROP TABLE IF EXISTS country__other_data ;

CREATE TABLE country__other_data (
    country_code_iso3 VARCHAR(26),
    gdp_per_capita NUMERIC(21, 13),
    health_exp NUMERIC(19, 17),
    pop_65 NUMERIC(19, 15),
    pop_female NUMERIC(19, 15),
    smoking_females NUMERIC(20, 16),
    smoking_males NUMERIC(19, 15));

ALTER TABLE country__other_data ADD PRIMARY KEY (country_code_iso3) ;

ALTER TABLE country__other_data ADD CONSTRAINT fk_cpc_countries
    FOREIGN KEY (country_code_iso3) REFERENCES country_gen_info (country_code) ;


INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('AFG', 520.8966027191353, 0.117771938443184, 2.58492693988024, 48.6358467017121, 5.833333333333333, 25.166666666666664);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ALB', 5268.848503559188, 0.06880374252796173, 13.7447359109736, 49.0630945959306, 7.1, 51.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('DZA', 4114.715061368957, 0.0637432187795639, 6.36249654497986, 49.4842678798151, 0.7, 30.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('AND', 42029.76273729893, 0.103205524384975, 19.40062533594237, 51.024733727158164, 29.0, 37.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('AGO', 3432.3857360089282, 0.0279150027781725, 2.21637364776329, 50.5304629337424, 1.8, 29.266666666666666);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ATG', 16726.980807947926, 0.0453353188931942, 8.79982551980558, 51.7884962921418, 2.466666666666667, 14.933333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ARG', 11683.949621636286, 0.0912431478500366, 11.1177888760774, 51.2373484456557, 16.2, 27.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ARM', 4212.070942729374, 0.103627048432827, 11.2538176570131, 52.9565771522637, 1.5, 52.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('AUS', 57395.919466316685, 0.08690043538808823, 15.6564752275591, 50.1996232411296, 13.0, 16.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('AUT', 51499.88536140855, 0.103966169059277, 19.0015664595899, 50.8294266482503, 28.4, 30.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('AZE', 4722.381678883348, 0.0665182918310165, 6.19518275071493, 50.1157491047071, 0.3, 42.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BHS', 32217.87159008401, 0.0575888901948929, 7.25760235662035, 51.4250521866532, 3.1, 20.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BHR', 24050.757505395646, 0.0474810488522053, 2.42633387832394, 36.3482516056683, 5.8, 37.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BGD', 1698.2628023354723, 0.0227424874901772, 5.15839063962068, 49.3872966665271, 1.0, 44.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BRB', 17949.281505437113, 0.0677912682294846, 15.8026939621338, 51.6728300307005, 1.9, 14.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BLR', 6330.075246418698, 0.0592578575015068, 14.8451481743098, 53.4560542241486, 10.5, 46.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BEL', 47472.136730207785, 0.10338669270277, 18.7887437383395, 50.593319387085, 25.1, 31.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BLZ', 4884.74242133376, 0.0564282275736332, 4.73645877657144, 50.1925230570834, 7.066666666666666, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BEN', 1240.8294644195398, 0.0371858216822147, 3.25360529746338, 50.098201703347, 0.6, 12.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BTN', 3243.231125080137, 0.0318696238100529, 6.00301171280561, 47.0026352207594, 1.0666666666666667, 30.76666666666667);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BOL', 3548.59013979338, 0.0644316077232361, 7.19194739218447, 49.7833991301085, 3.1, 17.566666666666666);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BIH', 6065.6727082415755, 0.0893166735768318, 16.4703174710621, 51.0105360252881, 30.2, 47.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BWA', 8258.641665746905, 0.0613456815481186, 4.22387434629301, 51.7307604432344, 5.7, 34.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BRA', 9001.234248634986, 0.0946747660636902, 8.92283783244003, 50.8299167629894, 10.1, 17.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BRN', 31628.328791434924, 0.0237320773303509, 4.87314756750582, 48.0361805296531, 2.0, 30.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BGR', 9271.54563263874, 0.0809560343623161, 21.021914434268, 51.4140884138516, 30.1, 44.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BFA', 715.12290404614, 0.0691505968570709, 2.40698082866355, 50.0954815202072, 1.6, 23.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('BDI', 271.7520443766482, 0.0751757025718689, 2.24694046033717, 50.4219946366025, 3.1333333333333333, 21.766666666666666);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CPV', 3635.4068498233937, 0.0516548864543438, 4.60932715666821, 49.8190391419807, 2.1, 16.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KHM', 1510.3248705763974, 0.0591884180903435, 4.56868001756576, 51.1979812668406, 2.0, 33.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CMR', 1533.7421397588473, 0.0467066690325737, 2.72887735524057, 50.0034878287467, 0.8666666666666667, 23.599999999999998);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CAN', 46234.3507461125, 0.105727694928646, 17.2320066788651, 50.3915299543153, 12.0, 16.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CAF', 475.7212505443178, 0.0582177564501762, 2.82577370666008, 50.4364737081782, 0.8666666666666667, 14.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TCD', 728.3432353592895, 0.0448730140924454, 2.48051894434901, 50.0848994170785, 0.7000000000000001, 15.633333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CHL', 15923.358737538074, 0.089835099875927, 11.5298016568816, 50.7270318390045, 34.2, 41.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CHN', 9770.847087833143, 0.05989373102784157, 10.9208835350654, 48.6793739572695, 1.9, 48.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('COL', 6667.790699549797, 0.0722628086805344, 8.47804701986958, 50.9257716952294, 4.7, 13.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('COM', 1415.2636223156248, 0.073843739926815, 3.00700930649436, 49.5587044437129, 4.4, 23.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('COG', 2147.769461045938, 0.0293027926236391, 2.68171953903232, 50.0656037730416, 1.7, 52.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CRI', 12027.365882631564, 0.0732879638671875, 9.54984767296984, 50.0098510974123, 6.4, 17.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('HRV', 14915.372071573584, 0.0678913369774818, 20.445433012423, 51.8526217475815, 34.3, 39.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CUB', 8821.818891250045, 0.117113269865513, 15.1862114171521, 50.3328498327681, 17.1, 53.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CYP', 28689.6985789646, 0.0668456926941872, 13.7190617734483, 49.9710744983023, 19.6, 52.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CZE', 23069.38324543404, 0.0723133906722069, 19.4208768932343, 50.8085889327815, 30.5, 38.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CIV', 1715.531332126494, 0.0445303432643414, 2.85894301500285, 49.5191195771262, 1.7, 28.23333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PRK', 14258.480696293393, 0.05117393657565117, 9.33452040978796, 51.0938524844571, 4.533333333333333, 42.06666666666666);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('COD', 561.7771823904247, 0.0397872291505337, 3.01784062159803, 50.0977433863968, 2.433333333333333, 21.46666666666667);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('DNK', 61390.69300970091, 0.101082794368267, 19.8129526369902, 50.2742027259115, 19.3, 18.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('DJI', 3082.543098719573, 0.0331651791930199, 4.52757937811482, 47.3667854457553, 1.7, 24.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('DMA', 7691.34509727878, 0.0587688907980919, 8.70602118708806, 49.511107101648996, 7.066666666666666, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('DOM', 8050.631601846355, 0.0613639503717422, 7.08281747649721, 50.007796071702, 8.5, 19.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ECU', 6344.871978500566, 0.0825742930173874, 7.15728972666108, 49.9706251782698, 2.0, 12.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('EGY', 2549.1322517860917, 0.0528763681650162, 5.22977934620923, 49.4699716435901, 0.2, 50.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SLV', 4058.2524392811797, 0.0722756013274193, 8.28709000480629, 53.1140024358563, 2.5, 18.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GNQ', 10144.195810845564, 0.0310709420591593, 2.45787734677897, 44.4558529404125, 6.333333333333333, 33.733333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ERI', 1087.3012690564142, 0.0287002343684435, 2.852530296822023, 50.53212929997773, 0.2, 11.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('EST', 23247.10984304532, 0.0642935782670975, 19.6263568469749, 52.8584268202066, 24.5, 39.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ETH', 772.3135302613568, 0.0350255742669106, 3.50113299760986, 49.9788884188067, 0.4, 8.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('FJI', 6266.967965280741, 0.0350074470043182, 5.44968041263952, 49.3005014205028, 10.2, 34.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('FIN', 50175.29981565925, 0.0920693874359131, 21.7207875455222, 50.7207584853832, 18.3, 22.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('FRA', 41469.9195544229, 0.113128922879696, 20.0346247469881, 51.5842404811336, 30.1, 35.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GAB', 7952.525892776509, 0.0278074592351913, 3.56390746835592, 49.0686201649149, 6.5, 39.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GMB', 716.1184889791263, 0.032820712774992, 2.58998093938232, 50.4021328963919, 0.7, 31.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GEO', 4722.777193864931, 0.0760165899991989, 14.8654914310525, 52.2912375035786, 5.3, 55.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('DEU', 47615.7400276733, 0.112468346953392, 21.4619619953309, 50.6603673700529, 28.2, 33.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GHA', 2202.312164425038, 0.0326237045228481, 3.06889800693396, 49.3258297043838, 0.3, 7.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GRC', 20316.568330573646, 0.0804139003157616, 21.6552720778435, 50.916201905221, 35.3, 52.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GRD', 10640.49676033095, 0.047571174800396, 9.62190679562869, 49.6074437635152, 7.066666666666666, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GTM', 4549.01008110721, 0.0581384375691414, 4.81207250828785, 50.7593494959228, 4.166666666666667, 20.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GIN', 878.599613250501, 0.0412308685481548, 2.92602244847935, 51.8211107004733, 0.8666666666666667, 17.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GNB', 777.9699218025221, 0.0723586902022362, 2.82371633615269, 51.1688071945639, 3.7333333333333334, 24.53333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GUY', 4979.002188398858, 0.0494550988078117, 6.45027124309697, 49.8080248316125, 7.066666666666666, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('HTI', 868.3420246940705, 0.0803550109267235, 4.94940384843253, 50.652209893517, 2.9, 23.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('HND', 2505.776751895597, 0.0785842537879944, 4.69061765907812, 50.0493401684669, 2.0, 16.733333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('HUN', 16150.772761372531, 0.0687998980283737, 19.1577253832321, 52.4324280334941, 26.8, 34.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ISL', 73368.11746426535, 0.0832629129290581, 14.7950925565689, 49.8117085224168, 14.3, 15.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('IND', 2009.978857270392, 0.0353495962917805, 6.17995564947149, 48.0235396426684, 1.9, 20.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('IDN', 3893.596077572392, 0.0298905447125435, 5.85716561272863, 49.6438821889217, 2.8, 76.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('IRN', 5627.749268454558, 0.0865966379642487, 6.18457380562499, 49.4391297606055, 0.8, 21.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('IRQ', 5834.166210760614, 0.0416663028299809, 3.32359966279505, 49.4086815277589, 0.5666666666666667, 33.86666666666667);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('IRL', 78582.9480997567, 0.0718438327312469, 13.8658017012923, 50.4255094845201, 23.0, 25.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ISR', 41719.725441705676, 0.0740746408700943, 11.9769860249625, 50.2981265779531, 15.4, 35.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ITA', 34488.63885498616, 0.0884025916457176, 22.7516796025077, 51.3766696255652, 19.8, 27.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('JAM', 5354.236858770302, 0.0598841682076454, 8.79664255070196, 50.3398296269012, 5.3, 28.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('JPN', 39289.95843463575, 0.109359331429005, 27.576369910355, 51.1592591291078, 11.2, 33.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('JOR', 4241.788782138538, 0.0811925083398819, 3.84649039799834, 49.389683544596, 9.466666666666667, 30.733333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KAZ', 9814.786257732796, 0.0312536172568798, 7.39184627103032, 51.5114836468188, 7.0, 43.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KEN', 1710.5100969940536, 0.0480254329741001, 2.33918661191556, 50.3160203897178, 1.2, 20.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KIR', 1625.2861000151222, 0.06758303195238113, 3.95262717204589, 50.8485696034254, 35.9, 58.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KWT', 33994.40656678305, 0.052913848310709, 2.55047238400198, 39.5481706247096, 2.7, 37.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KGZ', 1279.9450573778622, 0.061858631670475, 4.49472797559656, 50.5248630835062, 3.6, 50.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LAO', 2542.486528179197, 0.0252808686345816, 4.0751499644481, 49.7893648061644, 7.3, 51.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LVA', 17854.759963506414, 0.0595566183328629, 20.0436203206809, 54.0101666562093, 25.6, 51.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LBN', 8269.787675519232, 0.0819554403424263, 7.00236813439294, 49.705805515578, 26.9, 40.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LSO', 1299.1531259873295, 0.05401087552309037, 4.90108749682213, 50.7168954341523, 0.4, 53.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LBR', 677.3221785453636, 0.0815533772110939, 3.25343179968014, 49.7682910228231, 1.5, 18.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LBY', 7241.704481130245, 0.07717745502789816, 4.39204025898401, 49.4837888079251, 9.466666666666667, 30.733333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LTU', 19071.299790552952, 0.0645756423473358, 19.7050331564608, 53.7919586473278, 21.3, 38.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LUX', 116597.29563795392, 0.054810743778944, 14.1831541841472, 49.5392589748512, 20.9, 26.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MDG', 527.5012850412818, 0.0550203807651997, 2.98671712579162, 50.1239666132987, 2.033333333333333, 16.633333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MWI', 389.39803317883633, 0.0964823141694069, 2.64543493031032, 50.7015156905763, 4.4, 24.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MYS', 11373.233002567642, 0.0385939814150333, 6.67175462547886, 48.5785205819849, 1.0, 42.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MDV', 10330.615614093982, 0.0902997627854347, 3.70334460612454, 37.2649814622342, 2.1, 55.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MLI', 899.6599080966151, 0.0379398502409458, 2.50722975755683, 49.940996726292, 1.6, 23.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MLT', 30029.9670447209, 0.0934099927544594, 20.3493242997122, 49.8733082150459, 20.9, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MRT', 1188.8345875397326, 0.0440315157175064, 3.14111215805009, 49.8226562187735, 0.8, 25.53333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MUS', 11238.690394896143, 0.0571872070431709, 11.4741730686522, 50.5771064028586, 3.2, 40.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MEX', 9673.443673606193, 0.0551654137670994, 7.22368498087198, 51.0892808319391, 6.9, 21.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('FSM', 3568.290829360982, 0.04109740691880387, 3.99680397727273, 49.1548295454545, 3.6999999999999997, 48.766666666666666);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MNG', 4121.7324346939085, 0.0400230102241039, 4.08353878726245, 50.6695447058148, 5.5, 46.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MNE', 8845.914218872962, 0.07809246828158693, 14.9749366447439, 50.5590129387722, 44.0, 47.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MAR', 3222.20063433213, 0.0524520017206669, 7.0129048211122, 50.4038472912818, 0.8, 47.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MOZ', 498.9572202086523, 0.0494119822978973, 2.8907644574499, 51.4751911012775, 5.1, 29.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MMR', 1325.9529237064032, 0.0465907230973244, 5.78464193257209, 51.8078968699039, 6.3, 35.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NAM', 5931.453886116169, 0.0855095684528351, 3.63603168074514, 51.5536903157293, 9.7, 34.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NRU', 9888.893596529933, 0.03702053055167197, 8.00744272590256, 49.715908872485734, 43.0, 36.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NPL', 1033.9124308263372, 0.0555329509079456, 5.72767077569198, 54.5353433292596, 9.5, 37.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NLD', 53022.19139119591, 0.101008348166943, 19.1961926333387, 50.2209435647813, 24.4, 27.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NZL', 42330.906397305276, 0.091700553894043, 15.6524245271741, 50.8377693974718, 14.8, 17.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NIC', 2020.5470281862358, 0.0864546522498131, 5.24749744838026, 50.7127056800849, 3.2666666666666666, 30.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NER', 413.9803049620889, 0.0773996263742447, 2.59500788269853, 49.7710025976669, 0.1, 15.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NGA', 2028.1819701759794, 0.0375553853809834, 2.74737700532743, 49.3361135462707, 0.6, 10.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('NOR', 81734.46557361016, 0.104463420808315, 17.0492221563211, 49.5246311324926, 19.6, 20.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('OMN', 16415.157278098934, 0.03849071636796, 2.39278695625796, 34.0140835154787, 0.5, 15.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PAK', 1482.4030630679774, 0.0289863366633654, 4.31277431133756, 48.5380747169765, 2.8, 36.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PAN', 15575.07254829151, 0.0731949135661125, 8.10473107966757, 49.9053836510993, 2.4, 9.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PNG', 2730.2747993587313, 0.0246927607804537, 3.44526925145617, 48.9627278731314, 23.5, 48.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PRY', 5821.8143229232355, 0.0665456876158714, 6.43021500946081, 49.1516113483061, 5.0, 21.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PER', 6941.235847630116, 0.0499515049159527, 8.08839279183076, 50.3377554939133, 4.8, 14.966666666666667);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PHL', 3102.7133632993136, 0.0444640778005123, 5.12256876829946, 49.7416573851815, 7.8, 40.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('POL', 15422.453467739591, 0.065419539809227, 17.5178167625452, 51.5307073794516, 23.3, 33.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('PRT', 23403.2176426469, 0.0896957442164421, 21.9538575375873, 52.7119617105452, 16.3, 30.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('QAT', 68793.78443726136, 0.0260742865502834, 1.3700703387375, 24.4952873836765, 0.8, 26.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KOR', 31380.146446865354, 0.0760386362671852, 14.4185558323969, 49.9168817920843, 6.2, 40.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MDA', 4228.922475499304, 0.070129506289959, 11.4695563413512, 52.035563123928, 5.9, 44.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ROU', 12306.109748204855, 0.0515788830816746, 18.3387013938296, 51.343743063071, 22.9, 37.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('RUS', 11288.8784475021, 0.0534457787871361, 14.6747083203719, 53.6617623581325, 23.4, 58.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('RWA', 772.9444599291868, 0.0657159835100174, 2.9381960775388, 50.8610613471713, 4.7, 21.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('KNA', 19275.41851265655, 0.050368070602417, 11.779157666090594, 51.35088431886943, 2.466666666666667, 14.933333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LCA', 10566.049745846214, 0.0454588681459427, 9.80653035642617, 50.7504535708395, 7.066666666666666, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('VCT', 7361.400961800199, 0.0448712520301342, 9.58978686338024, 49.2087832320116, 7.066666666666666, 30.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('WSM', 4183.407935046958, 0.0334092602133751, 4.80041197375197, 48.2562408223201, 16.7, 38.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('STP', 2001.1409022616363, 0.0622999146580696, 2.9256781090661, 49.9635126426324, 2.1333333333333333, 20.53333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SAU', 23338.963458071827, 0.0523025318980217, 3.31408802294981, 42.445847976176, 1.8, 25.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SEN', 1521.953554213913, 0.0413406379520893, 3.08682370101833, 51.2773297682071, 0.4, 16.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SRB', 7246.191986070544, 0.0843395814299583, 18.3457926916963, 51.002522964154, 37.7, 40.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SYC', 16433.935286515778, 0.050067350268364, 7.59454560435034, 48.6549117350197, 7.1, 35.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SLE', 533.991184258936, 0.134209275245667, 2.96655621131612, 50.1212721477712, 8.8, 41.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SGP', 64581.94401839536, 0.0444038286805153, 11.4633801933791, 47.6581254061005, 5.2, 28.3);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SVK', 19443.562462191767, 0.0674253478646278, 15.629246504777, 51.3383325230785, 23.1, 37.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SVN', 26041.81896782712, 0.0818701758980751, 19.6068796541788, 50.2452070327013, 20.1, 25.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SLB', 2137.6906953935677, 0.0409013709674279, 3.59895045928894, 49.1546374698249, 10.866666666666667, 53.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SOM', 314.5441656707632, 0.0481072130302588, 2.87331094294556, 50.1333502129666, 0.8666666666666667, 14.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ZAF', 6374.028195759437, 0.0811311826109886, 5.31800500542302, 50.6941503848595, 8.1, 33.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ESP', 30323.651062873952, 0.0887312963604927, 19.3785075224995, 50.8966413132559, 27.4, 31.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('LKA', 4102.481350144672, 0.0381142050027847, 10.4732197537841, 51.9668176568014, 0.3, 27.0);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SDN', 977.273635724417, 0.0634180754423141, 3.58116052825144, 50.047414530166, 1.9666666666666668, 17.233333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SUR', 6234.044922306462, 0.062297698110342, 6.90636990225525, 49.7170943094202, 7.4, 42.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SWZ', 4145.974111686914, 0.0693037807941437, 4.01458794083506, 51.1489306276479, 1.7, 16.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SWE', 54651.08536651503, 0.110187463462353, 20.0955249278002, 49.9457761669857, 18.8, 18.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('CHE', 82828.79737217296, 0.123463220894337, 18.6232165647717, 50.4271246622237, 22.6, 28.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('SYR', 2548.9722449427013, 0.07993108406662947, 4.50312442147583, 49.8142113613984, 3.5666666666666664, 34.13333333333333);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TJK', 826.6215305387036, 0.0722881481051445, 3.02188755207627, 49.5838354386136, 4.8, 37.666666666666664);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('THA', 7273.563207320915, 0.0374601632356644, 11.9008931395893, 51.2687046149695, 1.9, 38.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('MKD', 6083.718948321484, 0.0606211498379707, 13.6701813815648, 49.9664659424078, 29.6, 46.43333333333334);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TLS', 1237.1026820825382, 0.0388229340314865, 4.31649229400603, 49.4584672410734, 6.3, 78.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TGO', 678.9556380611199, 0.0619951225817204, 2.86946801108822, 50.2680472221465, 0.9, 14.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TON', 4364.015561349494, 0.043913288662830965, 5.95366144364662, 49.9869184778922, 11.8, 44.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TTO', 17129.91309025769, 0.0697873532772064, 10.7349535163324, 50.591326633766, 12.833333333333334, 21.96666666666667);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TUN', 3447.507909755511, 0.0723245739936829, 8.31567907898877, 50.4371518597642, 1.1, 65.8);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TUR', 9370.176343828203, 0.0421630293130875, 8.4832129399716, 50.6778132013215, 14.1, 41.1);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TKM', 6966.635410630771, 0.0671329858402411, 4.42663446194014, 50.7607374042498, 2.933333333333333, 45.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('UGA', 642.7767442920069, 0.0618775598704815, 1.94098692046317, 50.7760788964281, 3.4, 16.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('UKR', 3095.17358053586, 0.0699532032012939, 16.4346864392016, 53.687750696908, 13.5, 47.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ARE', 43004.95335848479, 0.0333428233861923, 1.08500098484481, 30.6366879500976, 1.2, 37.4);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('GBR', 42962.412766355286, 0.0963169410824776, 18.3958656741466, 50.6352745607579, 20.0, 24.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('TZA', 1060.99461489421, 0.036454513669014, 2.60129917835952, 50.0510109095796, 3.3, 26.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('USA', 62886.836484559906, 0.170612692832947, 15.8076540556035, 50.5200146539124, 19.1, 24.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('URY', 17277.97011054961, 0.0929621160030365, 14.8145195308593, 51.7215426942936, 14.0, 19.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('UZB', 1532.371676796836, 0.0641438513994217, 4.4191378781364, 50.137358915283, 1.3, 24.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('VUT', 3123.8933964995563, 0.0409013709674279, 3.64015306819735, 49.2888015717092, 2.8, 34.5);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('VEN', 7112.246475992346, 0.0118121011182666, 7.26698662012597, 50.6332598022849, 5.1, 17.6);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('VNM', 2566.5969495851127, 0.0553212836384773, 7.2749782978793, 50.0964096241893, 1.0, 45.9);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('YEM', 944.4084993734193, 0.06927263115843144, 2.87626975604452, 49.6116574930849, 7.6, 29.2);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ZMB', 1539.9001577990691, 0.0447034128010273, 2.09967802593266, 50.49320776034, 3.1, 24.7);

INSERT INTO country__other_data (country_code_iso3, gdp_per_capita, health_exp, pop_65, pop_female, smoking_females, smoking_males)
VALUES ('ZWE', 2146.996384877074, 0.0663591623306274, 2.93952365300113, 52.3567520651976, 1.6, 30.7);

-- Import Data into table country__other_data from file country__other_data.csv . Task successful and sent to worksheet.
