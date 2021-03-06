# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/daien/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength
DAIEN_EXPECTED_MONTHS = {
  766 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '54-1622', phase_index: 0, even_term: '55-26', even_term_index: 0, odd_term: '10-690', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '23-2993', phase_index: 0, even_term: '25-1354', even_term_index: 2, odd_term: '40-2018', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '53-1314', phase_index: 0, even_term: '55-2683', even_term_index: 4, odd_term: '11-307', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '22-2718', phase_index: 0, even_term: '26-971', even_term_index: 6, odd_term: '41-1636', odd_term_index: 7 },
    # 計算上は3が小の月で、4が大の月
    { is_many_days: false, month: 3, leaped: false, remainder: '52-1182', phase_index: 0, even_term: '56-2300', even_term_index: 8, odd_term: '11-2964', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '21-2848', phase_index: 0, even_term: '27-588', even_term_index: 10, odd_term: '42-1253', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '51-1521', phase_index: 0, even_term: '57-1917', even_term_index: 12, odd_term: '12-2581', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '21-298', phase_index: 0, even_term: '28-206', even_term_index: 14, odd_term: '43-870', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '50-2274', phase_index: 0, even_term: '58-1534', even_term_index: 16, odd_term: '13-2198', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '20-1176', phase_index: 0, even_term: '28-2863', even_term_index: 18, odd_term: '44-487', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '50-29', phase_index: 0, even_term: '59-1151', even_term_index: 20, odd_term: '14-1816', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '19-1814', phase_index: 0, even_term: '29-2480', even_term_index: 22, odd_term: '45-104', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '49-431', phase_index: 0, even_term: '0-769', even_term_index: 0, odd_term: '15-1433', odd_term_index: 1 }
  ],
  767 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '49-431', phase_index: 0, even_term: '0-769', even_term_index: 0, odd_term: '15-1433', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '18-2024', phase_index: 0, even_term: '30-2097', even_term_index: 2, odd_term: '45-2761', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '48-297', phase_index: 0, even_term: '1-386', even_term_index: 4, odd_term: '16-1050', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '17-1455', phase_index: 0, even_term: '31-1714', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 3, leaped: false, remainder: '46-2637', phase_index: 0, even_term: '2-3', even_term_index: 8, odd_term: '46-2379', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '16-831', phase_index: 0, even_term: '32-1331', even_term_index: 10, odd_term: '17-667', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '45-2178', phase_index: 0, even_term: '2-2660', even_term_index: 12, odd_term: '47-1996', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '15-644', phase_index: 0, even_term: '33-949', even_term_index: 14, odd_term: '18-284', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '44-2394', phase_index: 0, even_term: '3-2277', even_term_index: 16, odd_term: '48-1613', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '14-1361', phase_index: 0, even_term: '34-566', even_term_index: 18, odd_term: '18-2941', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '44-464', phase_index: 0, even_term: '4-1894', even_term_index: 20, odd_term: '49-1230', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '13-2578', phase_index: 0, even_term: '35-183', even_term_index: 22, odd_term: '19-2559', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '43-1613', phase_index: 0, even_term: '5-1512', even_term_index: 0, odd_term: '50-847', odd_term_index: 23 }
  ],
  768 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '43-1613', phase_index: 0, even_term: '5-1512', even_term_index: 0, odd_term: '50-847', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '13-562', phase_index: 0, even_term: '35-2840', even_term_index: 2, odd_term: '20-2176', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '42-2230', phase_index: 0, even_term: '6-1129', even_term_index: 4, odd_term: '51-464', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '12-562', phase_index: 0, even_term: '36-2457', even_term_index: 6, odd_term: '21-1793', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '41-1676', phase_index: 0, even_term: '7-746', even_term_index: 8, odd_term: '52-82', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '10-2656', phase_index: 0, even_term: '37-2074', even_term_index: 10, odd_term: '22-1410', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '40-632', phase_index: 0, even_term: '8-363', even_term_index: 12, odd_term: '52-2739', odd_term_index: 11 },
    # 計算では6月が閏5月（小の月）、閏6月が6月（大の月）
    { is_many_days: false, month: 5, leaped: true, remainder: '9-1691', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '23-1027', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '38-2994', phase_index: 0, even_term: '38-1692', even_term_index: 14, odd_term: '53-2356', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '8-1622', phase_index: 0, even_term: '8-3020', even_term_index: 16, odd_term: '24-644', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '38-518', phase_index: 0, even_term: '39-1309', even_term_index: 18, odd_term: '54-1973', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '7-2708', phase_index: 0, even_term: '9-2637', even_term_index: 20, odd_term: '25-262', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '37-1995', phase_index: 0, even_term: '40-926', even_term_index: 22, odd_term: '55-1590', odd_term_index: 23 }
  ],
  769 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '7-1272', phase_index: 0, even_term: '10-2255', even_term_index: 0, odd_term: '25-2919', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '37-428', phase_index: 0, even_term: '41-543', even_term_index: 2, odd_term: '56-1207', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '6-2241', phase_index: 0, even_term: '11-1872', even_term_index: 4, odd_term: '26-2536', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '36-653', phase_index: 0, even_term: '42-160', even_term_index: 6, odd_term: '57-825', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '5-1832', phase_index: 0, even_term: '12-1489', even_term_index: 8, odd_term: '27-2153', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '34-2760', phase_index: 0, even_term: '42-2817', even_term_index: 10, odd_term: '58-442', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '4-529', phase_index: 0, even_term: '13-1106', even_term_index: 12, odd_term: '28-1770', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '33-1417', phase_index: 0, even_term: '43-2435', even_term_index: 14, odd_term: '59-59', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '2-2573', phase_index: 0, even_term: '14-723', even_term_index: 16, odd_term: '29-1387', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '32-1038', phase_index: 0, even_term: '44-2052', even_term_index: 18, odd_term: '59-2716', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '1-2890', phase_index: 0, even_term: '15-340', even_term_index: 20, odd_term: '30-1005', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '31-1974', phase_index: 0, even_term: '45-1669', even_term_index: 22, odd_term: '0-2333', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '1-1332', phase_index: 0, even_term: '15-2998', even_term_index: 0, odd_term: '', odd_term_index: -1 }
  ],
  770 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '1-1332', phase_index: 0, even_term: '15-2998', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '31-813', phase_index: 0, even_term: '46-1286', even_term_index: 2, odd_term: '31-622', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '1-24', phase_index: 0, even_term: '16-2615', even_term_index: 4, odd_term: '1-1950', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '30-1988', phase_index: 0, even_term: '47-903', even_term_index: 6, odd_term: '32-239', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '0-555', phase_index: 0, even_term: '17-2232', even_term_index: 8, odd_term: '2-1568', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '29-1818', phase_index: 0, even_term: '48-520', even_term_index: 10, odd_term: '32-2896', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '58-2814', phase_index: 0, even_term: '18-1849', even_term_index: 12, odd_term: '3-1185', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '28-518', phase_index: 0, even_term: '49-138', even_term_index: 14, odd_term: '33-2513', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '57-1333', phase_index: 0, even_term: '19-1466', even_term_index: 16, odd_term: '4-802', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '26-2408', phase_index: 0, even_term: '49-2795', even_term_index: 18, odd_term: '34-2130', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '56-708', phase_index: 0, even_term: '20-1083', even_term_index: 20, odd_term: '5-419', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '25-2409', phase_index: 0, even_term: '50-2412', even_term_index: 22, odd_term: '35-1748', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '55-1422', phase_index: 0, even_term: '21-701', even_term_index: 0, odd_term: '6-36', odd_term_index: 23 }
  ],
  771 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '55-1422', phase_index: 0, even_term: '21-701', even_term_index: 0, odd_term: '6-36', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '25-736', phase_index: 0, even_term: '51-2029', even_term_index: 2, odd_term: '36-1365', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '55-151', phase_index: 0, even_term: '22-318', even_term_index: 4, odd_term: '6-2693', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '24-2465', phase_index: 0, even_term: '52-1646', even_term_index: 6, odd_term: '37-982', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '54-1472', phase_index: 0, even_term: '22-2975', even_term_index: 8, odd_term: '7-2311', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true, remainder: '24-205', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '38-599', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '53-1619', phase_index: 0, even_term: '53-1263', even_term_index: 10, odd_term: '8-1928', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '22-2691', phase_index: 0, even_term: '23-2592', even_term_index: 12, odd_term: '39-216', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '52-553', phase_index: 0, even_term: '54-881', even_term_index: 14, odd_term: '9-1545', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '21-1427', phase_index: 0, even_term: '24-2209', even_term_index: 16, odd_term: '39-2873', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '50-2427', phase_index: 0, even_term: '55-498', even_term_index: 18, odd_term: '10-1162', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '20-645', phase_index: 0, even_term: '25-1826', even_term_index: 20, odd_term: '40-2491', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '49-2181', phase_index: 0, even_term: '56-115', even_term_index: 22, odd_term: '11-779', odd_term_index: 23 }
  ],
  772 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '19-1068', phase_index: 0, even_term: '26-1444', even_term_index: 0, odd_term: '41-2108', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '49-241', phase_index: 0, even_term: '56-2772', even_term_index: 2, odd_term: '12-396', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '18-2472', phase_index: 0, even_term: '27-1061', even_term_index: 4, odd_term: '42-1725', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '48-1683', phase_index: 0, even_term: '57-2389', even_term_index: 6, odd_term: '13-14', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '18-762', phase_index: 0, even_term: '28-678', even_term_index: 8, odd_term: '43-1342', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '47-2622', phase_index: 0, even_term: '58-2006', even_term_index: 10, odd_term: '13-2671', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '17-1170', phase_index: 0, even_term: '29-295', even_term_index: 12, odd_term: '44-959', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '46-2416', phase_index: 0, even_term: '59-1624', even_term_index: 14, odd_term: '14-2288', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '16-504', phase_index: 0, even_term: '29-2952', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 8, leaped: false, remainder: '45-1582', phase_index: 0, even_term: '0-1241', even_term_index: 18, odd_term: '45-576', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '14-2626', phase_index: 0, even_term: '30-2569', even_term_index: 20, odd_term: '15-1905', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '44-772', phase_index: 0, even_term: '1-858', even_term_index: 22, odd_term: '46-194', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '13-2237', phase_index: 0, even_term: '31-2187', even_term_index: 0, odd_term: '16-1522', odd_term_index: 23 }
  ],
  773 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '13-2237', phase_index: 0, even_term: '31-2187', even_term_index: 0, odd_term: '16-1522', odd_term_index: 23 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '43-949', phase_index: 0, even_term: '2-475', even_term_index: 2, odd_term: '46-2851', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '12-2866', phase_index: 0, even_term: '32-1804', even_term_index: 4, odd_term: '17-1139', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '42-1831', phase_index: 0, even_term: '3-92', even_term_index: 6, odd_term: '47-2468', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '12-839', phase_index: 0, even_term: '33-1421', even_term_index: 8, odd_term: '18-757', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '41-2916', phase_index: 0, even_term: '3-2749', even_term_index: 10, odd_term: '48-2085', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '11-1812', phase_index: 0, even_term: '34-1038', even_term_index: 12, odd_term: '19-374', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '41-440', phase_index: 0, even_term: '4-2367', even_term_index: 14, odd_term: '49-1702', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '10-1996', phase_index: 0, even_term: '35-655', even_term_index: 16, odd_term: '19-3031', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '40-354', phase_index: 0, even_term: '5-1984', even_term_index: 18, odd_term: '50-1319', odd_term_index: 17 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '9-1649', phase_index: 0, even_term: '36-272', even_term_index: 20, odd_term: '20-2648', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '38-2896', phase_index: 0, even_term: '6-1601', even_term_index: 22, odd_term: '51-937', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '8-1088', phase_index: 0, even_term: '36-2930', even_term_index: 0, odd_term: '21-2265', odd_term_index: 23 }
  ],
  774 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '8-1088', phase_index: 0, even_term: '36-2930', even_term_index: 0, odd_term: '21-2265', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: true, remainder: '37-2502', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '52-554', odd_term_index: 1 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '7-1018', phase_index: 0, even_term: '7-1218', even_term_index: 2, odd_term: '22-1882', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '36-2593', phase_index: 0, even_term: '37-2547', even_term_index: 4, odd_term: '53-171', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '6-1288', phase_index: 0, even_term: '8-835', even_term_index: 6, odd_term: '23-1500', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '36-74', phase_index: 0, even_term: '38-2164', even_term_index: 8, odd_term: '53-2828', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '5-1956', phase_index: 0, even_term: '9-452', even_term_index: 10, odd_term: '24-1117', odd_term_index: 11 },
    # 計算上では5が小の月、6が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '35-817', phase_index: 0, even_term: '39-1781', even_term_index: 12, odd_term: '54-2445', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '4-2637', phase_index: 0, even_term: '10-70', even_term_index: 14, odd_term: '25-734', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '34-1378', phase_index: 0, even_term: '40-1398', even_term_index: 16, odd_term: '55-2062', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '4-64', phase_index: 0, even_term: '10-2727', even_term_index: 18, odd_term: '26-351', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '33-1621', phase_index: 0, even_term: '41-1015', even_term_index: 20, odd_term: '56-1680', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '3-50', phase_index: 0, even_term: '11-2344', even_term_index: 22, odd_term: '26-3008', odd_term_index: 23 }
  ],
  775 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '32-1494', phase_index: 0, even_term: '42-633', even_term_index: 0, odd_term: '57-1297', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '1-2896', phase_index: 0, even_term: '12-1961', even_term_index: 2, odd_term: '27-2625', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '31-1174', phase_index: 0, even_term: '43-250', even_term_index: 4, odd_term: '58-914', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '0-2523', phase_index: 0, even_term: '13-1578', even_term_index: 6, odd_term: '28-2243', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '30-880', phase_index: 0, even_term: '43-2907', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 4, leaped: false, remainder: '59-2453', phase_index: 0, even_term: '14-1195', even_term_index: 10, odd_term: '59-531', odd_term_index: 9 },
    # 計算上では5が小の月、6が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '29-1075', phase_index: 0, even_term: '44-2524', even_term_index: 12, odd_term: '29-1860', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '58-2800', phase_index: 0, even_term: '15-813', even_term_index: 14, odd_term: '0-148', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '28-1704', phase_index: 0, even_term: '45-2141', even_term_index: 16, odd_term: '30-1477', odd_term_index: 15 },
    # 計算上では8が小の月、9が大の月
    { is_many_days: false, month: 8, leaped: false, remainder: '58-659', phase_index: 0, even_term: '16-430', even_term_index: 18, odd_term: '0-2805', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '27-2606', phase_index: 0, even_term: '46-1758', even_term_index: 20, odd_term: '31-1094', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '57-1463', phase_index: 0, even_term: '17-47', even_term_index: 22, odd_term: '1-2423', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '27-155', phase_index: 0, even_term: '47-1376', even_term_index: 0, odd_term: '32-711', odd_term_index: 23 }
  ],
  776 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '27-155', phase_index: 0, even_term: '47-1376', even_term_index: 0, odd_term: '32-711', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '56-1833', phase_index: 0, even_term: '17-2704', even_term_index: 2, odd_term: '2-2040', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '26-233', phase_index: 0, even_term: '48-993', even_term_index: 4, odd_term: '33-328', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '55-1418', phase_index: 0, even_term: '18-2321', even_term_index: 6, odd_term: '3-1657', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '24-2551', phase_index: 0, even_term: '49-610', even_term_index: 8, odd_term: '33-2986', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '54-688', phase_index: 0, even_term: '19-1938', even_term_index: 10, odd_term: '4-1274', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '23-1919', phase_index: 0, even_term: '50-227', even_term_index: 12, odd_term: '34-2603', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '53-287', phase_index: 0, even_term: '20-1556', even_term_index: 14, odd_term: '5-891', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '22-1908', phase_index: 0, even_term: '50-2884', even_term_index: 16, odd_term: '35-2220', odd_term_index: 15 },
    # 計算上では8が閏7月（小の月）、閏8が8月（大の月）
    { is_many_days: false, month: 7, leaped: true, remainder: '52-763', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '6-508', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '21-2885', phase_index: 0, even_term: '21-1173', even_term_index: 18, odd_term: '36-1837', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '51-2008', phase_index: 0, even_term: '51-2501', even_term_index: 20, odd_term: '7-126', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '21-1093', phase_index: 0, even_term: '22-790', even_term_index: 22, odd_term: '37-1454', odd_term_index: 23 }
  ],
  777 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '51-157', phase_index: 0, even_term: '52-2119', even_term_index: 0, odd_term: '7-2783', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '20-1985', phase_index: 0, even_term: '23-407', even_term_index: 2, odd_term: '38-1071', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '50-447', phase_index: 0, even_term: '53-1736', even_term_index: 4, odd_term: '8-2400', odd_term_index: 5 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '19-1672', phase_index: 0, even_term: '24-24', even_term_index: 6, odd_term: '39-689', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '48-2671', phase_index: 0, even_term: '54-1353', even_term_index: 8, odd_term: '9-2017', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '18-597', phase_index: 0, even_term: '24-2681', even_term_index: 10, odd_term: '40-306', odd_term_index: 11 },
    # 計算上では5が小の月、6が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '47-1602', phase_index: 0, even_term: '55-970', even_term_index: 12, odd_term: '10-1634', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '16-2714', phase_index: 0, even_term: '25-2299', even_term_index: 14, odd_term: '40-2963', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '46-1202', phase_index: 0, even_term: '56-587', even_term_index: 16, odd_term: '11-1251', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '15-3014', phase_index: 0, even_term: '26-1916', even_term_index: 18, odd_term: '41-2580', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '45-2053', phase_index: 0, even_term: '57-204', even_term_index: 20, odd_term: '12-869', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '15-1319', phase_index: 0, even_term: '27-1533', even_term_index: 22, odd_term: '42-2197', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '45-635', phase_index: 0, even_term: '57-2862', even_term_index: 0, odd_term: '13-486', odd_term_index: 1 }
  ],
  778 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '45-635', phase_index: 0, even_term: '57-2862', even_term_index: 0, odd_term: '13-486', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '14-2943', phase_index: 0, even_term: '28-1150', even_term_index: 2, odd_term: '43-1814', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '44-1923', phase_index: 0, even_term: '58-2479', even_term_index: 4, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 2, leaped: false, remainder: '14-473', phase_index: 0, even_term: '29-767', even_term_index: 6, odd_term: '14-103', odd_term_index: 5 },
    # 計算上では3が小の月、（4-6を飛ばして）7が大の月
    { is_many_days: false, month: 3, leaped: false, remainder: '43-1777', phase_index: 0, even_term: '59-2096', even_term_index: 8, odd_term: '44-1432', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '12-2816', phase_index: 0, even_term: '30-384', even_term_index: 10, odd_term: '14-2760', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '42-598', phase_index: 0, even_term: '0-1713', even_term_index: 12, odd_term: '45-1049', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '11-1397', phase_index: 0, even_term: '31-2', even_term_index: 14, odd_term: '15-2377', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '40-2429', phase_index: 0, even_term: '1-1330', even_term_index: 16, odd_term: '46-666', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '10-688', phase_index: 0, even_term: '31-2659', even_term_index: 18, odd_term: '16-1994', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '39-2407', phase_index: 0, even_term: '2-947', even_term_index: 20, odd_term: '47-283', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '9-1369', phase_index: 0, even_term: '32-2276', even_term_index: 22, odd_term: '17-1612', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '39-606', phase_index: 0, even_term: '3-565', even_term_index: 0, odd_term: '47-2940', odd_term_index: 23 }
  ],
  779 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '39-606', phase_index: 0, even_term: '3-565', even_term_index: 0, odd_term: '47-2940', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '9-98', phase_index: 0, even_term: '33-1893', even_term_index: 2, odd_term: '18-1229', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '38-2481', phase_index: 0, even_term: '4-182', even_term_index: 4, odd_term: '48-2557', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '8-1533', phase_index: 0, even_term: '34-1510', even_term_index: 6, odd_term: '19-846', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '38-308', phase_index: 0, even_term: '4-2839', even_term_index: 8, odd_term: '49-2175', odd_term_index: 7 },
    # 計算上では4が小の月、5が大の月
    { is_many_days: false, month: 4, leaped: false, remainder: '7-1700', phase_index: 0, even_term: '35-1127', even_term_index: 10, odd_term: '20-463', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '36-2820', phase_index: 0, even_term: '5-2456', even_term_index: 12, odd_term: '50-1792', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true, remainder: '6-625', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '21-80', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '35-1372', phase_index: 0, even_term: '36-745', even_term_index: 14, odd_term: '51-1409', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '4-2328', phase_index: 0, even_term: '6-2073', even_term_index: 16, odd_term: '21-2737', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '34-503', phase_index: 0, even_term: '37-362', even_term_index: 18, odd_term: '52-1026', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '3-1988', phase_index: 0, even_term: '7-1690', even_term_index: 20, odd_term: '22-2355', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '33-873', phase_index: 0, even_term: '37-3019', even_term_index: 22, odd_term: '53-643', odd_term_index: 23 }
  ],
  780 => [
    # 計算上では11が小の月、（12を飛ばして）1が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '3-54', phase_index: 0, even_term: '8-1308', even_term_index: 0, odd_term: '23-1972', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '32-2481', phase_index: 0, even_term: '38-2636', even_term_index: 2, odd_term: '54-260', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '2-1828', phase_index: 0, even_term: '9-925', even_term_index: 4, odd_term: '24-1589', odd_term_index: 5 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '32-954', phase_index: 0, even_term: '39-2253', even_term_index: 6, odd_term: '54-2918', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '1-2852', phase_index: 0, even_term: '10-542', even_term_index: 8, odd_term: '25-1206', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '31-1439', phase_index: 0, even_term: '40-1870', even_term_index: 10, odd_term: '55-2535', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '0-2637', phase_index: 0, even_term: '11-159', even_term_index: 12, odd_term: '26-823', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '30-563', phase_index: 0, even_term: '41-1488', even_term_index: 14, odd_term: '56-2152', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '59-1479', phase_index: 0, even_term: '11-2816', even_term_index: 16, odd_term: '27-440', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '28-2405', phase_index: 0, even_term: '42-1105', even_term_index: 18, odd_term: '57-1769', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '58-503', phase_index: 0, even_term: '12-2433', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '27-1911', phase_index: 0, even_term: '43-722', even_term_index: 22, odd_term: '28-58', odd_term_index: 21 },
    # 計算上では11が小の月、（12を飛ばして）1が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '57-569', phase_index: 0, even_term: '13-2051', even_term_index: 0, odd_term: '58-1386', odd_term_index: 23 }
  ],
  781 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '57-569', phase_index: 0, even_term: '13-2051', even_term_index: 0, odd_term: '58-1386', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '26-2711', phase_index: 0, even_term: '44-339', even_term_index: 2, odd_term: '28-2715', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '56-1857', phase_index: 0, even_term: '14-1668', even_term_index: 4, odd_term: '59-1003', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '26-1031', phase_index: 0, even_term: '44-2996', even_term_index: 6, odd_term: '29-2332', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '56-188', phase_index: 0, even_term: '15-1285', even_term_index: 8, odd_term: '0-621', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '25-2167', phase_index: 0, even_term: '45-2613', even_term_index: 10, odd_term: '30-1949', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '55-842', phase_index: 0, even_term: '16-902', even_term_index: 12, odd_term: '1-238', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '24-2269', phase_index: 0, even_term: '46-2231', even_term_index: 14, odd_term: '31-1566', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '54-412', phase_index: 0, even_term: '17-519', even_term_index: 16, odd_term: '1-2895', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '23-1543', phase_index: 0, even_term: '47-1848', even_term_index: 18, odd_term: '32-1183', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '52-2625', phase_index: 0, even_term: '18-136', even_term_index: 20, odd_term: '2-2512', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '22-688', phase_index: 0, even_term: '48-1465', even_term_index: 22, odd_term: '33-801', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '51-2024', phase_index: 0, even_term: '18-2794', even_term_index: 0, odd_term: '3-2129', odd_term_index: 23 }
  ],
  782 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '51-2024', phase_index: 0, even_term: '18-2794', even_term_index: 0, odd_term: '3-2129', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '21-621', phase_index: 0, even_term: '49-1082', even_term_index: 2, odd_term: '34-418', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '50-2408', phase_index: 0, even_term: '19-2411', even_term_index: 4, odd_term: '4-1746', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: true, remainder: '20-1320', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '35-35', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '50-278', phase_index: 0, even_term: '50-699', even_term_index: 6, odd_term: '5-1364', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '19-2318', phase_index: 0, even_term: '20-2028', even_term_index: 8, odd_term: '35-2692', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '49-1298', phase_index: 0, even_term: '51-316', even_term_index: 10, odd_term: '6-981', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '19-45', phase_index: 0, even_term: '21-1645', even_term_index: 12, odd_term: '36-2309', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '48-1654', phase_index: 0, even_term: '51-2974', even_term_index: 14, odd_term: '7-598', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '18-155', phase_index: 0, even_term: '22-1262', even_term_index: 16, odd_term: '37-1926', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '47-1508', phase_index: 0, even_term: '52-2591', even_term_index: 18, odd_term: '8-215', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '16-2808', phase_index: 0, even_term: '23-879', even_term_index: 20, odd_term: '38-1544', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '46-1026', phase_index: 0, even_term: '53-2208', even_term_index: 22, odd_term: '8-2872', odd_term_index: 23 }
  ],
  783 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '15-2336', phase_index: 0, even_term: '24-497', even_term_index: 0, odd_term: '39-1161', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '45-803', phase_index: 0, even_term: '54-1825', even_term_index: 2, odd_term: '9-2489', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '14-2330', phase_index: 0, even_term: '25-114', even_term_index: 4, odd_term: '40-778', odd_term_index: 5 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '44-883', phase_index: 0, even_term: '55-1442', even_term_index: 6, odd_term: '10-2107', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '13-2656', phase_index: 0, even_term: '25-2771', even_term_index: 8, odd_term: '41-395', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '43-1444', phase_index: 0, even_term: '56-1059', even_term_index: 10, odd_term: '11-1724', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '13-276', phase_index: 0, even_term: '26-2388', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 6, leaped: false, remainder: '42-2136', phase_index: 0, even_term: '57-677', even_term_index: 14, odd_term: '42-12', odd_term_index: 13 },
    # 計算上では7が小の月、8が大の月
    { is_many_days: false, month: 7, leaped: false, remainder: '12-928', phase_index: 0, even_term: '27-2005', even_term_index: 16, odd_term: '12-1341', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '41-2713', phase_index: 0, even_term: '58-294', even_term_index: 18, odd_term: '42-2669', odd_term_index: 17 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '11-1370', phase_index: 0, even_term: '28-1622', even_term_index: 20, odd_term: '13-958', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '40-2894', phase_index: 0, even_term: '58-2951', even_term_index: 22, odd_term: '43-2287', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '10-1339', phase_index: 0, even_term: '29-1240', even_term_index: 0, odd_term: '14-575', odd_term_index: 23 }
  ],
  784 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '10-1339', phase_index: 0, even_term: '29-1240', even_term_index: 0, odd_term: '14-575', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '39-2806', phase_index: 0, even_term: '59-2568', even_term_index: 2, odd_term: '44-1904', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '9-1068', phase_index: 0, even_term: '30-857', even_term_index: 4, odd_term: '15-192', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '38-2368', phase_index: 0, even_term: '0-2185', even_term_index: 6, odd_term: '45-1521', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '8-669', phase_index: 0, even_term: '31-474', even_term_index: 8, odd_term: '15-2850', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '37-2100', phase_index: 0, even_term: '1-1802', even_term_index: 10, odd_term: '46-1138', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '7-665', phase_index: 0, even_term: '32-91', even_term_index: 12, odd_term: '16-2467', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '36-2318', phase_index: 0, even_term: '2-1420', even_term_index: 14, odd_term: '47-755', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '6-1123', phase_index: 0, even_term: '32-2748', even_term_index: 16, odd_term: '17-2084', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '36-106', phase_index: 0, even_term: '3-1037', even_term_index: 18, odd_term: '48-372', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '5-2104', phase_index: 0, even_term: '33-2365', even_term_index: 20, odd_term: '18-1701', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: true, remainder: '35-1019', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '48-3030', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '4-2886', phase_index: 0, even_term: '4-654', even_term_index: 22, odd_term: '19-1318', odd_term_index: 23 }
  ],
  785 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '34-1579', phase_index: 0, even_term: '34-1983', even_term_index: 0, odd_term: '49-2647', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '4-115', phase_index: 0, even_term: '5-271', even_term_index: 2, odd_term: '20-935', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '33-1394', phase_index: 0, even_term: '35-1600', even_term_index: 4, odd_term: '50-2264', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '2-2501', phase_index: 0, even_term: '5-2928', even_term_index: 6, odd_term: '21-553', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '32-584', phase_index: 0, even_term: '36-1217', even_term_index: 8, odd_term: '51-1881', odd_term_index: 9 },
    # 計算上では4が小の月、5が大の月
    { is_many_days: false, month: 4, leaped: false, remainder: '1-1760', phase_index: 0, even_term: '6-2545', even_term_index: 10, odd_term: '22-170', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '30-3026', phase_index: 0, even_term: '37-834', even_term_index: 12, odd_term: '52-1498', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '0-1483', phase_index: 0, even_term: '7-2163', even_term_index: 14, odd_term: '22-2827', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '30-217', phase_index: 0, even_term: '38-451', even_term_index: 16, odd_term: '53-1115', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '59-2249', phase_index: 0, even_term: '8-1780', even_term_index: 18, odd_term: '23-2444', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '29-1403', phase_index: 0, even_term: '39-68', even_term_index: 20, odd_term: '54-733', odd_term_index: 21 },
    # 計算上では10が小の月、11が大の月
    { is_many_days: false, month: 10, leaped: false, remainder: '59-538', phase_index: 0, even_term: '9-1397', even_term_index: 22, odd_term: '24-2061', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '28-2684', phase_index: 0, even_term: '39-2726', even_term_index: 0, odd_term: '55-350', odd_term_index: 1 }
  ],
  786 => [
    # 計算上では10が小の月、11が大の月
    { is_many_days: true, month: 11, leaped: false, remainder: '28-2684', phase_index: 0, even_term: '39-2726', even_term_index: 0, odd_term: '55-350', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '58-1676', phase_index: 0, even_term: '10-1014', even_term_index: 2, odd_term: '25-1678', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '28-271', phase_index: 0, even_term: '40-2343', even_term_index: 4, odd_term: '55-3007', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '57-1619', phase_index: 0, even_term: '11-631', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 3, leaped: false, remainder: '26-2703', phase_index: 0, even_term: '41-1960', even_term_index: 8, odd_term: '26-1296', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '56-596', phase_index: 0, even_term: '12-248', even_term_index: 10, odd_term: '56-2624', odd_term_index: 9 },
    # 計算上では5が小の月、6が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '25-1553', phase_index: 0, even_term: '42-1577', even_term_index: 12, odd_term: '27-913', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '54-2569', phase_index: 0, even_term: '12-2906', even_term_index: 14, odd_term: '57-2241', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '24-841', phase_index: 0, even_term: '43-1194', even_term_index: 16, odd_term: '28-530', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '53-2530', phase_index: 0, even_term: '13-2523', even_term_index: 18, odd_term: '58-1858', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '23-1446', phase_index: 0, even_term: '44-811', even_term_index: 20, odd_term: '29-147', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '53-624', phase_index: 0, even_term: '14-2140', even_term_index: 22, odd_term: '59-1476', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '22-3007', phase_index: 0, even_term: '45-429', even_term_index: 0, odd_term: '29-2804', odd_term_index: 23 }
  ],
  787 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '22-3007', phase_index: 0, even_term: '45-429', even_term_index: 0, odd_term: '29-2804', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '52-2352', phase_index: 0, even_term: '15-1757', even_term_index: 2, odd_term: '0-1093', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '22-1470', phase_index: 0, even_term: '46-46', even_term_index: 4, odd_term: '30-2421', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '52-232', phase_index: 0, even_term: '16-1374', even_term_index: 6, odd_term: '1-710', odd_term_index: 5 },
    # 計算上では3が小の月、4が大の月
    { is_many_days: false, month: 3, leaped: false, remainder: '21-1664', phase_index: 0, even_term: '46-2703', even_term_index: 8, odd_term: '31-2039', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '50-2822', phase_index: 0, even_term: '17-991', even_term_index: 10, odd_term: '2-327', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '20-685', phase_index: 0, even_term: '47-2320', even_term_index: 12, odd_term: '32-1656', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true, remainder: '49-1438', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '2-2984', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '18-2343', phase_index: 0, even_term: '18-609', even_term_index: 14, odd_term: '33-1273', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '48-481', phase_index: 0, even_term: '48-1937', even_term_index: 16, odd_term: '3-2601', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '17-1988', phase_index: 0, even_term: '19-226', even_term_index: 18, odd_term: '34-890', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '47-823', phase_index: 0, even_term: '49-1554', even_term_index: 20, odd_term: '4-2219', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '16-2974', phase_index: 0, even_term: '19-2883', even_term_index: 22, odd_term: '35-507', odd_term_index: 23 }
  ],
  788 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '46-2372', phase_index: 0, even_term: '50-1172', even_term_index: 0, odd_term: '5-1836', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '16-1838', phase_index: 0, even_term: '20-2500', even_term_index: 2, odd_term: '36-124', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '46-1017', phase_index: 0, even_term: '51-789', even_term_index: 4, odd_term: '6-1453', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '15-2959', phase_index: 0, even_term: '21-2117', even_term_index: 6, odd_term: '36-2782', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '45-1520', phase_index: 0, even_term: '52-406', even_term_index: 8, odd_term: '7-1070', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '14-2764', phase_index: 0, even_term: '22-1734', even_term_index: 10, odd_term: '37-2399', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '44-696', phase_index: 0, even_term: '53-23', even_term_index: 12, odd_term: '8-687', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '13-1454', phase_index: 0, even_term: '23-1352', even_term_index: 14, odd_term: '38-2016', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '42-2303', phase_index: 0, even_term: '53-2680', even_term_index: 16, odd_term: '9-304', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '12-360', phase_index: 0, even_term: '24-969', even_term_index: 18, odd_term: '39-1633', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '41-1721', phase_index: 0, even_term: '54-2297', even_term_index: 20, odd_term: '9-2962', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '11-388', phase_index: 0, even_term: '25-586', even_term_index: 22, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 11, leaped: false, remainder: '40-2471', phase_index: 0, even_term: '55-1915', even_term_index: 0, odd_term: '40-1250', odd_term_index: 23 }
  ],
  789 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '40-2471', phase_index: 0, even_term: '55-1915', even_term_index: 0, odd_term: '40-1250', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '10-1789', phase_index: 0, even_term: '26-203', even_term_index: 2, odd_term: '10-2579', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '40-1136', phase_index: 0, even_term: '56-1532', even_term_index: 4, odd_term: '41-867', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '10-376', phase_index: 0, even_term: '26-2860', even_term_index: 6, odd_term: '11-2196', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '39-2398', phase_index: 0, even_term: '57-1149', even_term_index: 8, odd_term: '42-485', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '9-1111', phase_index: 0, even_term: '27-2477', even_term_index: 10, odd_term: '12-1813', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '38-2520', phase_index: 0, even_term: '58-766', even_term_index: 12, odd_term: '43-102', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '8-539', phase_index: 0, even_term: '28-2095', even_term_index: 14, odd_term: '13-1430', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '37-1503', phase_index: 0, even_term: '59-383', even_term_index: 16, odd_term: '43-2759', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '6-2433', phase_index: 0, even_term: '29-1712', even_term_index: 18, odd_term: '14-1047', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '36-420', phase_index: 0, even_term: '0-0', even_term_index: 20, odd_term: '44-2376', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '5-1704', phase_index: 0, even_term: '30-1329', even_term_index: 22, odd_term: '15-665', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '35-227', phase_index: 0, even_term: '0-2658', even_term_index: 0, odd_term: '45-1993', odd_term_index: 23 }
  ],
  790 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '35-227', phase_index: 0, even_term: '0-2658', even_term_index: 0, odd_term: '45-1993', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '4-2172', phase_index: 0, even_term: '31-946', even_term_index: 2, odd_term: '16-282', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '34-1276', phase_index: 0, even_term: '1-2275', even_term_index: 4, odd_term: '46-1610', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '4-402', phase_index: 0, even_term: '32-563', even_term_index: 6, odd_term: '16-2939', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '33-2598', phase_index: 0, even_term: '2-1892', even_term_index: 8, odd_term: '47-1228', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: true, remainder: '3-1652', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '17-2556', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '33-449', phase_index: 0, even_term: '33-180', even_term_index: 10, odd_term: '48-845', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '2-2010', phase_index: 0, even_term: '3-1509', even_term_index: 12, odd_term: '18-2173', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '32-277', phase_index: 0, even_term: '33-2838', even_term_index: 14, odd_term: '49-462', odd_term_index: 15 },
    # 計算上では7が小の月、8が大の月
    { is_many_days: false, month: 7, leaped: false, remainder: '1-1465', phase_index: 0, even_term: '4-1126', even_term_index: 16, odd_term: '19-1790', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '30-2600', phase_index: 0, even_term: '34-2455', even_term_index: 18, odd_term: '50-79', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '0-658', phase_index: 0, even_term: '5-743', even_term_index: 20, odd_term: '20-1408', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '29-1875', phase_index: 0, even_term: '35-2072', even_term_index: 22, odd_term: '50-2736', odd_term_index: 23 }
  ],
  791 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '59-337', phase_index: 0, even_term: '6-361', even_term_index: 0, odd_term: '21-1025', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '28-2060', phase_index: 0, even_term: '36-1689', even_term_index: 2, odd_term: '51-2353', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '58-849', phase_index: 0, even_term: '6-3018', even_term_index: 4, odd_term: '22-642', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '27-2791', phase_index: 0, even_term: '37-1306', even_term_index: 6, odd_term: '52-1971', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '57-1740', phase_index: 0, even_term: '7-2635', even_term_index: 8, odd_term: '23-259', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '27-726', phase_index: 0, even_term: '38-923', even_term_index: 10, odd_term: '53-1588', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '56-2635', phase_index: 0, even_term: '8-2252', even_term_index: 12, odd_term: '23-2916', odd_term_index: 13 },
    # 計算上では6が小の月、7が大の月
    { is_many_days: false, month: 6, leaped: false, remainder: '26-1274', phase_index: 0, even_term: '39-541', even_term_index: 14, odd_term: '54-1205', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '55-2892', phase_index: 0, even_term: '9-1869', even_term_index: 16, odd_term: '24-2533', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '25-1327', phase_index: 0, even_term: '40-158', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 9, leaped: false, remainder: '54-2680', phase_index: 0, even_term: '10-1486', even_term_index: 20, odd_term: '55-822', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '24-946', phase_index: 0, even_term: '40-2815', even_term_index: 22, odd_term: '25-2151', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '53-2234', phase_index: 0, even_term: '11-1104', even_term_index: 0, odd_term: '56-439', odd_term_index: 23 }
  ],
  792 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '53-2234', phase_index: 0, even_term: '11-1104', even_term_index: 0, odd_term: '56-439', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '23-627', phase_index: 0, even_term: '41-2432', even_term_index: 2, odd_term: '26-1768', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '52-2109', phase_index: 0, even_term: '12-721', even_term_index: 4, odd_term: '57-56', odd_term_index: 3 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '22-583', phase_index: 0, even_term: '42-2049', even_term_index: 6, odd_term: '27-1385', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '51-2238', phase_index: 0, even_term: '13-338', even_term_index: 8, odd_term: '57-2714', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '21-968', phase_index: 0, even_term: '43-1666', even_term_index: 10, odd_term: '28-1002', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '50-2792', phase_index: 0, even_term: '13-2995', even_term_index: 12, odd_term: '58-2331', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '20-1601', phase_index: 0, even_term: '44-1284', even_term_index: 14, odd_term: '29-619', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '50-440', phase_index: 0, even_term: '14-2612', even_term_index: 16, odd_term: '59-1948', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '19-2280', phase_index: 0, even_term: '45-901', even_term_index: 18, odd_term: '30-236', odd_term_index: 17 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '49-1025', phase_index: 0, even_term: '15-2229', even_term_index: 20, odd_term: '0-1565', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '18-2659', phase_index: 0, even_term: '46-518', even_term_index: 22, odd_term: '30-2894', odd_term_index: 21 },
    # 計算上では11が小の月、閏11が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '48-1153', phase_index: 0, even_term: '16-1847', even_term_index: 0, odd_term: '1-1182', odd_term_index: 23 }
  ],
  793 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '48-1153', phase_index: 0, even_term: '16-1847', even_term_index: 0, odd_term: '1-1182', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: true, remainder: '17-2671', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '31-2511', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '47-998', phase_index: 0, even_term: '47-135', even_term_index: 2, odd_term: '2-799', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '16-2249', phase_index: 0, even_term: '17-1464', even_term_index: 4, odd_term: '32-2128', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '46-500', phase_index: 0, even_term: '47-2792', even_term_index: 6, odd_term: '3-417', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '15-1838', phase_index: 0, even_term: '18-1081', even_term_index: 8, odd_term: '33-1745', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '45-297', phase_index: 0, even_term: '48-2409', even_term_index: 10, odd_term: '4-34', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '14-1895', phase_index: 0, even_term: '19-698', even_term_index: 12, odd_term: '34-1362', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '44-579', phase_index: 0, even_term: '49-2027', even_term_index: 14, odd_term: '4-2691', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '13-2557', phase_index: 0, even_term: '20-315', even_term_index: 16, odd_term: '35-979', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '43-1567', phase_index: 0, even_term: '50-1644', even_term_index: 18, odd_term: '5-2308', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '13-534', phase_index: 0, even_term: '20-2972', even_term_index: 20, odd_term: '36-597', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '42-2493', phase_index: 0, even_term: '51-1261', even_term_index: 22, odd_term: '6-1925', odd_term_index: 23 }
  ],
  794 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '12-1274', phase_index: 0, even_term: '21-2590', even_term_index: 0, odd_term: '37-214', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '41-2974', phase_index: 0, even_term: '52-878', even_term_index: 2, odd_term: '7-1542', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '11-1337', phase_index: 0, even_term: '22-2207', even_term_index: 4, odd_term: '37-2871', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '40-2485', phase_index: 0, even_term: '53-495', even_term_index: 6, odd_term: '8-1160', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '10-519', phase_index: 0, even_term: '23-1824', even_term_index: 8, odd_term: '38-2488', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '39-1639', phase_index: 0, even_term: '54-112', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '8-2810', phase_index: 0, even_term: '24-1441', even_term_index: 12, odd_term: '9-777', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '38-1120', phase_index: 0, even_term: '54-2770', even_term_index: 14, odd_term: '39-2105', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '7-2768', phase_index: 0, even_term: '25-1058', even_term_index: 16, odd_term: '10-394', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '37-1644', phase_index: 0, even_term: '55-2387', even_term_index: 18, odd_term: '40-1722', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '7-762', phase_index: 0, even_term: '26-675', even_term_index: 20, odd_term: '11-11', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '36-2985', phase_index: 0, even_term: '56-2004', even_term_index: 22, odd_term: '41-1340', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '6-2136', phase_index: 0, even_term: '27-293', even_term_index: 0, odd_term: '11-2668', odd_term_index: 23 }
  ],
  795 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '6-2136', phase_index: 0, even_term: '27-293', even_term_index: 0, odd_term: '11-2668', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '36-1263', phase_index: 0, even_term: '57-1621', even_term_index: 2, odd_term: '42-957', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '6-32', phase_index: 0, even_term: '27-2950', even_term_index: 4, odd_term: '12-2285', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '35-1505', phase_index: 0, even_term: '58-1238', even_term_index: 6, odd_term: '43-574', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '4-2708', phase_index: 0, even_term: '28-2567', even_term_index: 8, odd_term: '13-1903', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '34-632', phase_index: 0, even_term: '59-855', even_term_index: 10, odd_term: '44-191', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '3-1540', phase_index: 0, even_term: '29-2184', even_term_index: 12, odd_term: '14-1520', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '32-2484', phase_index: 0, even_term: '0-473', even_term_index: 14, odd_term: '44-2848', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '2-575', phase_index: 0, even_term: '30-1801', even_term_index: 16, odd_term: '15-1137', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: true, remainder: '31-2105', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '45-2465', odd_term_index: 17 },
    # 計算上では8が小の月、9が大の月
    { is_many_days: false, month: 8, leaped: false, remainder: '1-897', phase_index: 0, even_term: '1-90', even_term_index: 18, odd_term: '16-754', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '30-2999', phase_index: 0, even_term: '31-1418', even_term_index: 20, odd_term: '46-2083', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '0-2306', phase_index: 0, even_term: '1-2747', even_term_index: 22, odd_term: '17-371', odd_term_index: 23 }
  ],
  796 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '30-1697', phase_index: 0, even_term: '32-1036', even_term_index: 0, odd_term: '47-1700', odd_term_index: 1 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '0-953', phase_index: 0, even_term: '2-2364', even_term_index: 2, odd_term: '17-3028', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '29-2943', phase_index: 0, even_term: '33-653', even_term_index: 4, odd_term: '48-1317', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '59-1488', phase_index: 0, even_term: '3-1981', even_term_index: 6, odd_term: '18-2646', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '28-2769', phase_index: 0, even_term: '34-270', even_term_index: 8, odd_term: '49-934', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '58-748', phase_index: 0, even_term: '4-1598', even_term_index: 10, odd_term: '19-2263', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '27-1529', phase_index: 0, even_term: '34-2927', even_term_index: 12, odd_term: '50-551', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '56-2318', phase_index: 0, even_term: '5-1216', even_term_index: 14, odd_term: '20-1880', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '26-332', phase_index: 0, even_term: '35-2544', even_term_index: 16, odd_term: '51-168', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '55-1654', phase_index: 0, even_term: '6-833', even_term_index: 18, odd_term: '21-1497', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '25-338', phase_index: 0, even_term: '36-2161', even_term_index: 20, odd_term: '51-2826', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '54-2361', phase_index: 0, even_term: '7-450', even_term_index: 22, odd_term: '22-1114', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '24-1632', phase_index: 0, even_term: '37-1779', even_term_index: 0, odd_term: '52-2443', odd_term_index: 1 }
  ],
  797 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '24-1632', phase_index: 0, even_term: '37-1779', even_term_index: 0, odd_term: '52-2443', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '54-1133', phase_index: 0, even_term: '8-67', even_term_index: 2, odd_term: '23-731', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '24-440', phase_index: 0, even_term: '38-1396', even_term_index: 4, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 2, leaped: false, remainder: '53-2506', phase_index: 0, even_term: '8-2724', even_term_index: 6, odd_term: '53-2060', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '23-1260', phase_index: 0, even_term: '39-1013', even_term_index: 8, odd_term: '24-349', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '52-2649', phase_index: 0, even_term: '9-2341', even_term_index: 10, odd_term: '54-1677', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '22-706', phase_index: 0, even_term: '40-630', even_term_index: 12, odd_term: '24-3006', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '51-1542', phase_index: 0, even_term: '10-1959', even_term_index: 14, odd_term: '55-1294', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '20-2338', phase_index: 0, even_term: '41-247', even_term_index: 16, odd_term: '25-2623', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '50-276', phase_index: 0, even_term: '11-1576', even_term_index: 18, odd_term: '56-911', odd_term_index: 17 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '19-1512', phase_index: 0, even_term: '41-2904', even_term_index: 20, odd_term: '26-2240', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '48-3021', phase_index: 0, even_term: '12-1193', even_term_index: 22, odd_term: '57-529', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '18-1915', phase_index: 0, even_term: '42-2522', even_term_index: 0, odd_term: '27-1857', odd_term_index: 23 }
  ],
  798 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '18-1915', phase_index: 0, even_term: '42-2522', even_term_index: 0, odd_term: '27-1857', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '48-1129', phase_index: 0, even_term: '13-810', even_term_index: 2, odd_term: '58-146', odd_term_index: 1 },
    # 計算上では1が小の月、2が大の月
    { is_many_days: false, month: 1, leaped: false, remainder: '18-445', phase_index: 0, even_term: '43-2139', even_term_index: 4, odd_term: '28-1474', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '47-2780', phase_index: 0, even_term: '14-427', even_term_index: 6, odd_term: '58-2803', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '17-1883', phase_index: 0, even_term: '44-1756', even_term_index: 8, odd_term: '29-1092', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '47-720', phase_index: 0, even_term: '15-44', even_term_index: 10, odd_term: '59-2420', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '16-2329', phase_index: 0, even_term: '45-1373', even_term_index: 12, odd_term: '30-709', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true, remainder: '46-476', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '0-2037', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '15-1492', phase_index: 0, even_term: '15-2702', even_term_index: 14, odd_term: '31-326', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '44-2465', phase_index: 0, even_term: '46-990', even_term_index: 16, odd_term: '1-1654', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '14-396', phase_index: 0, even_term: '16-2319', even_term_index: 18, odd_term: '31-2983', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '43-1558', phase_index: 0, even_term: '47-607', even_term_index: 20, odd_term: '2-1272', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '12-2991', phase_index: 0, even_term: '17-1936', even_term_index: 22, odd_term: '32-2600', odd_term_index: 23 }
  ],
  799 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '42-1678', phase_index: 0, even_term: '48-225', even_term_index: 0, odd_term: '3-889', odd_term_index: 1 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '12-731', phase_index: 0, even_term: '18-1553', even_term_index: 2, odd_term: '33-2217', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '41-2849', phase_index: 0, even_term: '48-2882', even_term_index: 4, odd_term: '4-506', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '11-1963', phase_index: 0, even_term: '19-1170', even_term_index: 6, odd_term: '34-1835', odd_term_index: 7 },
    # 計算上では3が小の月、4が大の月
    { is_many_days: false, month: 3, leaped: false, remainder: '41-1077', phase_index: 0, even_term: '49-2499', even_term_index: 8, odd_term: '5-123', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '10-3034', phase_index: 0, even_term: '20-787', even_term_index: 10, odd_term: '35-1452', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '40-1683', phase_index: 0, even_term: '50-2116', even_term_index: 12, odd_term: '5-2780', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '10-98', phase_index: 0, even_term: '21-405', even_term_index: 14, odd_term: '36-1069', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '39-1347', phase_index: 0, even_term: '51-1733', even_term_index: 16, odd_term: '6-2397', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '8-2536', phase_index: 0, even_term: '22-22', even_term_index: 18, odd_term: '37-686', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '38-636', phase_index: 0, even_term: '52-1350', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '7-1787', phase_index: 0, even_term: '22-2679', even_term_index: 22, odd_term: '7-2015', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '37-115', phase_index: 0, even_term: '53-968', even_term_index: 0, odd_term: '38-303', odd_term_index: 23 }
  ],
  800 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '37-115', phase_index: 0, even_term: '53-968', even_term_index: 0, odd_term: '38-303', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '6-1762', phase_index: 0, even_term: '23-2296', even_term_index: 2, odd_term: '8-1632', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '36-415', phase_index: 0, even_term: '54-585', even_term_index: 4, odd_term: '38-2960', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '5-2304', phase_index: 0, even_term: '24-1913', even_term_index: 6, odd_term: '9-1249', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '35-1201', phase_index: 0, even_term: '55-202', even_term_index: 8, odd_term: '39-2578', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '5-145', phase_index: 0, even_term: '25-1530', even_term_index: 10, odd_term: '10-866', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '34-2124', phase_index: 0, even_term: '55-2859', even_term_index: 12, odd_term: '40-2195', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '4-855', phase_index: 0, even_term: '26-1148', even_term_index: 14, odd_term: '11-483', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '33-2526', phase_index: 0, even_term: '56-2476', even_term_index: 16, odd_term: '41-1812', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '3-1105', phase_index: 0, even_term: '27-765', even_term_index: 18, odd_term: '12-100', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '32-2511', phase_index: 0, even_term: '57-2093', even_term_index: 20, odd_term: '42-1429', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '2-830', phase_index: 0, even_term: '28-382', even_term_index: 22, odd_term: '12-2758', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '31-2152', phase_index: 0, even_term: '58-1711', even_term_index: 0, odd_term: '43-1046', odd_term_index: 23 }
  ],
  801 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '31-2152', phase_index: 0, even_term: '58-1711', even_term_index: 0, odd_term: '43-1046', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '1-480', phase_index: 0, even_term: '28-3039', even_term_index: 2, odd_term: '13-2375', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '30-1924', phase_index: 0, even_term: '59-1328', even_term_index: 4, odd_term: '44-663', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: true, remainder: '0-345', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '14-1992', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '29-1854', phase_index: 0, even_term: '29-2656', even_term_index: 6, odd_term: '45-281', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '59-533', phase_index: 0, even_term: '0-945', even_term_index: 8, odd_term: '15-1609', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '28-2303', phase_index: 0, even_term: '30-2273', even_term_index: 10, odd_term: '45-2938', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '58-1072', phase_index: 0, even_term: '1-562', even_term_index: 12, odd_term: '16-1226', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '27-2957', phase_index: 0, even_term: '31-1891', even_term_index: 14, odd_term: '46-2555', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '57-1809', phase_index: 0, even_term: '2-179', even_term_index: 16, odd_term: '17-843', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '27-612', phase_index: 0, even_term: '32-1508', even_term_index: 18, odd_term: '47-2172', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '56-2387', phase_index: 0, even_term: '2-2836', even_term_index: 20, odd_term: '18-461', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '26-932', phase_index: 0, even_term: '33-1125', even_term_index: 22, odd_term: '48-1789', odd_term_index: 23 }
  ],
  802 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '55-2489', phase_index: 0, even_term: '3-2454', even_term_index: 0, odd_term: '19-78', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '25-924', phase_index: 0, even_term: '34-742', even_term_index: 2, odd_term: '49-1406', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '54-2170', phase_index: 0, even_term: '4-2071', even_term_index: 4, odd_term: '19-2735', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '24-370', phase_index: 0, even_term: '35-359', even_term_index: 6, odd_term: '50-1024', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '53-1653', phase_index: 0, even_term: '5-1688', even_term_index: 8, odd_term: '20-2352', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '22-3004', phase_index: 0, even_term: '35-3016', even_term_index: 10, odd_term: '51-641', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '52-1512', phase_index: 0, even_term: '6-1305', even_term_index: 12, odd_term: '21-1969', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '22-95', phase_index: 0, even_term: '36-2634', even_term_index: 14, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 7, leaped: false, remainder: '51-1967', phase_index: 0, even_term: '7-922', even_term_index: 16, odd_term: '52-258', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '21-993', phase_index: 0, even_term: '37-2251', even_term_index: 18, odd_term: '22-1586', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '51-11', phase_index: 0, even_term: '8-539', even_term_index: 20, odd_term: '52-2915', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '20-2025', phase_index: 0, even_term: '38-1868', even_term_index: 22, odd_term: '23-1204', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '50-937', phase_index: 0, even_term: '9-157', even_term_index: 0, odd_term: '53-2532', odd_term_index: 23 }
  ],
  803 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '50-937', phase_index: 0, even_term: '9-157', even_term_index: 0, odd_term: '53-2532', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '19-2729', phase_index: 0, even_term: '39-1485', even_term_index: 2, odd_term: '24-821', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '49-1225', phase_index: 0, even_term: '9-2814', even_term_index: 4, odd_term: '54-2149', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '18-2477', phase_index: 0, even_term: '40-1102', even_term_index: 6, odd_term: '25-438', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '48-490', phase_index: 0, even_term: '10-2431', even_term_index: 8, odd_term: '55-1767', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '17-1557', phase_index: 0, even_term: '41-719', even_term_index: 10, odd_term: '26-55', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '46-2674', phase_index: 0, even_term: '11-2048', even_term_index: 12, odd_term: '56-1384', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '16-822', phase_index: 0, even_term: '42-337', even_term_index: 14, odd_term: '26-2712', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '45-2343', phase_index: 0, even_term: '12-1665', even_term_index: 16, odd_term: '57-1001', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '15-1099', phase_index: 0, even_term: '42-2994', even_term_index: 18, odd_term: '27-2329', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '45-113', phase_index: 0, even_term: '13-1282', even_term_index: 20, odd_term: '58-618', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '14-2357', phase_index: 0, even_term: '43-2611', even_term_index: 22, odd_term: '28-1947', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: true, remainder: '44-1554', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '59-235', odd_term_index: 23 }
  ],
  804 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '14-736', phase_index: 0, even_term: '14-900', even_term_index: 0, odd_term: '29-1564', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '43-2770', phase_index: 0, even_term: '44-2228', even_term_index: 2, odd_term: '59-2892', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '13-1333', phase_index: 0, even_term: '15-517', even_term_index: 4, odd_term: '30-1181', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '42-2659', phase_index: 0, even_term: '45-1845', even_term_index: 6, odd_term: '0-2510', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '12-678', phase_index: 0, even_term: '16-134', even_term_index: 8, odd_term: '31-798', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '41-1561', phase_index: 0, even_term: '46-1462', even_term_index: 10, odd_term: '1-2127', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '10-2456', phase_index: 0, even_term: '16-2791', even_term_index: 12, odd_term: '32-415', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '40-424', phase_index: 0, even_term: '47-1080', even_term_index: 14, odd_term: '2-1744', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '9-1742', phase_index: 0, even_term: '17-2408', even_term_index: 16, odd_term: '33-32', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '39-411', phase_index: 0, even_term: '48-697', even_term_index: 18, odd_term: '3-1361', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '8-2390', phase_index: 0, even_term: '18-2025', even_term_index: 20, odd_term: '33-2690', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '38-1597', phase_index: 0, even_term: '49-314', even_term_index: 22, odd_term: '4-978', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '8-1001', phase_index: 0, even_term: '19-1643', even_term_index: 0, odd_term: '34-2307', odd_term_index: 1 }
  ],
  805 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '8-1001', phase_index: 0, even_term: '19-1643', even_term_index: 0, odd_term: '34-2307', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '38-372', phase_index: 0, even_term: '49-2971', even_term_index: 2, odd_term: '5-595', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '7-2495', phase_index: 0, even_term: '20-1260', even_term_index: 4, odd_term: '35-1924', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '37-1252', phase_index: 0, even_term: '50-2588', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 3, leaped: false, remainder: '6-2658', phase_index: 0, even_term: '21-877', even_term_index: 8, odd_term: '6-213', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '36-757', phase_index: 0, even_term: '51-2205', even_term_index: 10, odd_term: '36-1541', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '5-1634', phase_index: 0, even_term: '22-494', even_term_index: 12, odd_term: '6-2870', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '34-2353', phase_index: 0, even_term: '52-1823', even_term_index: 14, odd_term: '37-1158', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '4-245', phase_index: 0, even_term: '23-111', even_term_index: 16, odd_term: '7-2487', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '33-1444', phase_index: 0, even_term: '53-1440', even_term_index: 18, odd_term: '38-775', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '2-2953', phase_index: 0, even_term: '23-2768', even_term_index: 20, odd_term: '8-2104', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '32-1811', phase_index: 0, even_term: '54-1057', even_term_index: 22, odd_term: '39-393', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '2-951', phase_index: 0, even_term: '24-2386', even_term_index: 0, odd_term: '9-1721', odd_term_index: 23 }
  ],
  806 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '2-951', phase_index: 0, even_term: '24-2386', even_term_index: 0, odd_term: '9-1721', odd_term_index: 23 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '32-385', phase_index: 0, even_term: '55-674', even_term_index: 2, odd_term: '40-10', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '1-2844', phase_index: 0, even_term: '25-2003', even_term_index: 4, odd_term: '10-1338', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '31-1993', phase_index: 0, even_term: '56-291', even_term_index: 6, odd_term: '40-2667', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '1-874', phase_index: 0, even_term: '26-1620', even_term_index: 8, odd_term: '11-956', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '30-2472', phase_index: 0, even_term: '56-2948', even_term_index: 10, odd_term: '41-2284', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '0-655', phase_index: 0, even_term: '27-1237', even_term_index: 12, odd_term: '12-573', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '29-1601', phase_index: 0, even_term: '57-2566', even_term_index: 14, odd_term: '42-1901', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: true, remainder: '58-2410', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '13-190', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '28-248', phase_index: 0, even_term: '28-854', even_term_index: 16, odd_term: '43-1518', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '57-1365', phase_index: 0, even_term: '58-2183', even_term_index: 18, odd_term: '13-2847', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '26-2750', phase_index: 0, even_term: '29-471', even_term_index: 20, odd_term: '44-1136', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '56-1423', phase_index: 0, even_term: '59-1800', even_term_index: 22, odd_term: '14-2464', odd_term_index: 23 }
  ],
  807 => [
    # 計算上では11が小の月、12が大の月、1が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '26-503', phase_index: 0, even_term: '30-89', even_term_index: 0, odd_term: '45-753', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '55-2820', phase_index: 0, even_term: '0-1417', even_term_index: 2, odd_term: '15-2081', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '25-2102', phase_index: 0, even_term: '30-2746', even_term_index: 4, odd_term: '46-370', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '55-1310', phase_index: 0, even_term: '1-1034', even_term_index: 6, odd_term: '16-1699', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '25-268', phase_index: 0, even_term: '31-2363', even_term_index: 8, odd_term: '46-3027', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '54-2002', phase_index: 0, even_term: '2-651', even_term_index: 10, odd_term: '17-1316', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '24-364', phase_index: 0, even_term: '32-1980', even_term_index: 12, odd_term: '47-2644', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '53-1442', phase_index: 0, even_term: '3-269', even_term_index: 14, odd_term: '18-933', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '22-2468', phase_index: 0, even_term: '33-1597', even_term_index: 16, odd_term: '48-2261', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '52-414', phase_index: 0, even_term: '3-2926', even_term_index: 18, odd_term: '19-550', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '21-1471', phase_index: 0, even_term: '34-1214', even_term_index: 20, odd_term: '49-1879', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '50-2778', phase_index: 0, even_term: '4-2543', even_term_index: 22, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 11, leaped: false, remainder: '20-1332', phase_index: 0, even_term: '35-832', even_term_index: 0, odd_term: '20-167', odd_term_index: 23 }
  ],
  808 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '20-1332', phase_index: 0, even_term: '35-832', even_term_index: 0, odd_term: '20-167', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '50-222', phase_index: 0, even_term: '5-2160', even_term_index: 2, odd_term: '50-1496', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '19-2291', phase_index: 0, even_term: '36-449', even_term_index: 4, odd_term: '20-2824', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '49-1355', phase_index: 0, even_term: '6-1777', even_term_index: 6, odd_term: '51-1113', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '19-455', phase_index: 0, even_term: '37-66', even_term_index: 8, odd_term: '21-2442', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '48-2520', phase_index: 0, even_term: '7-1394', even_term_index: 10, odd_term: '52-730', odd_term_index: 9 },
    # 計算上では5が小の月、6が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '18-1293', phase_index: 0, even_term: '37-2723', even_term_index: 12, odd_term: '22-2059', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '47-2842', phase_index: 0, even_term: '8-1012', even_term_index: 14, odd_term: '53-347', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '17-1190', phase_index: 0, even_term: '38-2340', even_term_index: 16, odd_term: '23-1676', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '46-2437', phase_index: 0, even_term: '9-629', even_term_index: 18, odd_term: '53-3004', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '16-588', phase_index: 0, even_term: '39-1957', even_term_index: 20, odd_term: '24-1293', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '45-1745', phase_index: 0, even_term: '10-246', even_term_index: 22, odd_term: '54-2622', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '14-2998', phase_index: 0, even_term: '40-1575', even_term_index: 0, odd_term: '25-910', odd_term_index: 23 }
  ],
  809 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '14-2998', phase_index: 0, even_term: '40-1575', even_term_index: 0, odd_term: '25-910', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '44-1496', phase_index: 0, even_term: '10-2903', even_term_index: 2, odd_term: '55-2239', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '14-110', phase_index: 0, even_term: '41-1192', even_term_index: 4, odd_term: '26-527', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '43-1856', phase_index: 0, even_term: '11-2520', even_term_index: 6, odd_term: '56-1856', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: true, remainder: '13-698', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '27-145', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '42-2628', phase_index: 0, even_term: '42-809', even_term_index: 8, odd_term: '57-1473', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '12-1559', phase_index: 0, even_term: '12-2137', even_term_index: 10, odd_term: '27-2802', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '42-396', phase_index: 0, even_term: '43-426', even_term_index: 12, odd_term: '58-1090', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '11-2117', phase_index: 0, even_term: '13-1755', even_term_index: 14, odd_term: '28-2419', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '41-755', phase_index: 0, even_term: '44-43', even_term_index: 16, odd_term: '59-707', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '10-2305', phase_index: 0, even_term: '14-1372', even_term_index: 18, odd_term: '29-2036', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '40-678', phase_index: 0, even_term: '44-2700', even_term_index: 20, odd_term: '0-325', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '9-2046', phase_index: 0, even_term: '15-989', even_term_index: 22, odd_term: '30-1653', odd_term_index: 23 }
  ],
  810 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '39-364', phase_index: 0, even_term: '45-2318', even_term_index: 0, odd_term: '0-2982', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '8-1774', phase_index: 0, even_term: '16-606', even_term_index: 2, odd_term: '31-1270', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '38-146', phase_index: 0, even_term: '46-1935', even_term_index: 4, odd_term: '1-2599', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '7-1599', phase_index: 0, even_term: '17-223', even_term_index: 6, odd_term: '32-888', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '37-136', phase_index: 0, even_term: '47-1552', even_term_index: 8, odd_term: '2-2216', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '6-1851', phase_index: 0, even_term: '17-2880', even_term_index: 10, odd_term: '33-505', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '36-572', phase_index: 0, even_term: '48-1169', even_term_index: 12, odd_term: '3-1833', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '5-2399', phase_index: 0, even_term: '18-2498', even_term_index: 14, odd_term: '34-122', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '35-1297', phase_index: 0, even_term: '49-786', even_term_index: 16, odd_term: '4-1450', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '5-155', phase_index: 0, even_term: '19-2115', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 9, leaped: false, remainder: '34-1998', phase_index: 0, even_term: '50-403', even_term_index: 20, odd_term: '34-2779', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '4-669', phase_index: 0, even_term: '20-1732', even_term_index: 22, odd_term: '5-1068', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '33-2271', phase_index: 0, even_term: '51-21', even_term_index: 0, odd_term: '35-2396', odd_term_index: 23 }
  ],
  811 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '33-2271', phase_index: 0, even_term: '51-21', even_term_index: 0, odd_term: '35-2396', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '3-799', phase_index: 0, even_term: '21-1349', even_term_index: 2, odd_term: '6-685', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '32-2121', phase_index: 0, even_term: '51-2678', even_term_index: 4, odd_term: '36-2013', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '2-278', phase_index: 0, even_term: '22-966', even_term_index: 6, odd_term: '7-302', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '31-1508', phase_index: 0, even_term: '52-2295', even_term_index: 8, odd_term: '37-1631', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '0-2789', phase_index: 0, even_term: '23-583', even_term_index: 10, odd_term: '7-2959', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '30-1170', phase_index: 0, even_term: '53-1912', even_term_index: 12, odd_term: '38-1248', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '59-2710', phase_index: 0, even_term: '24-201', even_term_index: 14, odd_term: '8-2576', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '29-1419', phase_index: 0, even_term: '54-1529', even_term_index: 16, odd_term: '39-865', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '59-383', phase_index: 0, even_term: '24-2858', even_term_index: 18, odd_term: '9-2193', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '28-2490', phase_index: 0, even_term: '55-1146', even_term_index: 20, odd_term: '40-482', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '58-1516', phase_index: 0, even_term: '25-2475', even_term_index: 22, odd_term: '10-1811', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '28-501', phase_index: 0, even_term: '56-764', even_term_index: 0, odd_term: '41-99', odd_term_index: 23 }
  ],
  812 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '28-501', phase_index: 0, even_term: '56-764', even_term_index: 0, odd_term: '41-99', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '57-2416', phase_index: 0, even_term: '26-2092', even_term_index: 2, odd_term: '11-1428', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: true, remainder: '27-1050', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '41-2756', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '56-2423', phase_index: 0, even_term: '57-381', even_term_index: 4, odd_term: '12-1045', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '26-499', phase_index: 0, even_term: '27-1709', even_term_index: 6, odd_term: '42-2374', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '55-1516', phase_index: 0, even_term: '57-3038', even_term_index: 8, odd_term: '13-662', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '24-2580', phase_index: 0, even_term: '28-1326', even_term_index: 10, odd_term: '43-1991', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '54-648', phase_index: 0, even_term: '58-2655', even_term_index: 12, odd_term: '14-279', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '23-1979', phase_index: 0, even_term: '29-944', even_term_index: 14, odd_term: '44-1608', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '53-611', phase_index: 0, even_term: '59-2272', even_term_index: 16, odd_term: '14-2936', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '22-2548', phase_index: 0, even_term: '30-561', even_term_index: 18, odd_term: '45-1225', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '52-1693', phase_index: 0, even_term: '0-1889', even_term_index: 20, odd_term: '15-2554', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '22-936', phase_index: 0, even_term: '31-178', even_term_index: 22, odd_term: '46-842', odd_term_index: 23 }
  ],
  813 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '52-159', phase_index: 0, even_term: '1-1507', even_term_index: 0, odd_term: '16-2171', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '21-2348', phase_index: 0, even_term: '31-2835', even_term_index: 2, odd_term: '47-459', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '51-1100', phase_index: 0, even_term: '2-1124', even_term_index: 4, odd_term: '17-1788', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '20-2550', phase_index: 0, even_term: '32-2452', even_term_index: 6, odd_term: '48-77', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '50-689', phase_index: 0, even_term: '3-741', even_term_index: 8, odd_term: '18-1405', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '19-1620', phase_index: 0, even_term: '33-2069', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '48-2468', phase_index: 0, even_term: '4-358', even_term_index: 12, odd_term: '48-2734', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '18-334', phase_index: 0, even_term: '34-1687', even_term_index: 14, odd_term: '19-1022', odd_term_index: 13 },
    # 計算上では7が小の月、8が大の月
    { is_many_days: false, month: 7, leaped: false, remainder: '47-1494', phase_index: 0, even_term: '4-3015', even_term_index: 16, odd_term: '49-2351', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '16-3026', phase_index: 0, even_term: '35-1304', even_term_index: 18, odd_term: '20-639', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '46-1841', phase_index: 0, even_term: '5-2632', even_term_index: 20, odd_term: '50-1968', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '16-928', phase_index: 0, even_term: '36-921', even_term_index: 22, odd_term: '21-257', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '46-273', phase_index: 0, even_term: '6-2250', even_term_index: 0, odd_term: '51-1585', odd_term_index: 23 }
  ],
  814 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '46-273', phase_index: 0, even_term: '6-2250', even_term_index: 0, odd_term: '51-1585', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '15-2764', phase_index: 0, even_term: '37-538', even_term_index: 2, odd_term: '21-2914', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '45-1982', phase_index: 0, even_term: '7-1867', even_term_index: 4, odd_term: '52-1202', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '15-906', phase_index: 0, even_term: '38-155', even_term_index: 6, odd_term: '22-2531', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '44-2487', phase_index: 0, even_term: '8-1484', even_term_index: 8, odd_term: '53-820', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '14-707', phase_index: 0, even_term: '38-2812', even_term_index: 10, odd_term: '23-2148', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '43-1704', phase_index: 0, even_term: '9-1101', even_term_index: 12, odd_term: '54-437', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '12-2448', phase_index: 0, even_term: '39-2430', even_term_index: 14, odd_term: '24-1765', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '42-216', phase_index: 0, even_term: '10-718', even_term_index: 16, odd_term: '55-54', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '11-1293', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '25-1382', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '40-2635', phase_index: 0, even_term: '40-2047', even_term_index: 18, odd_term: '55-2711', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '10-1320', phase_index: 0, even_term: '11-335', even_term_index: 20, odd_term: '26-1000', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '40-331', phase_index: 0, even_term: '41-1664', even_term_index: 22, odd_term: '56-2328', odd_term_index: 23 }
  ],
  815 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '9-2682', phase_index: 0, even_term: '11-2993', even_term_index: 0, odd_term: '27-617', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '39-2147', phase_index: 0, even_term: '42-1281', even_term_index: 2, odd_term: '57-1945', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '9-1422', phase_index: 0, even_term: '12-2610', even_term_index: 4, odd_term: '28-234', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '39-426', phase_index: 0, even_term: '43-898', even_term_index: 6, odd_term: '58-1563', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '8-2196', phase_index: 0, even_term: '13-2227', even_term_index: 8, odd_term: '28-2891', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '38-545', phase_index: 0, even_term: '44-515', even_term_index: 10, odd_term: '59-1180', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '7-1615', phase_index: 0, even_term: '14-1844', even_term_index: 12, odd_term: '29-2508', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '36-2476', phase_index: 0, even_term: '45-133', even_term_index: 14, odd_term: '0-797', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '6-279', phase_index: 0, even_term: '15-1461', even_term_index: 16, odd_term: '30-2125', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '35-1278', phase_index: 0, even_term: '45-2790', even_term_index: 18, odd_term: '1-414', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '4-2539', phase_index: 0, even_term: '16-1078', even_term_index: 20, odd_term: '31-1743', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '34-1032', phase_index: 0, even_term: '46-2407', even_term_index: 22, odd_term: '2-31', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '3-2977', phase_index: 0, even_term: '17-696', even_term_index: 0, odd_term: '32-1360', odd_term_index: 1 }
  ],
  816 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '3-2977', phase_index: 0, even_term: '17-696', even_term_index: 0, odd_term: '32-1360', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '33-2187', phase_index: 0, even_term: '47-2024', even_term_index: 2, odd_term: '2-2688', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '3-1431', phase_index: 0, even_term: '18-313', even_term_index: 4, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 2, leaped: false, remainder: '33-679', phase_index: 0, even_term: '48-1641', even_term_index: 6, odd_term: '33-977', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '2-2797', phase_index: 0, even_term: '18-2970', even_term_index: 8, odd_term: '3-2306', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '32-1614', phase_index: 0, even_term: '49-1258', even_term_index: 10, odd_term: '34-594', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '2-159', phase_index: 0, even_term: '19-2587', even_term_index: 12, odd_term: '4-1923', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '31-1355', phase_index: 0, even_term: '50-876', even_term_index: 14, odd_term: '35-211', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '0-2435', phase_index: 0, even_term: '20-2204', even_term_index: 16, odd_term: '5-1540', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '30-426', phase_index: 0, even_term: '51-493', even_term_index: 18, odd_term: '35-2868', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '59-1441', phase_index: 0, even_term: '21-1821', even_term_index: 20, odd_term: '6-1157', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '28-2628', phase_index: 0, even_term: '52-110', even_term_index: 22, odd_term: '36-2486', odd_term_index: 21 },
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '58-1048', phase_index: 0, even_term: '22-1439', even_term_index: 0, odd_term: '7-774', odd_term_index: 23 }
  ],
  817 => [
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '58-1048', phase_index: 0, even_term: '22-1439', even_term_index: 0, odd_term: '7-774', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '27-2812', phase_index: 0, even_term: '52-2767', even_term_index: 2, odd_term: '37-2103', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '57-1772', phase_index: 0, even_term: '23-1056', even_term_index: 4, odd_term: '8-391', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '27-784', phase_index: 0, even_term: '53-2384', even_term_index: 6, odd_term: '38-1720', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '56-2880', phase_index: 0, even_term: '24-673', even_term_index: 8, odd_term: '9-9', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '26-1949', phase_index: 0, even_term: '54-2001', even_term_index: 10, odd_term: '39-1337', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: true, remainder: '56-843', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '9-2666', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '25-2506', phase_index: 0, even_term: '25-290', even_term_index: 12, odd_term: '40-954', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '55-972', phase_index: 0, even_term: '55-1619', even_term_index: 14, odd_term: '10-2283', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '24-2297', phase_index: 0, even_term: '25-2947', even_term_index: 16, odd_term: '41-571', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '54-505', phase_index: 0, even_term: '56-1236', even_term_index: 18, odd_term: '11-1900', odd_term_index: 19 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '23-1704', phase_index: 0, even_term: '26-2564', even_term_index: 20, odd_term: '42-189', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '52-2903', phase_index: 0, even_term: '57-853', even_term_index: 22, odd_term: '12-1517', odd_term_index: 23 }
  ],
  818 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '22-1268', phase_index: 0, even_term: '27-2182', even_term_index: 0, odd_term: '42-2846', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '51-2878', phase_index: 0, even_term: '58-470', even_term_index: 2, odd_term: '13-1134', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '21-1464', phase_index: 0, even_term: '28-1799', even_term_index: 4, odd_term: '43-2463', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '51-232', phase_index: 0, even_term: '59-87', even_term_index: 6, odd_term: '14-752', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '20-2109', phase_index: 0, even_term: '29-1416', even_term_index: 8, odd_term: '44-2080', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '50-996', phase_index: 0, even_term: '59-2744', even_term_index: 10, odd_term: '15-369', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '19-2929', phase_index: 0, even_term: '30-1033', even_term_index: 12, odd_term: '45-1697', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '49-1672', phase_index: 0, even_term: '0-2362', even_term_index: 14, odd_term: '15-3026', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '19-365', phase_index: 0, even_term: '31-650', even_term_index: 16, odd_term: '46-1314', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '48-2043', phase_index: 0, even_term: '1-1979', even_term_index: 18, odd_term: '16-2643', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '18-486', phase_index: 0, even_term: '32-267', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '47-1906', phase_index: 0, even_term: '2-1596', even_term_index: 22, odd_term: '47-932', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '17-255', phase_index: 0, even_term: '32-2925', even_term_index: 0, odd_term: '17-2260', odd_term_index: 23 }
  ],
  819 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '17-255', phase_index: 0, even_term: '32-2925', even_term_index: 0, odd_term: '17-2260', odd_term_index: 23 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '46-1657', phase_index: 0, even_term: '3-1213', even_term_index: 2, odd_term: '48-549', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '15-3026', phase_index: 0, even_term: '33-2542', even_term_index: 4, odd_term: '18-1877', odd_term_index: 3 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '45-1384', phase_index: 0, even_term: '4-830', even_term_index: 6, odd_term: '49-166', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '14-2828', phase_index: 0, even_term: '34-2159', even_term_index: 8, odd_term: '19-1495', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '44-1435', phase_index: 0, even_term: '5-447', even_term_index: 10, odd_term: '49-2823', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '14-105', phase_index: 0, even_term: '35-1776', even_term_index: 12, odd_term: '20-1112', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '43-1862', phase_index: 0, even_term: '6-65', even_term_index: 14, odd_term: '50-2440', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '13-749', phase_index: 0, even_term: '36-1393', even_term_index: 16, odd_term: '21-729', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '42-2697', phase_index: 0, even_term: '6-2722', even_term_index: 18, odd_term: '51-2057', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '12-1555', phase_index: 0, even_term: '37-1010', even_term_index: 20, odd_term: '22-346', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '42-364', phase_index: 0, even_term: '7-2339', even_term_index: 22, odd_term: '52-1675', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '11-2019', phase_index: 0, even_term: '38-628', even_term_index: 0, odd_term: '22-3003', odd_term_index: 23 }
  ],
  820 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '11-2019', phase_index: 0, even_term: '38-628', even_term_index: 0, odd_term: '22-3003', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '41-610', phase_index: 0, even_term: '8-1956', even_term_index: 2, odd_term: '53-1292', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '10-2058', phase_index: 0, even_term: '39-245', even_term_index: 4, odd_term: '23-2620', odd_term_index: 3 },
    # 計算上では閏1が小の月、3が大の月
    { is_many_days: false, month: 1, leaped: true, remainder: '40-222', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '54-909', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '9-1402', phase_index: 0, even_term: '9-1573', even_term_index: 6, odd_term: '24-2238', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '38-2626', phase_index: 0, even_term: '39-2902', even_term_index: 8, odd_term: '55-526', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '8-862', phase_index: 0, even_term: '10-1190', even_term_index: 10, odd_term: '25-1855', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '37-2346', phase_index: 0, even_term: '40-2519', even_term_index: 12, odd_term: '56-143', odd_term_index: 13 },
    # 計算上では6が小の月、7が大の月
    { is_many_days: false, month: 6, leaped: false, remainder: '7-929', phase_index: 0, even_term: '11-808', even_term_index: 14, odd_term: '26-1472', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '36-2826', phase_index: 0, even_term: '41-2136', even_term_index: 16, odd_term: '56-2800', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '6-1894', phase_index: 0, even_term: '12-425', even_term_index: 18, odd_term: '27-1089', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '36-970', phase_index: 0, even_term: '42-1753', even_term_index: 20, odd_term: '57-2418', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '6-4', phase_index: 0, even_term: '13-42', even_term_index: 22, odd_term: '28-706', odd_term_index: 23 }
  ],
  821 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '35-2050', phase_index: 0, even_term: '43-1371', even_term_index: 0, odd_term: '58-2035', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '5-809', phase_index: 0, even_term: '13-2699', even_term_index: 2, odd_term: '29-323', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '34-2312', phase_index: 0, even_term: '44-988', even_term_index: 4, odd_term: '59-1652', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '4-498', phase_index: 0, even_term: '14-2316', even_term_index: 6, odd_term: '29-2981', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '33-1512', phase_index: 0, even_term: '45-605', even_term_index: 8, odd_term: '0-1269', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '2-2523', phase_index: 0, even_term: '15-1933', even_term_index: 10, odd_term: '30-2598', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '32-539', phase_index: 0, even_term: '46-222', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 6, leaped: false, remainder: '1-1673', phase_index: 0, even_term: '16-1551', even_term_index: 14, odd_term: '1-886', odd_term_index: 13 },
    # 計算上では7が小の月、9が大の月
    { is_many_days: false, month: 7, leaped: false, remainder: '31-184', phase_index: 0, even_term: '46-2879', even_term_index: 16, odd_term: '31-2215', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '0-2000', phase_index: 0, even_term: '17-1168', even_term_index: 18, odd_term: '2-503', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '30-1038', phase_index: 0, even_term: '47-2496', even_term_index: 20, odd_term: '32-1832', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '0-286', phase_index: 0, even_term: '18-785', even_term_index: 22, odd_term: '3-121', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '29-2590', phase_index: 0, even_term: '48-2114', even_term_index: 0, odd_term: '33-1449', odd_term_index: 23 }
  ],
  822 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '29-2590', phase_index: 0, even_term: '48-2114', even_term_index: 0, odd_term: '33-1449', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '59-1831', phase_index: 0, even_term: '19-402', even_term_index: 2, odd_term: '3-2778', odd_term_index: 1 },
    # 計算上では1が小の月、2が大の月
    { is_many_days: false, month: 1, leaped: false, remainder: '29-802', phase_index: 0, even_term: '49-1731', even_term_index: 4, odd_term: '34-1066', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '58-2380', phase_index: 0, even_term: '20-19', even_term_index: 6, odd_term: '4-2395', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '28-641', phase_index: 0, even_term: '50-1348', even_term_index: 8, odd_term: '35-684', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '57-1677', phase_index: 0, even_term: '20-2676', even_term_index: 10, odd_term: '5-2012', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '26-2515', phase_index: 0, even_term: '51-965', even_term_index: 12, odd_term: '36-301', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '56-311', phase_index: 0, even_term: '21-2294', even_term_index: 14, odd_term: '6-1629', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '25-1342', phase_index: 0, even_term: '52-582', even_term_index: 16, odd_term: '36-2958', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '54-2661', phase_index: 0, even_term: '22-1911', even_term_index: 18, odd_term: '7-1246', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '24-1352', phase_index: 0, even_term: '53-199', even_term_index: 20, odd_term: '37-2575', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: true, remainder: '54-317', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '8-864', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '23-2592', phase_index: 0, even_term: '23-1528', even_term_index: 22, odd_term: '38-2192', odd_term_index: 23 }
  ],
  823 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '53-2056', phase_index: 0, even_term: '53-2857', even_term_index: 0, odd_term: '9-481', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '23-1410', phase_index: 0, even_term: '24-1145', even_term_index: 2, odd_term: '39-1809', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '53-462', phase_index: 0, even_term: '54-2474', even_term_index: 4, odd_term: '10-98', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '22-2254', phase_index: 0, even_term: '25-762', even_term_index: 6, odd_term: '40-1427', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '52-599', phase_index: 0, even_term: '55-2091', even_term_index: 8, odd_term: '10-2755', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '21-1717', phase_index: 0, even_term: '26-379', even_term_index: 10, odd_term: '41-1044', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '50-2565', phase_index: 0, even_term: '56-1708', even_term_index: 12, odd_term: '11-2372', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '20-245', phase_index: 0, even_term: '26-3037', even_term_index: 14, odd_term: '42-661', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '49-1202', phase_index: 0, even_term: '57-1325', even_term_index: 16, odd_term: '12-1989', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '18-2422', phase_index: 0, even_term: '27-2654', even_term_index: 18, odd_term: '43-278', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '48-896', phase_index: 0, even_term: '58-942', even_term_index: 20, odd_term: '13-1607', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '17-2819', phase_index: 0, even_term: '28-2271', even_term_index: 22, odd_term: '43-2935', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '47-1994', phase_index: 0, even_term: '59-560', even_term_index: 0, odd_term: '14-1224', odd_term_index: 1 }
  ],
  824 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '47-1994', phase_index: 0, even_term: '59-560', even_term_index: 0, odd_term: '14-1224', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '17-1420', phase_index: 0, even_term: '29-1888', even_term_index: 2, odd_term: '44-2552', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '47-791', phase_index: 0, even_term: '0-177', even_term_index: 4, odd_term: '15-841', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '16-2957', phase_index: 0, even_term: '30-1505', even_term_index: 6, odd_term: '45-2170', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '46-1813', phase_index: 0, even_term: '0-2834', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 4, leaped: false, remainder: '16-370', phase_index: 0, even_term: '31-1122', even_term_index: 10, odd_term: '16-458', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '45-1571', phase_index: 0, even_term: '1-2451', even_term_index: 12, odd_term: '46-1787', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '14-2511', phase_index: 0, even_term: '32-740', even_term_index: 14, odd_term: '17-75', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '44-341', phase_index: 0, even_term: '2-2068', even_term_index: 16, odd_term: '47-1404', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '13-1247', phase_index: 0, even_term: '33-357', even_term_index: 18, odd_term: '17-2732', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '42-2386', phase_index: 0, even_term: '3-1685', even_term_index: 20, odd_term: '48-1021', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '12-754', phase_index: 0, even_term: '33-3014', even_term_index: 22, odd_term: '18-2350', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '41-2477', phase_index: 0, even_term: '4-1303', even_term_index: 0, odd_term: '49-638', odd_term_index: 23 }
  ],
  825 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '41-2477', phase_index: 0, even_term: '4-1303', even_term_index: 0, odd_term: '49-638', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '11-1588', phase_index: 0, even_term: '34-2631', even_term_index: 2, odd_term: '19-1967', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '41-791', phase_index: 0, even_term: '5-920', even_term_index: 4, odd_term: '50-255', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '11-12', phase_index: 0, even_term: '35-2248', even_term_index: 6, odd_term: '20-1584', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '40-2228', phase_index: 0, even_term: '6-537', even_term_index: 8, odd_term: '50-2913', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '10-1164', phase_index: 0, even_term: '36-1865', even_term_index: 10, odd_term: '21-1201', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '39-2877', phase_index: 0, even_term: '7-154', even_term_index: 12, odd_term: '51-2530', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '9-1231', phase_index: 0, even_term: '37-1483', even_term_index: 14, odd_term: '22-818', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '38-2363', phase_index: 0, even_term: '7-2811', even_term_index: 16, odd_term: '52-2147', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '8-408', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '23-435', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '37-1447', phase_index: 0, even_term: '38-1100', even_term_index: 18, odd_term: '53-1764', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '6-2537', phase_index: 0, even_term: '8-2428', even_term_index: 20, odd_term: '24-53', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '36-830', phase_index: 0, even_term: '39-717', even_term_index: 22, odd_term: '54-1381', odd_term_index: 23 }
  ],
  826 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '5-2460', phase_index: 0, even_term: '9-2046', even_term_index: 0, odd_term: '24-2710', odd_term_index: 1 },
    # 計算上では12が大の月、1が小の月
    { is_many_days: true, month: 12, leaped: false, remainder: '35-1289', phase_index: 0, even_term: '40-334', even_term_index: 2, odd_term: '55-998', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '5-250', phase_index: 0, even_term: '10-1663', even_term_index: 4, odd_term: '25-2327', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '34-2294', phase_index: 0, even_term: '40-2991', even_term_index: 6, odd_term: '56-616', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '4-1339', phase_index: 0, even_term: '11-1280', even_term_index: 8, odd_term: '26-1944', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '34-334', phase_index: 0, even_term: '41-2608', even_term_index: 10, odd_term: '57-233', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '3-2122', phase_index: 0, even_term: '12-897', even_term_index: 12, odd_term: '27-1561', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '33-649', phase_index: 0, even_term: '42-2226', even_term_index: 14, odd_term: '57-2890', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '2-2117', phase_index: 0, even_term: '13-514', even_term_index: 16, odd_term: '28-1178', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '32-384', phase_index: 0, even_term: '43-1843', even_term_index: 18, odd_term: '58-2507', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '1-1634', phase_index: 0, even_term: '14-131', even_term_index: 20, odd_term: '29-796', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '30-2847', phase_index: 0, even_term: '44-1460', even_term_index: 22, odd_term: '59-2124', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '0-1101', phase_index: 0, even_term: '14-2789', even_term_index: 0, odd_term: '', odd_term_index: -1 }
  ],
  827 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '0-1101', phase_index: 0, even_term: '14-2789', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '29-2642', phase_index: 0, even_term: '45-1077', even_term_index: 2, odd_term: '30-413', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '59-1181', phase_index: 0, even_term: '15-2406', even_term_index: 4, odd_term: '0-1741', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '28-2846', phase_index: 0, even_term: '46-694', even_term_index: 6, odd_term: '31-30', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '58-1628', phase_index: 0, even_term: '16-2023', even_term_index: 8, odd_term: '1-1359', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '28-460', phase_index: 0, even_term: '47-311', even_term_index: 10, odd_term: '31-2687', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '57-2377', phase_index: 0, even_term: '17-1640', even_term_index: 12, odd_term: '2-976', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '27-1192', phase_index: 0, even_term: '47-2969', even_term_index: 14, odd_term: '32-2304', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '56-2974', phase_index: 0, even_term: '18-1257', even_term_index: 16, odd_term: '3-593', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '26-1672', phase_index: 0, even_term: '48-2586', even_term_index: 18, odd_term: '33-1921', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '56-255', phase_index: 0, even_term: '19-874', even_term_index: 20, odd_term: '4-210', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '25-1731', phase_index: 0, even_term: '49-2203', even_term_index: 22, odd_term: '34-1539', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '55-124', phase_index: 0, even_term: '20-492', even_term_index: 0, odd_term: '4-2867', odd_term_index: 23 }
  ],
  828 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '55-124', phase_index: 0, even_term: '20-492', even_term_index: 0, odd_term: '4-2867', odd_term_index: 23 },
    # 計算上では12が小の月、3が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '24-1551', phase_index: 0, even_term: '50-1820', even_term_index: 2, odd_term: '35-1156', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '53-2901', phase_index: 0, even_term: '21-109', even_term_index: 4, odd_term: '5-2484', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '23-1209', phase_index: 0, even_term: '51-1437', even_term_index: 6, odd_term: '36-773', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '52-2600', phase_index: 0, even_term: '21-2766', even_term_index: 8, odd_term: '6-2102', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true, remainder: '22-1061', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '37-390', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '51-2716', phase_index: 0, even_term: '52-1054', even_term_index: 10, odd_term: '7-1719', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '21-1375', phase_index: 0, even_term: '22-2383', even_term_index: 12, odd_term: '38-7', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '51-174', phase_index: 0, even_term: '53-672', even_term_index: 14, odd_term: '8-1336', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '20-2162', phase_index: 0, even_term: '23-2000', even_term_index: 16, odd_term: '38-2664', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '50-1076', phase_index: 0, even_term: '54-289', even_term_index: 18, odd_term: '9-953', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '19-2980', phase_index: 0, even_term: '24-1617', even_term_index: 20, odd_term: '39-2282', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '49-1731', phase_index: 0, even_term: '54-2946', even_term_index: 22, odd_term: '10-570', odd_term_index: 23 }
  ],
  829 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '19-366', phase_index: 0, even_term: '25-1235', even_term_index: 0, odd_term: '40-1899', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '48-1942', phase_index: 0, even_term: '55-2563', even_term_index: 2, odd_term: '11-187', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '18-188', phase_index: 0, even_term: '26-852', even_term_index: 4, odd_term: '41-1516', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '47-1331', phase_index: 0, even_term: '56-2180', even_term_index: 6, odd_term: '11-2845', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '16-2502', phase_index: 0, even_term: '27-469', even_term_index: 8, odd_term: '42-1133', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '46-686', phase_index: 0, even_term: '57-1797', even_term_index: 10, odd_term: '12-2462', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '15-2026', phase_index: 0, even_term: '28-86', even_term_index: 12, odd_term: '43-750', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '45-500', phase_index: 0, even_term: '58-1415', even_term_index: 14, odd_term: '13-2079', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '14-2274', phase_index: 0, even_term: '28-2743', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 8, leaped: false, remainder: '44-1264', phase_index: 0, even_term: '59-1032', even_term_index: 18, odd_term: '44-367', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '14-383', phase_index: 0, even_term: '29-2360', even_term_index: 20, odd_term: '14-1696', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '43-2509', phase_index: 0, even_term: '0-649', even_term_index: 22, odd_term: '44-3025', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '13-1560', phase_index: 0, even_term: '30-1978', even_term_index: 0, odd_term: '15-1313', odd_term_index: 23 }
  ],
  830 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '13-1560', phase_index: 0, even_term: '30-1978', even_term_index: 0, odd_term: '15-1313', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '43-503', phase_index: 0, even_term: '1-266', even_term_index: 2, odd_term: '45-2642', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '12-2140', phase_index: 0, even_term: '31-1595', even_term_index: 4, odd_term: '16-930', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '42-448', phase_index: 0, even_term: '1-2923', even_term_index: 6, odd_term: '46-2259', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '11-1535', phase_index: 0, even_term: '32-1212', even_term_index: 8, odd_term: '17-548', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '40-2504', phase_index: 0, even_term: '2-2540', even_term_index: 10, odd_term: '47-1876', odd_term_index: 9 },
    # 計算上では5が小の月、7が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '10-469', phase_index: 0, even_term: '33-829', even_term_index: 12, odd_term: '18-165', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '39-1519', phase_index: 0, even_term: '3-2158', even_term_index: 14, odd_term: '48-1493', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '8-2856', phase_index: 0, even_term: '34-446', even_term_index: 16, odd_term: '18-2822', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '38-1509', phase_index: 0, even_term: '4-1775', even_term_index: 18, odd_term: '49-1110', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '8-427', phase_index: 0, even_term: '35-63', even_term_index: 20, odd_term: '19-2439', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '37-2641', phase_index: 0, even_term: '5-1392', even_term_index: 22, odd_term: '50-728', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '7-1945', phase_index: 0, even_term: '35-2721', even_term_index: 0, odd_term: '20-2056', odd_term_index: 23 }
  ],
  831 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '7-1945', phase_index: 0, even_term: '35-2721', even_term_index: 0, odd_term: '20-2056', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '37-1242', phase_index: 0, even_term: '6-1009', even_term_index: 2, odd_term: '51-345', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: true, remainder: '7-367', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '21-1673', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '36-2145', phase_index: 0, even_term: '36-2338', even_term_index: 4, odd_term: '51-3002', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '6-534', phase_index: 0, even_term: '7-626', even_term_index: 6, odd_term: '22-1291', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '35-1688', phase_index: 0, even_term: '37-1955', even_term_index: 8, odd_term: '52-2619', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '4-2593', phase_index: 0, even_term: '8-243', even_term_index: 10, odd_term: '23-908', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '34-345', phase_index: 0, even_term: '38-1572', even_term_index: 12, odd_term: '53-2236', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '3-1252', phase_index: 0, even_term: '8-2901', even_term_index: 14, odd_term: '24-525', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '32-2434', phase_index: 0, even_term: '39-1189', even_term_index: 16, odd_term: '54-1853', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '2-927', phase_index: 0, even_term: '9-2518', even_term_index: 18, odd_term: '25-142', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '31-2805', phase_index: 0, even_term: '40-806', even_term_index: 20, odd_term: '55-1471', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '1-1916', phase_index: 0, even_term: '10-2135', even_term_index: 22, odd_term: '25-2799', odd_term_index: 23 }
  ],
  832 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '31-1300', phase_index: 0, even_term: '41-424', even_term_index: 0, odd_term: '56-1088', odd_term_index: 1 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '1-772', phase_index: 0, even_term: '11-1752', even_term_index: 2, odd_term: '26-2416', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '30-2995', phase_index: 0, even_term: '42-41', even_term_index: 4, odd_term: '57-705', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '0-1895', phase_index: 0, even_term: '12-1369', even_term_index: 6, odd_term: '27-2034', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '30-429', phase_index: 0, even_term: '42-2698', even_term_index: 8, odd_term: '58-322', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '59-1671', phase_index: 0, even_term: '13-986', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '28-2641', phase_index: 0, even_term: '43-2315', even_term_index: 12, odd_term: '28-1651', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '58-334', phase_index: 0, even_term: '14-604', even_term_index: 14, odd_term: '58-2979', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '27-1172', phase_index: 0, even_term: '44-1932', even_term_index: 16, odd_term: '29-1268', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '56-2272', phase_index: 0, even_term: '15-221', even_term_index: 18, odd_term: '59-2596', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '26-597', phase_index: 0, even_term: '45-1549', even_term_index: 20, odd_term: '30-885', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '55-2329', phase_index: 0, even_term: '15-2878', even_term_index: 22, odd_term: '0-2214', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '25-1370', phase_index: 0, even_term: '46-1167', even_term_index: 0, odd_term: '31-502', odd_term_index: 23 }
  ],
  833 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '25-1370', phase_index: 0, even_term: '46-1167', even_term_index: 0, odd_term: '31-502', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '55-706', phase_index: 0, even_term: '16-2495', even_term_index: 2, odd_term: '1-1831', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '25-102', phase_index: 0, even_term: '47-784', even_term_index: 4, odd_term: '32-119', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '54-2388', phase_index: 0, even_term: '17-2112', even_term_index: 6, odd_term: '2-1448', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '24-1369', phase_index: 0, even_term: '48-401', even_term_index: 8, odd_term: '32-2777', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '54-79', phase_index: 0, even_term: '18-1729', even_term_index: 10, odd_term: '3-1065', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '23-1463', phase_index: 0, even_term: '49-18', even_term_index: 12, odd_term: '33-2394', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '52-2511', phase_index: 0, even_term: '19-1347', even_term_index: 14, odd_term: '4-682', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '22-385', phase_index: 0, even_term: '49-2675', even_term_index: 16, odd_term: '34-2011', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '51-1275', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '5-299', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '20-2294', phase_index: 0, even_term: '20-964', even_term_index: 18, odd_term: '35-1628', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '50-538', phase_index: 0, even_term: '50-2292', even_term_index: 20, odd_term: '5-2957', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '19-2101', phase_index: 0, even_term: '21-581', even_term_index: 22, odd_term: '36-1245', odd_term_index: 23 }
  ],
  834 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '49-1026', phase_index: 0, even_term: '51-1910', even_term_index: 0, odd_term: '6-2574', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '19-188', phase_index: 0, even_term: '22-198', even_term_index: 2, odd_term: '37-862', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '48-2405', phase_index: 0, even_term: '52-1527', even_term_index: 4, odd_term: '7-2191', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '18-1601', phase_index: 0, even_term: '22-2855', even_term_index: 6, odd_term: '38-480', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '48-656', phase_index: 0, even_term: '53-1144', even_term_index: 8, odd_term: '8-1808', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '17-2492', phase_index: 0, even_term: '23-2472', even_term_index: 10, odd_term: '39-97', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '47-1013', phase_index: 0, even_term: '54-761', even_term_index: 12, odd_term: '9-1425', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '16-2252', phase_index: 0, even_term: '24-2090', even_term_index: 14, odd_term: '39-2754', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '46-353', phase_index: 0, even_term: '55-378', even_term_index: 16, odd_term: '10-1042', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '15-1442', phase_index: 0, even_term: '25-1707', even_term_index: 18, odd_term: '40-2371', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '44-2504', phase_index: 0, even_term: '55-3035', even_term_index: 20, odd_term: '11-660', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '14-674', phase_index: 0, even_term: '26-1324', even_term_index: 22, odd_term: '41-1988', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '43-2167', phase_index: 0, even_term: '56-2653', even_term_index: 0, odd_term: '12-277', odd_term_index: 1 }
  ],
  835 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '43-2167', phase_index: 0, even_term: '56-2653', even_term_index: 0, odd_term: '12-277', odd_term_index: 1 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '13-887', phase_index: 0, even_term: '27-941', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '42-2793', phase_index: 0, even_term: '57-2270', even_term_index: 4, odd_term: '42-1605', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '12-1744', phase_index: 0, even_term: '28-558', even_term_index: 6, odd_term: '12-2934', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '42-742', phase_index: 0, even_term: '58-1887', even_term_index: 8, odd_term: '43-1223', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '11-2807', phase_index: 0, even_term: '29-175', even_term_index: 10, odd_term: '13-2551', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '41-1677', phase_index: 0, even_term: '59-1504', even_term_index: 12, odd_term: '44-840', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '11-290', phase_index: 0, even_term: '29-2833', even_term_index: 14, odd_term: '14-2168', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '40-1859', phase_index: 0, even_term: '0-1121', even_term_index: 16, odd_term: '45-457', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '10-221', phase_index: 0, even_term: '30-2450', even_term_index: 18, odd_term: '15-1785', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '39-1527', phase_index: 0, even_term: '1-738', even_term_index: 20, odd_term: '46-74', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '8-2786', phase_index: 0, even_term: '31-2067', even_term_index: 22, odd_term: '16-1403', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '38-997', phase_index: 0, even_term: '2-356', even_term_index: 0, odd_term: '46-2731', odd_term_index: 23 }
  ],
  836 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '38-997', phase_index: 0, even_term: '2-356', even_term_index: 0, odd_term: '46-2731', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '7-2437', phase_index: 0, even_term: '32-1684', even_term_index: 2, odd_term: '17-1020', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '37-935', phase_index: 0, even_term: '2-3013', even_term_index: 4, odd_term: '47-2348', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '6-2496', phase_index: 0, even_term: '33-1301', even_term_index: 6, odd_term: '18-637', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '36-1185', phase_index: 0, even_term: '3-2630', even_term_index: 8, odd_term: '48-1966', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '5-3003', phase_index: 0, even_term: '34-918', even_term_index: 10, odd_term: '19-254', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '35-1833', phase_index: 0, even_term: '4-2247', even_term_index: 12, odd_term: '49-1583', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true, remainder: '5-676', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '19-2911', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '34-2507', phase_index: 0, even_term: '35-536', even_term_index: 14, odd_term: '50-1200', odd_term_index: 15 },
    # 計算上では7が小の月、8が大の月
    { is_many_days: false, month: 7, leaped: false, remainder: '4-1260', phase_index: 0, even_term: '5-1864', even_term_index: 16, odd_term: '20-2528', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '33-2996', phase_index: 0, even_term: '36-153', even_term_index: 18, odd_term: '51-817', odd_term_index: 19 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '3-1517', phase_index: 0, even_term: '6-1481', even_term_index: 20, odd_term: '21-2146', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '32-3000', phase_index: 0, even_term: '36-2810', even_term_index: 22, odd_term: '52-434', odd_term_index: 23 }
  ],
  837 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '2-1421', phase_index: 0, even_term: '7-1099', even_term_index: 0, odd_term: '22-1763', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '31-2810', phase_index: 0, even_term: '37-2427', even_term_index: 2, odd_term: '53-51', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '1-1071', phase_index: 0, even_term: '8-716', even_term_index: 4, odd_term: '23-1380', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '30-2408', phase_index: 0, even_term: '38-2044', even_term_index: 6, odd_term: '53-2709', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '0-753', phase_index: 0, even_term: '9-333', even_term_index: 8, odd_term: '24-997', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '29-2324', phase_index: 0, even_term: '39-1661', even_term_index: 10, odd_term: '54-2326', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '59-932', phase_index: 0, even_term: '9-2990', even_term_index: 12, odd_term: '25-614', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '28-2667', phase_index: 0, even_term: '40-1279', even_term_index: 14, odd_term: '55-1943', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '58-1592', phase_index: 0, even_term: '10-2607', even_term_index: 16, odd_term: '26-231', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '28-557', phase_index: 0, even_term: '41-896', even_term_index: 18, odd_term: '56-1560', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '57-2515', phase_index: 0, even_term: '11-2224', even_term_index: 20, odd_term: '26-2889', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '27-1385', phase_index: 0, even_term: '42-513', even_term_index: 22, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 11, leaped: false, remainder: '57-86', phase_index: 0, even_term: '12-1842', even_term_index: 0, odd_term: '57-1177', odd_term_index: 23 }
  ],
  838 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '57-86', phase_index: 0, even_term: '12-1842', even_term_index: 0, odd_term: '57-1177', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '26-1764', phase_index: 0, even_term: '43-130', even_term_index: 2, odd_term: '27-2506', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '56-134', phase_index: 0, even_term: '13-1459', even_term_index: 4, odd_term: '58-794', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '25-1297', phase_index: 0, even_term: '43-2787', even_term_index: 6, odd_term: '28-2123', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '54-2418', phase_index: 0, even_term: '14-1076', even_term_index: 8, odd_term: '59-412', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '24-544', phase_index: 0, even_term: '44-2404', even_term_index: 10, odd_term: '29-1740', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '53-1762', phase_index: 0, even_term: '15-693', even_term_index: 12, odd_term: '0-29', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '23-132', phase_index: 0, even_term: '45-2022', even_term_index: 14, odd_term: '30-1357', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '52-1781', phase_index: 0, even_term: '16-310', even_term_index: 16, odd_term: '0-2686', odd_term_index: 15 },
    # 計算上では8が小の月、9が大の月
    { is_many_days: false, month: 8, leaped: false, remainder: '22-658', phase_index: 0, even_term: '46-1639', even_term_index: 18, odd_term: '31-974', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '51-2800', phase_index: 0, even_term: '16-2967', even_term_index: 20, odd_term: '1-2303', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '21-1936', phase_index: 0, even_term: '47-1256', even_term_index: 22, odd_term: '32-592', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '51-1035', phase_index: 0, even_term: '17-2585', even_term_index: 0, odd_term: '2-1920', odd_term_index: 23 }
  ],
  839 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '51-1035', phase_index: 0, even_term: '17-2585', even_term_index: 0, odd_term: '2-1920', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '21-116', phase_index: 0, even_term: '48-873', even_term_index: 2, odd_term: '33-209', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '50-1907', phase_index: 0, even_term: '18-2202', even_term_index: 4, odd_term: '3-1537', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: true, remainder: '20-341', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '33-2866', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '49-1542', phase_index: 0, even_term: '49-490', even_term_index: 6, odd_term: '4-1155', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '18-2521', phase_index: 0, even_term: '19-1819', even_term_index: 8, odd_term: '34-2483', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '48-435', phase_index: 0, even_term: '50-107', even_term_index: 10, odd_term: '5-772', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '17-1427', phase_index: 0, even_term: '20-1436', even_term_index: 12, odd_term: '35-2100', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '46-2558', phase_index: 0, even_term: '50-2765', even_term_index: 14, odd_term: '6-389', odd_term_index: 15 },
    # 計算上では7が小の月、8が大の月
    { is_many_days: false, month: 7, leaped: false, remainder: '16-1078', phase_index: 0, even_term: '21-1053', even_term_index: 16, odd_term: '36-1717', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '45-2916', phase_index: 0, even_term: '51-2382', even_term_index: 18, odd_term: '7-6', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '15-1977', phase_index: 0, even_term: '22-670', even_term_index: 20, odd_term: '37-1335', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '45-1265', phase_index: 0, even_term: '52-1999', even_term_index: 22, odd_term: '7-2663', odd_term_index: 23 }
  ],
  840 => [
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '15-600', phase_index: 0, even_term: '23-288', even_term_index: 0, odd_term: '38-952', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '44-2892', phase_index: 0, even_term: '53-1616', even_term_index: 2, odd_term: '8-2280', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '14-1843', phase_index: 0, even_term: '23-2945', even_term_index: 4, odd_term: '39-569', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '44-363', phase_index: 0, even_term: '54-1233', even_term_index: 6, odd_term: '9-1898', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '13-1641', phase_index: 0, even_term: '24-2562', even_term_index: 8, odd_term: '40-186', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '42-2656', phase_index: 0, even_term: '55-850', even_term_index: 10, odd_term: '10-1515', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '12-417', phase_index: 0, even_term: '25-2179', even_term_index: 12, odd_term: '40-2843', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '41-1222', phase_index: 0, even_term: '56-468', even_term_index: 14, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 7, leaped: false, remainder: '10-2279', phase_index: 0, even_term: '26-1796', even_term_index: 16, odd_term: '11-1132', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '40-562', phase_index: 0, even_term: '57-85', even_term_index: 18, odd_term: '41-2460', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '9-2314', phase_index: 0, even_term: '27-1413', even_term_index: 20, odd_term: '12-749', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '39-1300', phase_index: 0, even_term: '57-2742', even_term_index: 22, odd_term: '42-2078', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '9-567', phase_index: 0, even_term: '28-1031', even_term_index: 0, odd_term: '13-366', odd_term_index: 23 }
  ],
  841 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '9-567', phase_index: 0, even_term: '28-1031', even_term_index: 0, odd_term: '13-366', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '39-71', phase_index: 0, even_term: '58-2359', even_term_index: 2, odd_term: '43-1695', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '8-2424', phase_index: 0, even_term: '29-648', even_term_index: 4, odd_term: '13-3023', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '38-1449', phase_index: 0, even_term: '59-1976', even_term_index: 6, odd_term: '44-1312', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '8-198', phase_index: 0, even_term: '30-265', even_term_index: 8, odd_term: '14-2641', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '37-1561', phase_index: 0, even_term: '0-1593', even_term_index: 10, odd_term: '45-929', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '6-2655', phase_index: 0, even_term: '30-2922', even_term_index: 12, odd_term: '15-2258', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '36-439', phase_index: 0, even_term: '1-1211', even_term_index: 14, odd_term: '46-546', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '5-1202', phase_index: 0, even_term: '31-2539', even_term_index: 16, odd_term: '16-1875', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '34-2182', phase_index: 0, even_term: '2-828', even_term_index: 18, odd_term: '47-163', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '4-381', phase_index: 0, even_term: '32-2156', even_term_index: 20, odd_term: '17-1492', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: true, remainder: '33-1896', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '47-2821', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '3-810', phase_index: 0, even_term: '3-445', even_term_index: 22, odd_term: '18-1109', odd_term_index: 23 }
  ],
  842 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '33-23', phase_index: 0, even_term: '33-1774', even_term_index: 0, odd_term: '48-2438', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '2-2436', phase_index: 0, even_term: '4-62', even_term_index: 2, odd_term: '19-726', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '32-1762', phase_index: 0, even_term: '34-1391', even_term_index: 4, odd_term: '49-2055', odd_term_index: 5 },
    # 計算上では2が小の月、3が大の月
    { is_many_days: false, month: 2, leaped: false, remainder: '2-864', phase_index: 0, even_term: '4-2719', even_term_index: 6, odd_term: '20-344', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '31-2738', phase_index: 0, even_term: '35-1008', even_term_index: 8, odd_term: '50-1672', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '1-1293', phase_index: 0, even_term: '5-2336', even_term_index: 10, odd_term: '20-3001', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '30-2467', phase_index: 0, even_term: '36-625', even_term_index: 12, odd_term: '51-1289', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '0-396', phase_index: 0, even_term: '6-1954', even_term_index: 14, odd_term: '21-2618', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '29-1324', phase_index: 0, even_term: '37-242', even_term_index: 16, odd_term: '52-906', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '58-2266', phase_index: 0, even_term: '7-1571', even_term_index: 18, odd_term: '22-2235', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '28-388', phase_index: 0, even_term: '37-2899', even_term_index: 20, odd_term: '53-524', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '57-1820', phase_index: 0, even_term: '8-1188', even_term_index: 22, odd_term: '23-1852', odd_term_index: 23 },
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '27-518', phase_index: 0, even_term: '38-2517', even_term_index: 0, odd_term: '54-141', odd_term_index: 1 }
  ],
  843 => [
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '27-518', phase_index: 0, even_term: '38-2517', even_term_index: 0, odd_term: '54-141', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '56-2661', phase_index: 0, even_term: '9-805', even_term_index: 2, odd_term: '24-1469', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '26-1792', phase_index: 0, even_term: '39-2134', even_term_index: 4, odd_term: '54-2798', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '56-954', phase_index: 0, even_term: '10-422', even_term_index: 6, odd_term: '25-1087', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '26-90', phase_index: 0, even_term: '40-1751', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 4, leaped: false, remainder: '55-2046', phase_index: 0, even_term: '11-39', even_term_index: 10, odd_term: '55-2415', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '25-696', phase_index: 0, even_term: '41-1368', even_term_index: 12, odd_term: '26-704', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '54-2104', phase_index: 0, even_term: '11-2697', even_term_index: 14, odd_term: '56-2032', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '24-259', phase_index: 0, even_term: '42-985', even_term_index: 16, odd_term: '27-321', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '53-1403', phase_index: 0, even_term: '12-2314', even_term_index: 18, odd_term: '57-1649', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '22-2497', phase_index: 0, even_term: '43-602', even_term_index: 20, odd_term: '27-2978', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '52-577', phase_index: 0, even_term: '13-1931', even_term_index: 22, odd_term: '58-1267', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '21-1941', phase_index: 0, even_term: '44-220', even_term_index: 0, odd_term: '28-2595', odd_term_index: 23 }
  ],
  844 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '21-1941', phase_index: 0, even_term: '44-220', even_term_index: 0, odd_term: '28-2595', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '51-562', phase_index: 0, even_term: '14-1548', even_term_index: 2, odd_term: '59-884', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '20-2338', phase_index: 0, even_term: '44-2877', even_term_index: 4, odd_term: '29-2212', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '50-1236', phase_index: 0, even_term: '15-1165', even_term_index: 6, odd_term: '0-501', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '20-182', phase_index: 0, even_term: '45-2494', even_term_index: 8, odd_term: '30-1830', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '49-2211', phase_index: 0, even_term: '16-782', even_term_index: 10, odd_term: '1-118', odd_term_index: 9 },
    # 計算上では5が小の月、6が大の月
    { is_many_days: false, month: 5, leaped: false, remainder: '19-1172', phase_index: 0, even_term: '46-2111', even_term_index: 12, odd_term: '31-1447', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '48-2934', phase_index: 0, even_term: '17-400', even_term_index: 14, odd_term: '1-2775', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '18-1515', phase_index: 0, even_term: '47-1728', even_term_index: 16, odd_term: '32-1064', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '48-20', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '2-2392', odd_term_index: 17 },
    # 計算上では8が小の月、9が大の月
    { is_many_days: false, month: 8, leaped: false, remainder: '17-1383', phase_index: 0, even_term: '18-17', even_term_index: 18, odd_term: '33-681', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '46-2695', phase_index: 0, even_term: '48-1345', even_term_index: 20, odd_term: '3-2010', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '16-928', phase_index: 0, even_term: '18-2674', even_term_index: 22, odd_term: '34-298', odd_term_index: 23 }
  ],
  845 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '45-2267', phase_index: 0, even_term: '49-963', even_term_index: 0, odd_term: '4-1627', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '15-724', phase_index: 0, even_term: '19-2291', even_term_index: 2, odd_term: '34-2955', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '44-2235', phase_index: 0, even_term: '50-580', even_term_index: 4, odd_term: '5-1244', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '14-783', phase_index: 0, even_term: '20-1908', even_term_index: 6, odd_term: '35-2573', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '43-2542', phase_index: 0, even_term: '51-197', even_term_index: 8, odd_term: '6-861', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '13-1320', phase_index: 0, even_term: '21-1525', even_term_index: 10, odd_term: '36-2190', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '43-139', phase_index: 0, even_term: '51-2854', even_term_index: 12, odd_term: '7-478', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '12-2002', phase_index: 0, even_term: '22-1143', even_term_index: 14, odd_term: '37-1807', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '42-807', phase_index: 0, even_term: '52-2471', even_term_index: 16, odd_term: '8-95', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '11-2603', phase_index: 0, even_term: '23-760', even_term_index: 18, odd_term: '38-1424', odd_term_index: 19 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '41-1264', phase_index: 0, even_term: '53-2088', even_term_index: 20, odd_term: '8-2753', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '10-2799', phase_index: 0, even_term: '24-377', even_term_index: 22, odd_term: '39-1041', odd_term_index: 23 },
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '40-1261', phase_index: 0, even_term: '54-1706', even_term_index: 0, odd_term: '', odd_term_index: -1 }
  ],
  846 => [
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '40-1261', phase_index: 0, even_term: '54-1706', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '9-2726', phase_index: 0, even_term: '24-3034', even_term_index: 2, odd_term: '9-2370', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '39-969', phase_index: 0, even_term: '55-1323', even_term_index: 4, odd_term: '40-658', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '8-2256', phase_index: 0, even_term: '25-2651', even_term_index: 6, odd_term: '10-1987', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '38-546', phase_index: 0, even_term: '56-940', even_term_index: 8, odd_term: '41-276', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '7-1971', phase_index: 0, even_term: '26-2268', even_term_index: 10, odd_term: '11-1604', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '37-525', phase_index: 0, even_term: '57-557', even_term_index: 12, odd_term: '41-2933', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '6-2175', phase_index: 0, even_term: '27-1886', even_term_index: 14, odd_term: '12-1221', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '36-1004', phase_index: 0, even_term: '58-174', even_term_index: 16, odd_term: '42-2550', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '6-2', phase_index: 0, even_term: '28-1503', even_term_index: 18, odd_term: '13-838', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '35-2012', phase_index: 0, even_term: '58-2831', even_term_index: 20, odd_term: '43-2167', odd_term_index: 19 },
    # 計算上では10が小の月、11が大の月
    { is_many_days: false, month: 10, leaped: false, remainder: '5-937', phase_index: 0, even_term: '29-1120', even_term_index: 22, odd_term: '14-456', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '34-2812', phase_index: 0, even_term: '59-2449', even_term_index: 0, odd_term: '44-1784', odd_term_index: 23 }
  ],
  847 => [
    # 計算上では11が大の月
    { is_many_days: true, month: 11, leaped: false, remainder: '34-2812', phase_index: 0, even_term: '59-2449', even_term_index: 0, odd_term: '44-1784', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '4-1520', phase_index: 0, even_term: '30-737', even_term_index: 2, odd_term: '15-73', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '34-24', phase_index: 0, even_term: '0-2066', even_term_index: 4, odd_term: '45-1401', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '3-1278', phase_index: 0, even_term: '31-354', even_term_index: 6, odd_term: '15-2730', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '32-2370', phase_index: 0, even_term: '1-1683', even_term_index: 8, odd_term: '46-1019', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true, remainder: '2-442', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '16-2347', odd_term_index: 9 },
    # 計算上では4が小の月、5が大の月
    { is_many_days: false, month: 4, leaped: false, remainder: '31-1608', phase_index: 0, even_term: '31-3011', even_term_index: 10, odd_term: '47-636', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '0-2867', phase_index: 0, even_term: '2-1300', even_term_index: 12, odd_term: '17-1964', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '30-1346', phase_index: 0, even_term: '32-2629', even_term_index: 14, odd_term: '48-253', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '0-104', phase_index: 0, even_term: '3-917', even_term_index: 16, odd_term: '18-1581', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '29-2159', phase_index: 0, even_term: '33-2246', even_term_index: 18, odd_term: '48-2910', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '59-1328', phase_index: 0, even_term: '4-534', even_term_index: 20, odd_term: '19-1199', odd_term_index: 21 },
    # 計算上では10が小の月、11が大の月
    { is_many_days: false, month: 10, leaped: false, remainder: '29-475', phase_index: 0, even_term: '34-1863', even_term_index: 22, odd_term: '49-2527', odd_term_index: 23 }
  ],
  848 => [
    # 計算上では11が大の月
    { is_many_days: true, month: 11, leaped: false, remainder: '58-2640', phase_index: 0, even_term: '5-152', even_term_index: 0, odd_term: '20-816', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '28-1608', phase_index: 0, even_term: '35-1480', even_term_index: 2, odd_term: '50-2144', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '58-173', phase_index: 0, even_term: '5-2809', even_term_index: 4, odd_term: '21-433', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '27-1496', phase_index: 0, even_term: '36-1097', even_term_index: 6, odd_term: '51-1762', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '56-2558', phase_index: 0, even_term: '6-2426', even_term_index: 8, odd_term: '22-50', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '26-438', phase_index: 0, even_term: '37-714', even_term_index: 10, odd_term: '52-1379', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '55-1381', phase_index: 0, even_term: '7-2043', even_term_index: 12, odd_term: '22-2707', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '24-2405', phase_index: 0, even_term: '38-332', even_term_index: 14, odd_term: '53-996', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '54-709', phase_index: 0, even_term: '8-1660', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 8, leaped: false, remainder: '23-2423', phase_index: 0, even_term: '38-2989', even_term_index: 18, odd_term: '23-2324', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '53-1362', phase_index: 0, even_term: '9-1277', even_term_index: 20, odd_term: '54-613', odd_term_index: 19 },
    # 計算上では10が小の月、11が大の月
    { is_many_days: false, month: 10, leaped: false, remainder: '23-564', phase_index: 0, even_term: '39-2606', even_term_index: 22, odd_term: '24-1942', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '52-2966', phase_index: 0, even_term: '10-895', even_term_index: 0, odd_term: '55-230', odd_term_index: 23 }
  ],
  849 => [
    # 計算上では11が大の月
    { is_many_days: true, month: 11, leaped: false, remainder: '52-2966', phase_index: 0, even_term: '10-895', even_term_index: 0, odd_term: '55-230', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '22-2313', phase_index: 0, even_term: '40-2223', even_term_index: 2, odd_term: '25-1559', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '52-1401', phase_index: 0, even_term: '11-512', even_term_index: 4, odd_term: '55-2887', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '22-132', phase_index: 0, even_term: '41-1840', even_term_index: 6, odd_term: '26-1176', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '51-1537', phase_index: 0, even_term: '12-129', even_term_index: 8, odd_term: '56-2505', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '20-2671', phase_index: 0, even_term: '42-1457', even_term_index: 10, odd_term: '27-793', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '50-511', phase_index: 0, even_term: '12-2786', even_term_index: 12, odd_term: '57-2122', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '19-1252', phase_index: 0, even_term: '43-1075', even_term_index: 14, odd_term: '28-410', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '48-2184', phase_index: 0, even_term: '13-2403', even_term_index: 16, odd_term: '58-1739', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '18-348', phase_index: 0, even_term: '44-692', even_term_index: 18, odd_term: '29-27', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '47-1884', phase_index: 0, even_term: '14-2020', even_term_index: 20, odd_term: '59-1356', odd_term_index: 19 },
    # 計算上では10が小の月、11が大の月
    { is_many_days: false, month: 10, leaped: false, remainder: '17-744', phase_index: 0, even_term: '45-309', even_term_index: 22, odd_term: '29-2685', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '46-2922', phase_index: 0, even_term: '15-1638', even_term_index: 0, odd_term: '0-973', odd_term_index: 23 }
  ],
  850 => [
    # 計算上では11が大の月
    { is_many_days: true, month: 11, leaped: false, remainder: '46-2922', phase_index: 0, even_term: '15-1638', even_term_index: 0, odd_term: '0-973', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '16-2351', phase_index: 0, even_term: '45-2966', even_term_index: 2, odd_term: '30-2302', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: true, remainder: '46-1790', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '1-590', odd_term_index: 3 },
    # 計算上では1が小の月、2が大の月
    { is_many_days: false, month: 1, leaped: false, remainder: '16-942', phase_index: 0, even_term: '16-1255', even_term_index: 4, odd_term: '31-1919', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '45-2860', phase_index: 0, even_term: '46-2583', even_term_index: 6, odd_term: '2-208', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '15-1389', phase_index: 0, even_term: '17-872', even_term_index: 8, odd_term: '32-1536', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '44-2610', phase_index: 0, even_term: '47-2200', even_term_index: 10, odd_term: '2-2865', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '14-513', phase_index: 0, even_term: '18-489', even_term_index: 12, odd_term: '33-1153', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '43-1279', phase_index: 0, even_term: '48-1818', even_term_index: 14, odd_term: '3-2482', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '12-2150', phase_index: 0, even_term: '19-106', even_term_index: 16, odd_term: '34-770', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '42-229', phase_index: 0, even_term: '49-1435', even_term_index: 18, odd_term: '4-2099', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '11-1617', phase_index: 0, even_term: '19-2763', even_term_index: 20, odd_term: '35-388', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '41-315', phase_index: 0, even_term: '50-1052', even_term_index: 22, odd_term: '5-1716', odd_term_index: 23 }
  ],
  851 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '10-2429', phase_index: 0, even_term: '20-2381', even_term_index: 0, odd_term: '36-5', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '40-1749', phase_index: 0, even_term: '51-669', even_term_index: 2, odd_term: '6-1333', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '10-1077', phase_index: 0, even_term: '21-1998', even_term_index: 4, odd_term: '36-2662', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '40-297', phase_index: 0, even_term: '52-286', even_term_index: 6, odd_term: '7-951', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '9-2293', phase_index: 0, even_term: '22-1615', even_term_index: 8, odd_term: '37-2279', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '39-984', phase_index: 0, even_term: '52-2943', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '8-2361', phase_index: 0, even_term: '23-1232', even_term_index: 12, odd_term: '8-568', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '38-366', phase_index: 0, even_term: '53-2561', even_term_index: 14, odd_term: '38-1896', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '7-1344', phase_index: 0, even_term: '24-849', even_term_index: 16, odd_term: '9-185', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '36-2287', phase_index: 0, even_term: '54-2178', even_term_index: 18, odd_term: '39-1513', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '6-296', phase_index: 0, even_term: '25-466', even_term_index: 20, odd_term: '9-2842', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '35-1604', phase_index: 0, even_term: '55-1795', even_term_index: 22, odd_term: '40-1131', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '5-155', phase_index: 0, even_term: '26-84', even_term_index: 0, odd_term: '10-2459', odd_term_index: 23 }
  ],
  852 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '5-155', phase_index: 0, even_term: '26-84', even_term_index: 0, odd_term: '10-2459', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '34-2128', phase_index: 0, even_term: '56-1412', even_term_index: 2, odd_term: '41-748', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '4-1214', phase_index: 0, even_term: '26-2741', even_term_index: 4, odd_term: '11-2076', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '34-327', phase_index: 0, even_term: '57-1029', even_term_index: 6, odd_term: '42-365', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '3-2509', phase_index: 0, even_term: '27-2358', even_term_index: 8, odd_term: '12-1694', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '33-1541', phase_index: 0, even_term: '58-646', even_term_index: 10, odd_term: '42-3022', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '3-315', phase_index: 0, even_term: '28-1975', even_term_index: 12, odd_term: '13-1311', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '32-1853', phase_index: 0, even_term: '59-264', even_term_index: 14, odd_term: '43-2639', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '2-125', phase_index: 0, even_term: '29-1592', even_term_index: 16, odd_term: '14-928', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '31-1325', phase_index: 0, even_term: '59-2921', even_term_index: 18, odd_term: '44-2256', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: true, remainder: '0-2468', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '15-545', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '30-539', phase_index: 0, even_term: '30-1209', even_term_index: 20, odd_term: '45-1874', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '59-1781', phase_index: 0, even_term: '0-2538', even_term_index: 22, odd_term: '16-162', odd_term_index: 23 }
  ],
  853 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '29-276', phase_index: 0, even_term: '31-827', even_term_index: 0, odd_term: '46-1491', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '58-1987', phase_index: 0, even_term: '1-2155', even_term_index: 2, odd_term: '16-2819', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '28-769', phase_index: 0, even_term: '32-444', even_term_index: 4, odd_term: '47-1108', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '57-2698', phase_index: 0, even_term: '2-1772', even_term_index: 6, odd_term: '17-2437', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '27-1637', phase_index: 0, even_term: '33-61', even_term_index: 8, odd_term: '48-725', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '57-609', phase_index: 0, even_term: '3-1389', even_term_index: 10, odd_term: '18-2054', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '26-2492', phase_index: 0, even_term: '33-2718', even_term_index: 12, odd_term: '49-342', odd_term_index: 13 },
    # 計算上では6が小の月、7が大の月
    { is_many_days: false, month: 6, leaped: false, remainder: '56-1132', phase_index: 0, even_term: '4-1007', even_term_index: 14, odd_term: '19-1671', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '25-2763', phase_index: 0, even_term: '34-2335', even_term_index: 16, odd_term: '49-2999', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '55-1201', phase_index: 0, even_term: '5-624', even_term_index: 18, odd_term: '20-1288', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '24-2567', phase_index: 0, even_term: '35-1952', even_term_index: 20, odd_term: '50-2617', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '54-845', phase_index: 0, even_term: '6-241', even_term_index: 22, odd_term: '21-905', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '23-2152', phase_index: 0, even_term: '36-1570', even_term_index: 0, odd_term: '51-2234', odd_term_index: 1 }
  ],
  854 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '23-2152', phase_index: 0, even_term: '36-1570', even_term_index: 0, odd_term: '51-2234', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '53-549', phase_index: 0, even_term: '6-2898', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '22-2015', phase_index: 0, even_term: '37-1187', even_term_index: 4, odd_term: '22-522', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '52-476', phase_index: 0, even_term: '7-2515', even_term_index: 6, odd_term: '52-1851', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '21-2127', phase_index: 0, even_term: '38-804', even_term_index: 8, odd_term: '23-140', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '51-847', phase_index: 0, even_term: '8-2132', even_term_index: 10, odd_term: '53-1468', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '20-2659', phase_index: 0, even_term: '39-421', even_term_index: 12, odd_term: '23-2797', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '50-1464', phase_index: 0, even_term: '9-1750', even_term_index: 14, odd_term: '54-1085', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '20-317', phase_index: 0, even_term: '40-38', even_term_index: 16, odd_term: '24-2414', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '49-2168', phase_index: 0, even_term: '10-1367', even_term_index: 18, odd_term: '55-702', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '19-922', phase_index: 0, even_term: '40-2695', even_term_index: 20, odd_term: '25-2031', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '48-2562', phase_index: 0, even_term: '11-984', even_term_index: 22, odd_term: '56-320', odd_term_index: 21 },
    # 計算上では11が小の月、2が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '18-1071', phase_index: 0, even_term: '41-2313', even_term_index: 0, odd_term: '26-1648', odd_term_index: 23 }
  ],
  855 => [
    # 計算上では11が小の月、2が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '18-1071', phase_index: 0, even_term: '41-2313', even_term_index: 0, odd_term: '26-1648', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '47-2602', phase_index: 0, even_term: '12-601', even_term_index: 2, odd_term: '56-2977', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '17-902', phase_index: 0, even_term: '42-1930', even_term_index: 4, odd_term: '27-1265', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '46-2139', phase_index: 0, even_term: '13-218', even_term_index: 6, odd_term: '57-2594', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '16-377', phase_index: 0, even_term: '43-1547', even_term_index: 8, odd_term: '28-883', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '45-1705', phase_index: 0, even_term: '13-2875', even_term_index: 10, odd_term: '58-2211', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: true, remainder: '15-157', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '29-500', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '44-1741', phase_index: 0, even_term: '44-1164', even_term_index: 12, odd_term: '59-1828', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '14-450', phase_index: 0, even_term: '14-2493', even_term_index: 14, odd_term: '30-117', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '43-2451', phase_index: 0, even_term: '45-781', even_term_index: 16, odd_term: '0-1445', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '13-1472', phase_index: 0, even_term: '15-2110', even_term_index: 18, odd_term: '30-2774', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '43-450', phase_index: 0, even_term: '46-398', even_term_index: 20, odd_term: '1-1063', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '12-2422', phase_index: 0, even_term: '16-1727', even_term_index: 22, odd_term: '31-2391', odd_term_index: 23 }
  ],
  856 => [
    # 計算上では11が小の月、12が大の月
    { is_many_days: false, month: 11, leaped: false, remainder: '42-1215', phase_index: 0, even_term: '47-16', even_term_index: 0, odd_term: '2-680', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '11-2894', phase_index: 0, even_term: '17-1344', even_term_index: 2, odd_term: '32-2008', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '41-1230', phase_index: 0, even_term: '47-2673', even_term_index: 4, odd_term: '3-297', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '10-2357', phase_index: 0, even_term: '18-961', even_term_index: 6, odd_term: '33-1626', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '40-379', phase_index: 0, even_term: '48-2290', even_term_index: 8, odd_term: '3-2954', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '9-1489', phase_index: 0, even_term: '19-578', even_term_index: 10, odd_term: '34-1243', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '38-2646', phase_index: 0, even_term: '49-1907', even_term_index: 12, odd_term: '4-2571', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '8-974', phase_index: 0, even_term: '20-196', even_term_index: 14, odd_term: '35-860', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '37-2647', phase_index: 0, even_term: '50-1524', even_term_index: 16, odd_term: '5-2188', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '7-1547', phase_index: 0, even_term: '20-2853', even_term_index: 18, odd_term: '36-477', odd_term_index: 19 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '37-683', phase_index: 0, even_term: '51-1141', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '6-2919', phase_index: 0, even_term: '21-2470', even_term_index: 22, odd_term: '6-1806', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '36-2086', phase_index: 0, even_term: '52-759', even_term_index: 0, odd_term: '37-94', odd_term_index: 23 }
  ],
  857 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '36-2086', phase_index: 0, even_term: '52-759', even_term_index: 0, odd_term: '37-94', odd_term_index: 23 },
    # 計算上では12が小の月、1が大の月
    { is_many_days: false, month: 12, leaped: false, remainder: '6-1214', phase_index: 0, even_term: '22-2087', even_term_index: 2, odd_term: '7-1423', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '35-2985', phase_index: 0, even_term: '53-376', even_term_index: 4, odd_term: '37-2751', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '5-1393', phase_index: 0, even_term: '23-1704', even_term_index: 6, odd_term: '8-1040', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '34-2571', phase_index: 0, even_term: '53-3033', even_term_index: 8, odd_term: '38-2369', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '4-476', phase_index: 0, even_term: '24-1321', even_term_index: 10, odd_term: '9-657', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '33-1370', phase_index: 0, even_term: '54-2650', even_term_index: 12, odd_term: '39-1986', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '2-2310', phase_index: 0, even_term: '25-939', even_term_index: 14, odd_term: '10-274', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '32-428', phase_index: 0, even_term: '55-2267', even_term_index: 16, odd_term: '40-1603', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '1-1988', phase_index: 0, even_term: '26-556', even_term_index: 18, odd_term: '10-2931', odd_term_index: 17 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '31-805', phase_index: 0, even_term: '56-1884', even_term_index: 20, odd_term: '41-1220', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '0-2932', phase_index: 0, even_term: '27-173', even_term_index: 22, odd_term: '11-2549', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '30-2262', phase_index: 0, even_term: '57-1502', even_term_index: 0, odd_term: '42-837', odd_term_index: 23 }
  ],
  858 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '30-2262', phase_index: 0, even_term: '57-1502', even_term_index: 0, odd_term: '42-837', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '0-1669', phase_index: 0, even_term: '27-2830', even_term_index: 2, odd_term: '12-2166', odd_term_index: 1 },
    # 計算上では1が小の月、2が大の月
    { is_many_days: false, month: 1, leaped: false, remainder: '30-893', phase_index: 0, even_term: '58-1119', even_term_index: 4, odd_term: '43-454', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '59-2856', phase_index: 0, even_term: '28-2447', even_term_index: 6, odd_term: '13-1783', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: true, remainder: '29-1371', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '44-72', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '58-2628', phase_index: 0, even_term: '59-736', even_term_index: 8, odd_term: '14-1400', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '28-582', phase_index: 0, even_term: '29-2064', even_term_index: 10, odd_term: '44-2729', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '57-1342', phase_index: 0, even_term: '0-353', even_term_index: 12, odd_term: '15-1017', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '26-2150', phase_index: 0, even_term: '30-1682', even_term_index: 14, odd_term: '45-2346', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '56-190', phase_index: 0, even_term: '0-3010', even_term_index: 16, odd_term: '16-634', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '25-1534', phase_index: 0, even_term: '31-1299', even_term_index: 18, odd_term: '46-1963', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '55-249', phase_index: 0, even_term: '1-2627', even_term_index: 20, odd_term: '17-252', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '24-2299', phase_index: 0, even_term: '32-916', even_term_index: 22, odd_term: '47-1580', odd_term_index: 23 }
  ],
  859 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '54-1603', phase_index: 0, even_term: '2-2245', even_term_index: 0, odd_term: '17-2909', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '24-1096', phase_index: 0, even_term: '33-533', even_term_index: 2, odd_term: '48-1197', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '54-374', phase_index: 0, even_term: '3-1862', even_term_index: 4, odd_term: '18-2526', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '23-2417', phase_index: 0, even_term: '34-150', even_term_index: 6, odd_term: '49-815', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '53-1143', phase_index: 0, even_term: '4-1479', even_term_index: 8, odd_term: '19-2143', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '22-2503', phase_index: 0, even_term: '34-2807', even_term_index: 10, odd_term: '50-432', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '52-533', phase_index: 0, even_term: '5-1096', even_term_index: 12, odd_term: '20-1760', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '21-1362', phase_index: 0, even_term: '35-2425', even_term_index: 14, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 7, leaped: false, remainder: '50-2175', phase_index: 0, even_term: '6-713', even_term_index: 16, odd_term: '51-49', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '20-136', phase_index: 0, even_term: '36-2042', even_term_index: 18, odd_term: '21-1377', odd_term_index: 17 },
    # 計算上では9が小の月、10が大の月
    { is_many_days: false, month: 9, leaped: false, remainder: '49-1398', phase_index: 0, even_term: '7-330', even_term_index: 20, odd_term: '51-2706', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '18-2932', phase_index: 0, even_term: '37-1659', even_term_index: 22, odd_term: '22-995', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '48-1861', phase_index: 0, even_term: '7-2988', even_term_index: 0, odd_term: '52-2323', odd_term_index: 23 }
  ],
  860 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '48-1861', phase_index: 0, even_term: '7-2988', even_term_index: 0, odd_term: '52-2323', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '18-1095', phase_index: 0, even_term: '38-1276', even_term_index: 2, odd_term: '23-612', odd_term_index: 1 },
    # 計算上では1が小の月、2が大の月
    { is_many_days: false, month: 1, leaped: false, remainder: '48-391', phase_index: 0, even_term: '8-2605', even_term_index: 4, odd_term: '53-1940', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '17-2710', phase_index: 0, even_term: '39-893', even_term_index: 6, odd_term: '24-229', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '47-1788', phase_index: 0, even_term: '9-2222', even_term_index: 8, odd_term: '54-1558', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '17-600', phase_index: 0, even_term: '40-510', even_term_index: 10, odd_term: '24-2886', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '46-2183', phase_index: 0, even_term: '10-1839', even_term_index: 12, odd_term: '55-1175', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '16-302', phase_index: 0, even_term: '41-128', even_term_index: 14, odd_term: '25-2503', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '45-1331', phase_index: 0, even_term: '11-1456', even_term_index: 16, odd_term: '56-792', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '14-2316', phase_index: 0, even_term: '41-2785', even_term_index: 18, odd_term: '26-2120', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '44-260', phase_index: 0, even_term: '12-1073', even_term_index: 20, odd_term: '57-409', odd_term_index: 19 },
    # 計算上では閏9が10（小の月）、閏10が10（大の月）
    { is_many_days: false, month: 9, leaped: true, remainder: '13-1449', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '27-1738', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '42-2908', phase_index: 0, even_term: '42-2402', even_term_index: 22, odd_term: '58-26', odd_term_index: 23 }
  ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Daien' do
    describe 'Range' do
      describe 'AnnualRange' do
        describe 'get' do
          context 'all months every year' do
            # :reek:UtilityFunction
            def month_actual(month:)
              even_term = month.even_term
              odd_term = month.odd_term
              {
                is_many_days: month.many_days?,
                month: month.number,
                leaped: month.leaped?,
                remainder: month.remainder.format,
                phase_index: month.phase_index,
                even_term: even_term.remainder.format,
                even_term_index: even_term.index,
                odd_term: odd_term.remainder.format,
                odd_term_index: odd_term.index
              }
            end

            # :reek:UtilityFunction
            def error_message(fails)
              message = ''
              fails.each do |fail|
                message += "[year: #{fail[:year]}, \n" \
                    "actual: #{fail[:actual]}\n" \
                    "expect: #{fail[:expect]}]\n"
              end
              message
            end

            it 'should be expected values' do
              fails = []
              DAIEN_EXPECTED_MONTHS.each do |year, expects|
                actuals = \
                  Zakuro::Daien::Range::AnnualRange.get(
                    context: Zakuro::Context.new(version_name: 'Daien'),
                    western_year: year
                  )
                actuals.each_with_index do |month, index|
                  actual = month_actual(month: month)

                  next if actual.eql?(expects[index])

                  fails.push(year: year, actual: actual, expect: expects[index])
                end
              end

              expect(fails).to be_empty, error_message(fails)
            end
            # it 'call example' do
            #   Zakuro::Daien::Range::AnnualRange.get(
            #     context: Zakuro::Context.new(version_name: 'Daien'),
            #     western_year: 789
            #   )
            # end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
