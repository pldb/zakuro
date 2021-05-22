# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength
SENMYOU_EXPECTED_MONTHS = {
  1600 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '43-8015', phase_index: 0, even_term: '49-780', even_term_index: 0, odd_term: '4-2615', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '12-4851', phase_index: 0, even_term: '19-4451', even_term_index: 2, odd_term: '34-6286', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '42-847', phase_index: 0, even_term: '49-8122', even_term_index: 4, odd_term: '5-1558', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '11-4371', phase_index: 0, even_term: '20-3393', even_term_index: 6, odd_term: '35-5229', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '41-7161', phase_index: 0, even_term: '50-7065', even_term_index: 8, odd_term: '6-500', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '10-1359', phase_index: 0, even_term: '21-2336', even_term_index: 10, odd_term: '36-4171', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '39-4189', phase_index: 0, even_term: '51-6007', even_term_index: 12, odd_term: '6-7843', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '9-7384', phase_index: 0, even_term: '22-1278', even_term_index: 14, odd_term: '37-3114', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '38-2939', phase_index: 0, even_term: '52-4950', even_term_index: 16, odd_term: '7-6785', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '8-7705', phase_index: 0, even_term: '23-221', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '37-4914', phase_index: 0, even_term: '53-3892', even_term_index: 20, odd_term: '38-2056', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '7-2865', phase_index: 0, even_term: '23-7563', even_term_index: 22, odd_term: '8-5728', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '37-1008', phase_index: 0, even_term: '54-2835', even_term_index: 0, odd_term: '39-999', odd_term_index: 23 }
  ],
  1601 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '37-1008', phase_index: 0, even_term: '54-2835', even_term_index: 0, odd_term: '39-999', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '7-7329', phase_index: 0, even_term: '24-6506', even_term_index: 2, odd_term: '9-4670', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '36-4512', phase_index: 0, even_term: '55-1777', even_term_index: 4, odd_term: '39-8341', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '6-812', phase_index: 0, even_term: '25-5448', even_term_index: 6, odd_term: '10-3613', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '35-4625', phase_index: 0, even_term: '56-720', even_term_index: 8, odd_term: '40-7284', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '5-7569', phase_index: 0, even_term: '26-4391', even_term_index: 10, odd_term: '11-2555', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '34-1462', phase_index: 0, even_term: '56-8062', even_term_index: 12, odd_term: '41-6226', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '3-3678', phase_index: 0, even_term: '27-3333', even_term_index: 14, odd_term: '12-1498', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '33-6492', phase_index: 0, even_term: '57-7005', even_term_index: 16, odd_term: '42-5169', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '2-1690', phase_index: 0, even_term: '28-2276', even_term_index: 18, odd_term: '13-440', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '31-6153', phase_index: 0, even_term: '58-5947', even_term_index: 20, odd_term: '43-4111', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '1-3092', phase_index: 0, even_term: '29-1218', even_term_index: 22, odd_term: '13-7783', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '31-885', phase_index: 0, even_term: '59-4890', even_term_index: 0, odd_term: '44-3054', odd_term_index: 23 }
  ],
  1602 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '31-885', phase_index: 0, even_term: '59-4890', even_term_index: 0, odd_term: '44-3054', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: true,  remainder: '1-7771', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '14-6725', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '30-6061', phase_index: 0, even_term: '30-161', even_term_index: 2, odd_term: '45-1996', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '0-3546', phase_index: 0, even_term: '0-3832', even_term_index: 4, odd_term: '15-5668', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '30-160', phase_index: 0, even_term: '30-7503', even_term_index: 6, odd_term: '46-939', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '59-4268', phase_index: 0, even_term: '1-2775', even_term_index: 8, odd_term: '16-4610', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '29-7532', phase_index: 0, even_term: '31-6446', even_term_index: 10, odd_term: '46-8281', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '58-1608', phase_index: 0, even_term: '2-1717', even_term_index: 12, odd_term: '17-3553', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '27-3668', phase_index: 0, even_term: '32-5388', even_term_index: 14, odd_term: '47-7224', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '56-6168', phase_index: 0, even_term: '3-660', even_term_index: 16, odd_term: '18-2495', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '26-1062', phase_index: 0, even_term: '33-4331', even_term_index: 18, odd_term: '48-6166', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '55-5212', phase_index: 0, even_term: '3-8002', even_term_index: 20, odd_term: '19-1438', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '25-1866', phase_index: 0, even_term: '34-3273', even_term_index: 22, odd_term: '49-5109', odd_term_index: 23 }
  ],
  1603 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '55-7774', phase_index: 0, even_term: '4-6945', even_term_index: 0, odd_term: '20-380', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '24-5964', phase_index: 0, even_term: '35-2216', even_term_index: 2, odd_term: '50-4051', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '54-4234', phase_index: 0, even_term: '5-5887', even_term_index: 4, odd_term: '20-7723', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '24-1972', phase_index: 0, even_term: '36-1158', even_term_index: 6, odd_term: '51-2994', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '54-7270', phase_index: 0, even_term: '6-4830', even_term_index: 8, odd_term: '21-6665', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '23-3311', phase_index: 0, even_term: '37-101', even_term_index: 10, odd_term: '52-1936', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '53-6921', phase_index: 0, even_term: '7-3772', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 6, leaped: false, remainder: '22-1399', phase_index: 0, even_term: '37-7443', even_term_index: 14, odd_term: '22-5608', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '51-3937', phase_index: 0, even_term: '8-2715', even_term_index: 16, odd_term: '53-879', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '21-6408', phase_index: 0, even_term: '38-6386', even_term_index: 18, odd_term: '23-4550', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '50-1030', phase_index: 0, even_term: '9-1657', even_term_index: 20, odd_term: '53-8221', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '19-4907', phase_index: 0, even_term: '39-5328', even_term_index: 22, odd_term: '24-3493', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '49-1238', phase_index: 0, even_term: '10-600', even_term_index: 0, odd_term: '54-7164', odd_term_index: 23 }
  ],
  1604 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '49-1238', phase_index: 0, even_term: '10-600', even_term_index: 0, odd_term: '54-7164', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '19-6812', phase_index: 0, even_term: '40-4271', even_term_index: 2, odd_term: '25-2435', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '48-4357', phase_index: 0, even_term: '10-7942', even_term_index: 4, odd_term: '55-6106', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '18-2087', phase_index: 0, even_term: '41-3213', even_term_index: 6, odd_term: '26-1378', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '48-8219', phase_index: 0, even_term: '11-6885', even_term_index: 8, odd_term: '56-5049', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '17-5377', phase_index: 0, even_term: '42-2156', even_term_index: 10, odd_term: '27-320', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '47-1747', phase_index: 0, even_term: '12-5827', even_term_index: 12, odd_term: '57-3991', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '16-5735', phase_index: 0, even_term: '43-1098', even_term_index: 14, odd_term: '27-7663', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '46-816', phase_index: 0, even_term: '13-4770', even_term_index: 16, odd_term: '58-2934', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '15-4010', phase_index: 0, even_term: '44-41', even_term_index: 18, odd_term: '28-6605', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: true,  remainder: '45-6992', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '59-1876', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '14-1591', phase_index: 0, even_term: '14-3712', even_term_index: 20, odd_term: '29-5548', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '43-5198', phase_index: 0, even_term: '44-7383', even_term_index: 22, odd_term: '0-819', odd_term_index: 23 }
  ],
  1605 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '13-1232', phase_index: 0, even_term: '15-2655', even_term_index: 0, odd_term: '30-4490', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '42-6230', phase_index: 0, even_term: '45-6326', even_term_index: 2, odd_term: '0-8161', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '12-3072', phase_index: 0, even_term: '16-1597', even_term_index: 4, odd_term: '31-3433', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '42-112', phase_index: 0, even_term: '46-5268', even_term_index: 6, odd_term: '1-7104', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '11-5709', phase_index: 0, even_term: '17-540', even_term_index: 8, odd_term: '32-2375', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '41-2924', phase_index: 0, even_term: '47-4211', even_term_index: 10, odd_term: '2-6046', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '11-8009', phase_index: 0, even_term: '17-7882', even_term_index: 12, odd_term: '33-1318', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '40-4081', phase_index: 0, even_term: '48-3153', even_term_index: 14, odd_term: '3-4989', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '10-8256', phase_index: 0, even_term: '18-6825', even_term_index: 16, odd_term: '34-260', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '39-3746', phase_index: 0, even_term: '49-2096', even_term_index: 18, odd_term: '4-3931', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '9-7425', phase_index: 0, even_term: '19-5767', even_term_index: 20, odd_term: '34-7603', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '38-2540', phase_index: 0, even_term: '50-1038', even_term_index: 22, odd_term: '5-2874', odd_term_index: 23 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '7-6071', phase_index: 0, even_term: '20-4710', even_term_index: 0, odd_term: '35-6545', odd_term_index: 1 }
  ],
  1606 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '7-6071', phase_index: 0, even_term: '20-4710', even_term_index: 0, odd_term: '35-6545', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '37-1716', phase_index: 0, even_term: '50-8381', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '6-6020', phase_index: 0, even_term: '21-3652', even_term_index: 4, odd_term: '6-1816', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '36-2125', phase_index: 0, even_term: '51-7323', even_term_index: 6, odd_term: '36-5488', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '6-6841', phase_index: 0, even_term: '22-2595', even_term_index: 8, odd_term: '7-759', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '35-3365', phase_index: 0, even_term: '52-6266', even_term_index: 10, odd_term: '37-4430', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '5-111', phase_index: 0, even_term: '23-1537', even_term_index: 12, odd_term: '7-8101', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '34-5358', phase_index: 0, even_term: '53-5208', even_term_index: 14, odd_term: '38-3373', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '4-2054', phase_index: 0, even_term: '24-480', even_term_index: 16, odd_term: '8-7044', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '34-6901', phase_index: 0, even_term: '54-4151', even_term_index: 18, odd_term: '39-2315', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '3-3128', phase_index: 0, even_term: '24-7822', even_term_index: 20, odd_term: '9-5986', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '33-7545', phase_index: 0, even_term: '55-3093', even_term_index: 22, odd_term: '40-1258', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '2-3344', phase_index: 0, even_term: '25-6765', even_term_index: 0, odd_term: '10-4929', odd_term_index: 23 }
  ],
  1607 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '2-3344', phase_index: 0, even_term: '25-6765', even_term_index: 0, odd_term: '10-4929', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '32-7340', phase_index: 0, even_term: '56-2036', even_term_index: 2, odd_term: '41-200', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '1-2541', phase_index: 0, even_term: '26-5707', even_term_index: 4, odd_term: '11-3871', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '30-6153', phase_index: 0, even_term: '57-978', even_term_index: 6, odd_term: '41-7543', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '0-1538', phase_index: 0, even_term: '27-4650', even_term_index: 8, odd_term: '12-2814', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '29-5524', phase_index: 0, even_term: '57-8321', even_term_index: 10, odd_term: '42-6485', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: true,  remainder: '59-1355', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '13-1756', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '28-5877', phase_index: 0, even_term: '28-3592', even_term_index: 12, odd_term: '43-5428', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '58-2501', phase_index: 0, even_term: '58-7263', even_term_index: 14, odd_term: '14-699', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '28-8060', phase_index: 0, even_term: '29-2535', even_term_index: 16, odd_term: '44-4370', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '57-5192', phase_index: 0, even_term: '59-6206', even_term_index: 18, odd_term: '14-8041', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '27-2145', phase_index: 0, even_term: '30-1477', even_term_index: 20, odd_term: '45-3313', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '57-7299', phase_index: 0, even_term: '0-5148', even_term_index: 22, odd_term: '15-6984', odd_term_index: 23 }
  ],
  1608 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '26-3825', phase_index: 0, even_term: '31-420', even_term_index: 0, odd_term: '46-2255', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '56-8293', phase_index: 0, even_term: '1-4091', even_term_index: 2, odd_term: '16-5926', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '25-3549', phase_index: 0, even_term: '31-7762', even_term_index: 4, odd_term: '47-1198', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '55-6619', phase_index: 0, even_term: '2-3033', even_term_index: 6, odd_term: '17-4869', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '24-1299', phase_index: 0, even_term: '32-6705', even_term_index: 8, odd_term: '48-140', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '53-4582', phase_index: 0, even_term: '3-1976', even_term_index: 10, odd_term: '18-3811', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '23-8142', phase_index: 0, even_term: '33-5647', even_term_index: 12, odd_term: '48-7483', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '52-3693', phase_index: 0, even_term: '4-918', even_term_index: 14, odd_term: '19-2754', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '22-9', phase_index: 0, even_term: '34-4590', even_term_index: 16, odd_term: '49-6425', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '51-5488', phase_index: 0, even_term: '4-8261', even_term_index: 18, odd_term: '20-1696', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '21-3155', phase_index: 0, even_term: '35-3532', even_term_index: 20, odd_term: '50-5368', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '51-816', phase_index: 0, even_term: '5-7203', even_term_index: 22, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 11, leaped: false, remainder: '21-6684', phase_index: 0, even_term: '36-2475', even_term_index: 0, odd_term: '21-639', odd_term_index: 23 }
  ],
  1609 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '21-6684', phase_index: 0, even_term: '36-2475', even_term_index: 0, odd_term: '21-639', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '50-3853', phase_index: 0, even_term: '6-6146', even_term_index: 2, odd_term: '51-4310', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '20-253', phase_index: 0, even_term: '37-1417', even_term_index: 4, odd_term: '21-7981', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '49-4179', phase_index: 0, even_term: '7-5088', even_term_index: 6, odd_term: '52-3253', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '19-7263', phase_index: 0, even_term: '38-360', even_term_index: 8, odd_term: '22-6924', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '48-1392', phase_index: 0, even_term: '8-4031', even_term_index: 10, odd_term: '53-2195', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '17-4016', phase_index: 0, even_term: '38-7702', even_term_index: 12, odd_term: '23-5866', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '47-6929', phase_index: 0, even_term: '9-2973', even_term_index: 14, odd_term: '54-1138', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '16-2103', phase_index: 0, even_term: '39-6645', even_term_index: 16, odd_term: '24-4809', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '46-6471', phase_index: 0, even_term: '10-1916', even_term_index: 18, odd_term: '55-80', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '15-3296', phase_index: 0, even_term: '40-5587', even_term_index: 20, odd_term: '25-3751', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '45-944', phase_index: 0, even_term: '11-858', even_term_index: 22, odd_term: '55-7423', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '15-7554', phase_index: 0, even_term: '41-4530', even_term_index: 0, odd_term: '26-2694', odd_term_index: 23 }
  ],
  1610 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '15-7554', phase_index: 0, even_term: '41-4530', even_term_index: 0, odd_term: '26-2694', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '44-5706', phase_index: 0, even_term: '11-8201', even_term_index: 2, odd_term: '56-6365', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '14-3285', phase_index: 0, even_term: '42-3472', even_term_index: 4, odd_term: '27-1636', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '44-8398', phase_index: 0, even_term: '12-7143', even_term_index: 6, odd_term: '57-5308', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: true,  remainder: '13-4226', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '28-579', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '43-7562', phase_index: 0, even_term: '43-2415', even_term_index: 8, odd_term: '58-4250', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '12-1708', phase_index: 0, even_term: '13-6086', even_term_index: 10, odd_term: '28-7921', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '41-3813', phase_index: 0, even_term: '44-1357', even_term_index: 12, odd_term: '59-3193', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '10-6265', phase_index: 0, even_term: '14-5028', even_term_index: 14, odd_term: '29-6864', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '40-1086', phase_index: 0, even_term: '45-300', even_term_index: 16, odd_term: '0-2135', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '9-5143', phase_index: 0, even_term: '15-3971', even_term_index: 18, odd_term: '30-5806', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '39-1668', phase_index: 0, even_term: '45-7642', even_term_index: 20, odd_term: '1-1078', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '9-7484', phase_index: 0, even_term: '16-2913', even_term_index: 22, odd_term: '31-4749', odd_term_index: 23 }
  ],
  1611 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '38-5688', phase_index: 0, even_term: '46-6585', even_term_index: 0, odd_term: '2-20', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '8-4235', phase_index: 0, even_term: '17-1856', even_term_index: 2, odd_term: '32-3691', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '38-2104', phase_index: 0, even_term: '47-5527', even_term_index: 4, odd_term: '2-7363', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '8-7521', phase_index: 0, even_term: '18-798', even_term_index: 6, odd_term: '33-2634', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '37-3645', phase_index: 0, even_term: '48-4470', even_term_index: 8, odd_term: '3-6305', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '7-7303', phase_index: 0, even_term: '18-8141', even_term_index: 10, odd_term: '34-1576', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '36-1744', phase_index: 0, even_term: '49-3412', even_term_index: 12, odd_term: '4-5248', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '5-3933', phase_index: 0, even_term: '19-7083', even_term_index: 14, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '34-6164', phase_index: 0, even_term: '50-2355', even_term_index: 16, odd_term: '35-519', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '4-669', phase_index: 0, even_term: '20-6026', even_term_index: 18, odd_term: '5-4190', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '33-4422', phase_index: 0, even_term: '51-1297', even_term_index: 20, odd_term: '35-7861', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '3-665', phase_index: 0, even_term: '21-4968', even_term_index: 22, odd_term: '6-3133', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '32-6170', phase_index: 0, even_term: '52-240', even_term_index: 0, odd_term: '36-6804', odd_term_index: 23 }
  ],
  1612 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '32-6170', phase_index: 0, even_term: '52-240', even_term_index: 0, odd_term: '36-6804', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '2-4089', phase_index: 0, even_term: '22-3911', even_term_index: 2, odd_term: '7-2075', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '32-2290', phase_index: 0, even_term: '52-7582', even_term_index: 4, odd_term: '37-5746', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '2-328', phase_index: 0, even_term: '23-2853', even_term_index: 6, odd_term: '8-1018', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '31-6018', phase_index: 0, even_term: '53-6525', even_term_index: 8, odd_term: '38-4689', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '1-2453', phase_index: 0, even_term: '24-1796', even_term_index: 10, odd_term: '8-8360', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '31-6450', phase_index: 0, even_term: '54-5467', even_term_index: 12, odd_term: '39-3631', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '0-1263', phase_index: 0, even_term: '25-738', even_term_index: 14, odd_term: '9-7303', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '29-4002', phase_index: 0, even_term: '55-4410', even_term_index: 16, odd_term: '40-2574', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '59-6531', phase_index: 0, even_term: '25-8081', even_term_index: 18, odd_term: '10-6245', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '28-845', phase_index: 0, even_term: '56-3352', even_term_index: 20, odd_term: '41-1516', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '57-4323', phase_index: 0, even_term: '26-7023', even_term_index: 22, odd_term: '11-5188', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: true,  remainder: '27-264', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '42-459', odd_term_index: 23 }
  ],
  1613 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '56-5462', phase_index: 0, even_term: '57-2295', even_term_index: 0, odd_term: '12-4130', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '26-2804', phase_index: 0, even_term: '27-5966', even_term_index: 2, odd_term: '42-7801', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '56-368', phase_index: 0, even_term: '58-1237', even_term_index: 4, odd_term: '13-3073', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '26-6451', phase_index: 0, even_term: '28-4908', even_term_index: 6, odd_term: '43-6744', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '55-3920', phase_index: 0, even_term: '59-180', even_term_index: 8, odd_term: '14-2015', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '25-657', phase_index: 0, even_term: '29-3851', even_term_index: 10, odd_term: '44-5686', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '54-5018', phase_index: 0, even_term: '59-7522', even_term_index: 12, odd_term: '15-958', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '24-338', phase_index: 0, even_term: '30-2793', even_term_index: 14, odd_term: '45-4629', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '53-3757', phase_index: 0, even_term: '0-6465', even_term_index: 16, odd_term: '15-8300', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '23-6911', phase_index: 0, even_term: '31-1736', even_term_index: 18, odd_term: '46-3571', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '52-1541', phase_index: 0, even_term: '1-5407', even_term_index: 20, odd_term: '16-7243', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '21-4826', phase_index: 0, even_term: '32-678', even_term_index: 22, odd_term: '47-2514', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '51-471', phase_index: 0, even_term: '2-4350', even_term_index: 0, odd_term: '17-6185', odd_term_index: 1 }
  ],
  1614 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '51-471', phase_index: 0, even_term: '2-4350', even_term_index: 0, odd_term: '17-6185', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '20-5232', phase_index: 0, even_term: '32-8021', even_term_index: 2, odd_term: '48-1456', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '50-1869', phase_index: 0, even_term: '3-3292', even_term_index: 4, odd_term: '18-5128', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '20-7116', phase_index: 0, even_term: '33-6963', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '49-4151', phase_index: 0, even_term: '4-2235', even_term_index: 8, odd_term: '49-399', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '19-1314', phase_index: 0, even_term: '34-5906', even_term_index: 10, odd_term: '19-4070', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '49-6696', phase_index: 0, even_term: '5-1177', even_term_index: 12, odd_term: '49-7741', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '18-3043', phase_index: 0, even_term: '35-4848', even_term_index: 14, odd_term: '20-3013', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '48-7435', phase_index: 0, even_term: '6-120', even_term_index: 16, odd_term: '50-6684', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '17-3136', phase_index: 0, even_term: '36-3791', even_term_index: 18, odd_term: '21-1955', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '47-7018', phase_index: 0, even_term: '6-7462', even_term_index: 20, odd_term: '51-5626', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '16-2294', phase_index: 0, even_term: '37-2733', even_term_index: 22, odd_term: '22-898', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '45-5854', phase_index: 0, even_term: '7-6405', even_term_index: 0, odd_term: '52-4569', odd_term_index: 23 }
  ],
  1615 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '45-5854', phase_index: 0, even_term: '7-6405', even_term_index: 0, odd_term: '52-4569', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '15-1249', phase_index: 0, even_term: '38-1676', even_term_index: 2, odd_term: '22-8240', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '44-5361', phase_index: 0, even_term: '8-5347', even_term_index: 4, odd_term: '53-3511', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '14-1281', phase_index: 0, even_term: '39-618', even_term_index: 6, odd_term: '23-7183', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '43-5800', phase_index: 0, even_term: '9-4290', even_term_index: 8, odd_term: '54-2454', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '13-2121', phase_index: 0, even_term: '39-7961', even_term_index: 10, odd_term: '24-6125', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '43-7083', phase_index: 0, even_term: '10-3232', even_term_index: 12, odd_term: '55-1396', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '12-3842', phase_index: 0, even_term: '40-6903', even_term_index: 14, odd_term: '25-5068', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: true,  remainder: '42-691', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '56-339', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '11-5738', phase_index: 0, even_term: '11-2175', even_term_index: 16, odd_term: '26-4010', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '41-2168', phase_index: 0, even_term: '41-5846', even_term_index: 18, odd_term: '56-7681', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '11-6773', phase_index: 0, even_term: '12-1117', even_term_index: 20, odd_term: '27-2953', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '40-2783', phase_index: 0, even_term: '42-4788', even_term_index: 22, odd_term: '57-6624', odd_term_index: 23 }
  ],
  1616 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '10-6958', phase_index: 0, even_term: '13-60', even_term_index: 0, odd_term: '28-1895', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '39-2364', phase_index: 0, even_term: '43-3731', even_term_index: 2, odd_term: '58-5566', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '8-5832', phase_index: 0, even_term: '13-7402', even_term_index: 4, odd_term: '29-838', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '38-1038', phase_index: 0, even_term: '44-2673', even_term_index: 6, odd_term: '59-4509', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '7-4828', phase_index: 0, even_term: '14-6345', even_term_index: 8, odd_term: '29-8180', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '37-448', phase_index: 0, even_term: '45-1616', even_term_index: 10, odd_term: '0-3451', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '6-4749', phase_index: 0, even_term: '15-5287', even_term_index: 12, odd_term: '30-7123', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '36-1054', phase_index: 0, even_term: '46-558', even_term_index: 14, odd_term: '1-2394', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '6-6426', phase_index: 0, even_term: '16-4230', even_term_index: 16, odd_term: '31-6065', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '35-3700', phase_index: 0, even_term: '46-7901', even_term_index: 18, odd_term: '2-1336', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '5-834', phase_index: 0, even_term: '17-3172', even_term_index: 20, odd_term: '32-5008', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '34-6191', phase_index: 0, even_term: '47-6843', even_term_index: 22, odd_term: '3-279', odd_term_index: 23 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '4-2908', phase_index: 0, even_term: '18-2115', even_term_index: 0, odd_term: '33-3950', odd_term_index: 1 }
  ],
  1617 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '4-2908', phase_index: 0, even_term: '18-2115', even_term_index: 0, odd_term: '33-3950', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '34-7718', phase_index: 0, even_term: '48-5786', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '3-3334', phase_index: 0, even_term: '19-1057', even_term_index: 4, odd_term: '3-7621', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '33-6601', phase_index: 0, even_term: '49-4728', even_term_index: 6, odd_term: '34-2893', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '2-1132', phase_index: 0, even_term: '20-0', even_term_index: 8, odd_term: '4-6564', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '31-4217', phase_index: 0, even_term: '50-3671', even_term_index: 10, odd_term: '35-1835', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '1-7550', phase_index: 0, even_term: '20-7342', even_term_index: 12, odd_term: '5-5506', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '30-2813', phase_index: 0, even_term: '51-2613', even_term_index: 14, odd_term: '36-778', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '0-7154', phase_index: 0, even_term: '21-6285', even_term_index: 16, odd_term: '6-4449', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '29-3883', phase_index: 0, even_term: '52-1556', even_term_index: 18, odd_term: '36-8120', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '59-1362', phase_index: 0, even_term: '22-5227', even_term_index: 20, odd_term: '7-3391', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '29-7561', phase_index: 0, even_term: '53-498', even_term_index: 22, odd_term: '37-7063', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '58-5224', phase_index: 0, even_term: '23-4170', even_term_index: 0, odd_term: '8-2334', odd_term_index: 23 }
  ],
  1618 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '58-5224', phase_index: 0, even_term: '23-4170', even_term_index: 0, odd_term: '8-2334', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '28-2667', phase_index: 0, even_term: '53-7841', even_term_index: 2, odd_term: '38-6005', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '58-7862', phase_index: 0, even_term: '24-3112', even_term_index: 4, odd_term: '9-1276', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '27-3802', phase_index: 0, even_term: '54-6783', even_term_index: 6, odd_term: '39-4948', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '57-7245', phase_index: 0, even_term: '25-2055', even_term_index: 8, odd_term: '10-219', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true,  remainder: '26-1534', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '40-3890', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '55-3979', phase_index: 0, even_term: '55-5726', even_term_index: 10, odd_term: '10-7561', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '25-6657', phase_index: 0, even_term: '26-997', even_term_index: 12, odd_term: '41-2833', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '54-1446', phase_index: 0, even_term: '56-4668', even_term_index: 14, odd_term: '11-6504', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '23-5435', phase_index: 0, even_term: '26-8340', even_term_index: 16, odd_term: '42-1775', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '53-1860', phase_index: 0, even_term: '57-3611', even_term_index: 18, odd_term: '12-5446', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '23-7543', phase_index: 0, even_term: '27-7282', even_term_index: 20, odd_term: '43-718', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '52-5602', phase_index: 0, even_term: '58-2553', even_term_index: 22, odd_term: '13-4389', odd_term_index: 23 }
  ],
  1619 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '22-3910', phase_index: 0, even_term: '28-6225', even_term_index: 0, odd_term: '43-8060', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '52-1863', phase_index: 0, even_term: '59-1496', even_term_index: 2, odd_term: '14-3331', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '22-7391', phase_index: 0, even_term: '29-5167', even_term_index: 4, odd_term: '44-7003', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '51-3624', phase_index: 0, even_term: '0-438', even_term_index: 6, odd_term: '15-2274', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '21-7372', phase_index: 0, even_term: '30-4110', even_term_index: 8, odd_term: '45-5945', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '50-1856', phase_index: 0, even_term: '0-7781', even_term_index: 10, odd_term: '16-1216', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '19-4072', phase_index: 0, even_term: '31-3052', even_term_index: 12, odd_term: '46-4888', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '48-6222', phase_index: 0, even_term: '1-6723', even_term_index: 14, odd_term: '17-159', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '18-672', phase_index: 0, even_term: '32-1995', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '47-4321', phase_index: 0, even_term: '2-5666', even_term_index: 18, odd_term: '47-3830', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '17-445', phase_index: 0, even_term: '33-937', even_term_index: 20, odd_term: '17-7501', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '46-5858', phase_index: 0, even_term: '3-4608', even_term_index: 22, odd_term: '48-2773', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '16-3714', phase_index: 0, even_term: '33-8280', even_term_index: 0, odd_term: '18-6444', odd_term_index: 23 }
  ],
  1620 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '16-3714', phase_index: 0, even_term: '33-8280', even_term_index: 0, odd_term: '18-6444', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '46-2245', phase_index: 0, even_term: '4-3551', even_term_index: 2, odd_term: '49-1715', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '16-466', phase_index: 0, even_term: '34-7222', even_term_index: 4, odd_term: '19-5386', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '45-6285', phase_index: 0, even_term: '5-2493', even_term_index: 6, odd_term: '50-658', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '15-2831', phase_index: 0, even_term: '35-6165', even_term_index: 8, odd_term: '20-4329', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '45-6879', phase_index: 0, even_term: '6-1436', even_term_index: 10, odd_term: '50-8000', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '14-1706', phase_index: 0, even_term: '36-5107', even_term_index: 12, odd_term: '21-3271', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '43-4158', phase_index: 0, even_term: '7-378', even_term_index: 14, odd_term: '51-6943', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '13-6320', phase_index: 0, even_term: '37-4050', even_term_index: 16, odd_term: '22-2214', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '42-470', phase_index: 0, even_term: '7-7721', even_term_index: 18, odd_term: '52-5885', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '11-3826', phase_index: 0, even_term: '38-2992', even_term_index: 20, odd_term: '23-1156', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '41-8047', phase_index: 0, even_term: '8-6663', even_term_index: 22, odd_term: '53-4828', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '10-4761', phase_index: 0, even_term: '39-1935', even_term_index: 0, odd_term: '24-99', odd_term_index: 23 }
  ],
  1621 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '10-4761', phase_index: 0, even_term: '39-1935', even_term_index: 0, odd_term: '24-99', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '40-2328', phase_index: 0, even_term: '9-5606', even_term_index: 2, odd_term: '54-3770', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: true,  remainder: '10-381', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '24-7441', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '40-6916', phase_index: 0, even_term: '40-877', even_term_index: 4, odd_term: '55-2713', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '9-4572', phase_index: 0, even_term: '10-4548', even_term_index: 6, odd_term: '25-6384', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '39-1403', phase_index: 0, even_term: '40-8220', even_term_index: 8, odd_term: '56-1655', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '8-5800', phase_index: 0, even_term: '11-3491', even_term_index: 10, odd_term: '26-5326', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '38-976', phase_index: 0, even_term: '41-7162', even_term_index: 12, odd_term: '57-598', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '7-3948', phase_index: 0, even_term: '12-2433', even_term_index: 14, odd_term: '27-4269', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '37-6631', phase_index: 0, even_term: '42-6105', even_term_index: 16, odd_term: '57-7940', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '6-835', phase_index: 0, even_term: '13-1376', even_term_index: 18, odd_term: '28-3211', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '35-3933', phase_index: 0, even_term: '43-5047', even_term_index: 20, odd_term: '58-6883', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '5-7880', phase_index: 0, even_term: '14-318', even_term_index: 22, odd_term: '29-2154', odd_term_index: 23 }
  ],
  1622 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '34-4269', phase_index: 0, even_term: '44-3990', even_term_index: 0, odd_term: '59-5825', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '4-1383', phase_index: 0, even_term: '14-7661', even_term_index: 2, odd_term: '30-1096', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '34-7154', phase_index: 0, even_term: '45-2932', even_term_index: 4, odd_term: '0-4768', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '3-4706', phase_index: 0, even_term: '15-6603', even_term_index: 6, odd_term: '31-39', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '33-2292', phase_index: 0, even_term: '46-1875', even_term_index: 8, odd_term: '1-3710', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '3-7783', phase_index: 0, even_term: '16-5546', even_term_index: 10, odd_term: '31-7381', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '32-4117', phase_index: 0, even_term: '47-817', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 6, leaped: false, remainder: '2-8130', phase_index: 0, even_term: '17-4488', even_term_index: 14, odd_term: '2-2653', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '31-3364', phase_index: 0, even_term: '47-8160', even_term_index: 16, odd_term: '32-6324', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '1-6724', phase_index: 0, even_term: '18-3431', even_term_index: 18, odd_term: '3-1595', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '30-1478', phase_index: 0, even_term: '48-7102', even_term_index: 20, odd_term: '33-5266', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '59-4627', phase_index: 0, even_term: '19-2373', even_term_index: 22, odd_term: '4-538', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '29-8300', phase_index: 0, even_term: '49-6045', even_term_index: 0, odd_term: '34-4209', odd_term_index: 23 }
  ],
  1623 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '29-8300', phase_index: 0, even_term: '49-6045', even_term_index: 0, odd_term: '34-4209', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '58-4364', phase_index: 0, even_term: '20-1316', even_term_index: 2, odd_term: '4-7880', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '28-788', phase_index: 0, even_term: '50-4987', even_term_index: 4, odd_term: '35-3151', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '57-5849', phase_index: 0, even_term: '21-258', even_term_index: 6, odd_term: '5-6823', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '27-2702', phase_index: 0, even_term: '51-3930', even_term_index: 8, odd_term: '36-2094', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '57-8124', phase_index: 0, even_term: '21-7601', even_term_index: 10, odd_term: '6-5765', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '26-5224', phase_index: 0, even_term: '52-2872', even_term_index: 12, odd_term: '37-1036', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '56-1868', phase_index: 0, even_term: '22-6543', even_term_index: 14, odd_term: '7-4708', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '26-6474', phase_index: 0, even_term: '53-1815', even_term_index: 16, odd_term: '37-8379', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '55-2404', phase_index: 0, even_term: '23-5486', even_term_index: 18, odd_term: '8-3650', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: true,  remainder: '25-6476', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '38-7321', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '54-1943', phase_index: 0, even_term: '54-757', even_term_index: 20, odd_term: '9-2593', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '23-5631', phase_index: 0, even_term: '24-4428', even_term_index: 22, odd_term: '39-6264', odd_term_index: 23 }
  ],
  1624 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '53-897', phase_index: 0, even_term: '54-8100', even_term_index: 0, odd_term: '10-1535', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '22-4833', phase_index: 0, even_term: '25-3371', even_term_index: 2, odd_term: '40-5206', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '52-563', phase_index: 0, even_term: '55-7042', even_term_index: 4, odd_term: '11-478', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '21-4881', phase_index: 0, even_term: '26-2313', even_term_index: 6, odd_term: '41-4149', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '51-1013', phase_index: 0, even_term: '56-5985', even_term_index: 8, odd_term: '11-7820', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '20-5770', phase_index: 0, even_term: '27-1256', even_term_index: 10, odd_term: '42-3091', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '50-2371', phase_index: 0, even_term: '57-4927', even_term_index: 12, odd_term: '12-6763', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '20-7612', phase_index: 0, even_term: '28-198', even_term_index: 14, odd_term: '43-2034', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '49-4449', phase_index: 0, even_term: '58-3870', even_term_index: 16, odd_term: '13-5705', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '19-1067', phase_index: 0, even_term: '28-7541', even_term_index: 18, odd_term: '44-976', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '48-5883', phase_index: 0, even_term: '59-2812', even_term_index: 20, odd_term: '14-4648', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '18-2082', phase_index: 0, even_term: '29-6483', even_term_index: 22, odd_term: '44-8319', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '48-6459', phase_index: 0, even_term: '0-1755', even_term_index: 0, odd_term: '15-3590', odd_term_index: 1 }
  ],
  1625 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '48-6459', phase_index: 0, even_term: '0-1755', even_term_index: 0, odd_term: '15-3590', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '17-2132', phase_index: 0, even_term: '30-5426', even_term_index: 2, odd_term: '45-7261', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '46-5629', phase_index: 0, even_term: '1-697', even_term_index: 4, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 2, leaped: false, remainder: '16-667', phase_index: 0, even_term: '31-4368', even_term_index: 6, odd_term: '16-2533', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '45-4270', phase_index: 0, even_term: '1-8040', even_term_index: 8, odd_term: '46-6204', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '15-8072', phase_index: 0, even_term: '32-3311', even_term_index: 10, odd_term: '17-1475', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '44-3758', phase_index: 0, even_term: '2-6982', even_term_index: 12, odd_term: '47-5146', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '14-8168', phase_index: 0, even_term: '33-2253', even_term_index: 14, odd_term: '18-418', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '43-4831', phase_index: 0, even_term: '3-5925', even_term_index: 16, odd_term: '48-4089', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '13-2087', phase_index: 0, even_term: '34-1196', even_term_index: 18, odd_term: '18-7760', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '43-7788', phase_index: 0, even_term: '4-4867', even_term_index: 20, odd_term: '49-3031', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '12-4927', phase_index: 0, even_term: '35-138', even_term_index: 22, odd_term: '19-6703', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '42-1865', phase_index: 0, even_term: '5-3810', even_term_index: 0, odd_term: '50-1974', odd_term_index: 23 }
  ],
  1626 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '42-1865', phase_index: 0, even_term: '5-3810', even_term_index: 0, odd_term: '50-1974', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '12-6941', phase_index: 0, even_term: '35-7481', even_term_index: 2, odd_term: '20-5645', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '41-2958', phase_index: 0, even_term: '6-2752', even_term_index: 4, odd_term: '51-916', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '11-6547', phase_index: 0, even_term: '36-6423', even_term_index: 6, odd_term: '21-4588', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '40-1090', phase_index: 0, even_term: '7-1695', even_term_index: 8, odd_term: '51-8259', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '9-3995', phase_index: 0, even_term: '37-5366', even_term_index: 10, odd_term: '22-3530', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: true,  remainder: '39-7122', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '52-7201', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '8-2121', phase_index: 0, even_term: '8-637', even_term_index: 12, odd_term: '23-2473', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '37-6091', phase_index: 0, even_term: '38-4308', even_term_index: 14, odd_term: '53-6144', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '7-2446', phase_index: 0, even_term: '8-7980', even_term_index: 16, odd_term: '24-1415', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '37-7997', phase_index: 0, even_term: '39-3251', even_term_index: 18, odd_term: '54-5086', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '6-5794', phase_index: 0, even_term: '9-6922', even_term_index: 20, odd_term: '25-358', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '36-3633', phase_index: 0, even_term: '40-2193', even_term_index: 22, odd_term: '55-4029', odd_term_index: 23 }
  ],
  1627 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '6-1272', phase_index: 0, even_term: '10-5865', even_term_index: 0, odd_term: '25-7700', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '36-6871', phase_index: 0, even_term: '41-1136', even_term_index: 2, odd_term: '56-2971', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '5-3206', phase_index: 0, even_term: '11-4807', even_term_index: 4, odd_term: '26-6643', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '35-7059', phase_index: 0, even_term: '42-78', even_term_index: 6, odd_term: '57-1914', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '4-1660', phase_index: 0, even_term: '12-3750', even_term_index: 8, odd_term: '27-5585', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '33-4069', phase_index: 0, even_term: '42-7421', even_term_index: 10, odd_term: '58-856', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '3-6542', phase_index: 0, even_term: '13-2692', even_term_index: 12, odd_term: '28-4528', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '32-992', phase_index: 0, even_term: '43-6363', even_term_index: 14, odd_term: '58-8199', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '1-4599', phase_index: 0, even_term: '14-1635', even_term_index: 16, odd_term: '29-3470', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '31-621', phase_index: 0, even_term: '44-5306', even_term_index: 18, odd_term: '59-7141', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '0-5916', phase_index: 0, even_term: '15-577', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '30-3651', phase_index: 0, even_term: '45-4248', even_term_index: 22, odd_term: '30-2413', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '0-1992', phase_index: 0, even_term: '15-7920', even_term_index: 0, odd_term: '0-6084', odd_term_index: 23 }
  ],
  1628 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '0-1992', phase_index: 0, even_term: '15-7920', even_term_index: 0, odd_term: '0-6084', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '30-251', phase_index: 0, even_term: '46-3191', even_term_index: 2, odd_term: '31-1355', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '59-6168', phase_index: 0, even_term: '16-6862', even_term_index: 4, odd_term: '1-5026', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '29-2819', phase_index: 0, even_term: '47-2133', even_term_index: 6, odd_term: '32-298', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '59-6981', phase_index: 0, even_term: '17-5805', even_term_index: 8, odd_term: '2-3969', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '28-1856', phase_index: 0, even_term: '48-1076', even_term_index: 10, odd_term: '32-7640', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '57-4346', phase_index: 0, even_term: '18-4747', even_term_index: 12, odd_term: '3-2911', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '27-6358', phase_index: 0, even_term: '49-18', even_term_index: 14, odd_term: '33-6583', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '56-444', phase_index: 0, even_term: '19-3690', even_term_index: 16, odd_term: '4-1854', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '25-3708', phase_index: 0, even_term: '49-7361', even_term_index: 18, odd_term: '34-5525', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '55-7825', phase_index: 0, even_term: '20-2632', even_term_index: 20, odd_term: '5-796', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '24-4421', phase_index: 0, even_term: '50-6303', even_term_index: 22, odd_term: '35-4468', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '54-1898', phase_index: 0, even_term: '21-1575', even_term_index: 0, odd_term: '5-8139', odd_term_index: 23 }
  ],
  1629 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '54-1898', phase_index: 0, even_term: '21-1575', even_term_index: 0, odd_term: '5-8139', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '24-175', phase_index: 0, even_term: '51-5246', even_term_index: 2, odd_term: '36-3410', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '54-7050', phase_index: 0, even_term: '22-517', even_term_index: 4, odd_term: '6-7081', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '23-4855', phase_index: 0, even_term: '52-4188', even_term_index: 6, odd_term: '37-2353', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: true,  remainder: '53-1803', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '7-6024', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '22-6261', phase_index: 0, even_term: '22-7860', even_term_index: 8, odd_term: '38-1295', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '52-1477', phase_index: 0, even_term: '53-3131', even_term_index: 10, odd_term: '8-4966', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '21-4285', phase_index: 0, even_term: '23-6802', even_term_index: 12, odd_term: '39-238', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '51-6556', phase_index: 0, even_term: '54-2073', even_term_index: 14, odd_term: '9-3909', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '20-456', phase_index: 0, even_term: '24-5745', even_term_index: 16, odd_term: '39-7580', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '49-3425', phase_index: 0, even_term: '55-1016', even_term_index: 18, odd_term: '10-2851', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '19-7245', phase_index: 0, even_term: '25-4687', even_term_index: 20, odd_term: '40-6523', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '48-3554', phase_index: 0, even_term: '55-8358', even_term_index: 22, odd_term: '11-1794', odd_term_index: 23 }
  ],
  1630 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '18-716', phase_index: 0, even_term: '26-3630', even_term_index: 0, odd_term: '41-5465', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '48-6969', phase_index: 0, even_term: '56-7301', even_term_index: 2, odd_term: '12-736', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '17-5010', phase_index: 0, even_term: '27-2572', even_term_index: 4, odd_term: '42-4408', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '47-2944', phase_index: 0, even_term: '57-6243', even_term_index: 6, odd_term: '12-8079', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '17-162', phase_index: 0, even_term: '28-1515', even_term_index: 8, odd_term: '43-3350', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '46-4941', phase_index: 0, even_term: '58-5186', even_term_index: 10, odd_term: '13-7021', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '16-505', phase_index: 0, even_term: '29-457', even_term_index: 12, odd_term: '44-2293', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '45-3753', phase_index: 0, even_term: '59-4128', even_term_index: 14, odd_term: '14-5964', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '15-6645', phase_index: 0, even_term: '29-7800', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 8, leaped: false, remainder: '44-921', phase_index: 0, even_term: '0-3071', even_term_index: 18, odd_term: '45-1235', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '13-3735', phase_index: 0, even_term: '30-6742', even_term_index: 20, odd_term: '15-4906', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '43-7287', phase_index: 0, even_term: '1-2013', even_term_index: 22, odd_term: '46-178', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '12-3285', phase_index: 0, even_term: '31-5685', even_term_index: 0, odd_term: '16-3849', odd_term_index: 23 }
  ],
  1631 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '12-3285', phase_index: 0, even_term: '31-5685', even_term_index: 0, odd_term: '16-3849', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '42-99', phase_index: 0, even_term: '2-956', even_term_index: 2, odd_term: '46-7520', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '11-5664', phase_index: 0, even_term: '32-4627', even_term_index: 4, odd_term: '17-2791', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '41-3051', phase_index: 0, even_term: '2-8298', even_term_index: 6, odd_term: '47-6463', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '11-563', phase_index: 0, even_term: '33-3570', even_term_index: 8, odd_term: '18-1734', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '41-6332', phase_index: 0, even_term: '3-7241', even_term_index: 10, odd_term: '48-5405', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '10-3029', phase_index: 0, even_term: '34-2512', even_term_index: 12, odd_term: '19-676', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '40-7363', phase_index: 0, even_term: '4-6183', even_term_index: 14, odd_term: '49-4348', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '9-2826', phase_index: 0, even_term: '35-1455', even_term_index: 16, odd_term: '19-8019', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '39-6403', phase_index: 0, even_term: '5-5126', even_term_index: 18, odd_term: '50-3290', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '8-1337', phase_index: 0, even_term: '36-397', even_term_index: 20, odd_term: '20-6961', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '37-4534', phase_index: 0, even_term: '6-4068', even_term_index: 22, odd_term: '51-2233', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: true,  remainder: '7-7919', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '21-5904', odd_term_index: 23 }
  ],
  1632 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '36-3626', phase_index: 0, even_term: '36-7740', even_term_index: 0, odd_term: '52-1175', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '6-8257', phase_index: 0, even_term: '7-3011', even_term_index: 2, odd_term: '22-4846', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '35-4718', phase_index: 0, even_term: '37-6682', even_term_index: 4, odd_term: '53-118', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '5-1374', phase_index: 0, even_term: '8-1953', even_term_index: 6, odd_term: '23-3789', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '35-6631', phase_index: 0, even_term: '38-5625', even_term_index: 8, odd_term: '53-7460', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '4-3642', phase_index: 0, even_term: '9-896', even_term_index: 10, odd_term: '24-2731', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '34-555', phase_index: 0, even_term: '39-4567', even_term_index: 12, odd_term: '54-6403', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '3-5378', phase_index: 0, even_term: '9-8238', even_term_index: 14, odd_term: '25-1674', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '33-1520', phase_index: 0, even_term: '40-3510', even_term_index: 16, odd_term: '55-5345', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '2-5797', phase_index: 0, even_term: '10-7181', even_term_index: 18, odd_term: '26-616', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '32-1464', phase_index: 0, even_term: '41-2452', even_term_index: 20, odd_term: '56-4288', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '1-5328', phase_index: 0, even_term: '11-6123', even_term_index: 22, odd_term: '26-7959', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '31-643', phase_index: 0, even_term: '42-1395', even_term_index: 0, odd_term: '57-3230', odd_term_index: 1 }
  ],
  1633 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '31-643', phase_index: 0, even_term: '42-1395', even_term_index: 0, odd_term: '57-3230', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '0-4430', phase_index: 0, even_term: '12-5066', even_term_index: 2, odd_term: '27-6901', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '30-8372', phase_index: 0, even_term: '43-337', even_term_index: 4, odd_term: '58-2173', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '59-4106', phase_index: 0, even_term: '13-4008', even_term_index: 6, odd_term: '28-5844', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '29-41', phase_index: 0, even_term: '43-7680', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '58-4585', phase_index: 0, even_term: '14-2951', even_term_index: 10, odd_term: '59-1115', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '28-995', phase_index: 0, even_term: '44-6622', even_term_index: 12, odd_term: '29-4786', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '57-6067', phase_index: 0, even_term: '15-1893', even_term_index: 14, odd_term: '0-58', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '27-3030', phase_index: 0, even_term: '45-5565', even_term_index: 16, odd_term: '30-3729', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '57-8237', phase_index: 0, even_term: '16-836', even_term_index: 18, odd_term: '0-7400', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '26-4845', phase_index: 0, even_term: '46-4507', even_term_index: 20, odd_term: '31-2671', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '56-1243', phase_index: 0, even_term: '16-8178', even_term_index: 22, odd_term: '1-6343', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '25-5830', phase_index: 0, even_term: '47-3450', even_term_index: 0, odd_term: '32-1614', odd_term_index: 23 }
  ],
  1634 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '25-5830', phase_index: 0, even_term: '47-3450', even_term_index: 0, odd_term: '32-1614', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '55-1760', phase_index: 0, even_term: '17-7121', even_term_index: 2, odd_term: '2-5285', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '24-5492', phase_index: 0, even_term: '48-2392', even_term_index: 4, odd_term: '33-556', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '54-418', phase_index: 0, even_term: '18-6063', even_term_index: 6, odd_term: '3-4228', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '23-3841', phase_index: 0, even_term: '49-1335', even_term_index: 8, odd_term: '33-7899', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '53-7450', phase_index: 0, even_term: '19-5006', even_term_index: 10, odd_term: '4-3170', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '22-2912', phase_index: 0, even_term: '50-277', even_term_index: 12, odd_term: '34-6841', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '52-7061', phase_index: 0, even_term: '20-3948', even_term_index: 14, odd_term: '5-2113', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '21-3379', phase_index: 0, even_term: '50-7620', even_term_index: 16, odd_term: '35-5784', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true,  remainder: '51-403', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '6-1055', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '20-6221', phase_index: 0, even_term: '21-2891', even_term_index: 18, odd_term: '36-4726', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '50-3536', phase_index: 0, even_term: '51-6562', even_term_index: 20, odd_term: '6-8398', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '20-674', phase_index: 0, even_term: '22-1833', even_term_index: 22, odd_term: '37-3669', odd_term_index: 23 }
  ],
  1635 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '49-5969', phase_index: 0, even_term: '52-5505', even_term_index: 0, odd_term: '7-7340', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '19-2390', phase_index: 0, even_term: '23-776', even_term_index: 2, odd_term: '38-2611', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '49-6351', phase_index: 0, even_term: '53-4447', even_term_index: 4, odd_term: '8-6283', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '18-1129', phase_index: 0, even_term: '23-8118', even_term_index: 6, odd_term: '39-1554', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '47-3906', phase_index: 0, even_term: '54-3390', even_term_index: 8, odd_term: '9-5225', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '17-6828', phase_index: 0, even_term: '24-7061', even_term_index: 10, odd_term: '40-496', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '46-1614', phase_index: 0, even_term: '55-2332', even_term_index: 12, odd_term: '10-4168', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '15-5222', phase_index: 0, even_term: '25-6003', even_term_index: 14, odd_term: '40-7839', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '45-1195', phase_index: 0, even_term: '56-1275', even_term_index: 16, odd_term: '11-3110', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '15-6378', phase_index: 0, even_term: '26-4946', even_term_index: 18, odd_term: '41-6781', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '44-3939', phase_index: 0, even_term: '57-217', even_term_index: 20, odd_term: '12-2053', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '14-1903', phase_index: 0, even_term: '27-3888', even_term_index: 22, odd_term: '42-5724', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '44-8132', phase_index: 0, even_term: '57-7560', even_term_index: 0, odd_term: '', odd_term_index: -1 }
  ],
  1636 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '44-8132', phase_index: 0, even_term: '57-7560', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '13-5672', phase_index: 0, even_term: '28-2831', even_term_index: 2, odd_term: '13-995', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '43-2406', phase_index: 0, even_term: '58-6502', even_term_index: 4, odd_term: '43-4666', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '13-6678', phase_index: 0, even_term: '29-1773', even_term_index: 6, odd_term: '13-8338', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '42-1653', phase_index: 0, even_term: '59-5445', even_term_index: 8, odd_term: '44-3609', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '11-4262', phase_index: 0, even_term: '30-716', even_term_index: 10, odd_term: '14-7280', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '41-6569', phase_index: 0, even_term: '0-4387', even_term_index: 12, odd_term: '45-2551', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '10-733', phase_index: 0, even_term: '30-8058', even_term_index: 14, odd_term: '15-6223', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '39-3958', phase_index: 0, even_term: '1-3330', even_term_index: 16, odd_term: '46-1494', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '9-7991', phase_index: 0, even_term: '31-7001', even_term_index: 18, odd_term: '16-5165', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '38-4480', phase_index: 0, even_term: '2-2272', even_term_index: 20, odd_term: '47-436', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '8-1843', phase_index: 0, even_term: '32-5943', even_term_index: 22, odd_term: '17-4108', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '38-8380', phase_index: 0, even_term: '3-1215', even_term_index: 0, odd_term: '47-7779', odd_term_index: 23 }
  ],
  1637 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '38-8380', phase_index: 0, even_term: '3-1215', even_term_index: 0, odd_term: '47-7779', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '8-6844', phase_index: 0, even_term: '33-4886', even_term_index: 2, odd_term: '18-3050', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '37-4751', phase_index: 0, even_term: '4-157', even_term_index: 4, odd_term: '48-6721', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '7-1817', phase_index: 0, even_term: '34-3828', even_term_index: 6, odd_term: '19-1993', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '37-6378', phase_index: 0, even_term: '4-7500', even_term_index: 8, odd_term: '49-5664', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true,  remainder: '6-1661', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '20-935', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '35-4495', phase_index: 0, even_term: '35-2771', even_term_index: 10, odd_term: '50-4606', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '5-6648', phase_index: 0, even_term: '5-6442', even_term_index: 12, odd_term: '20-8278', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '34-400', phase_index: 0, even_term: '36-1713', even_term_index: 14, odd_term: '51-3549', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '3-3288', phase_index: 0, even_term: '6-5385', even_term_index: 16, odd_term: '21-7220', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '33-6996', phase_index: 0, even_term: '37-656', even_term_index: 18, odd_term: '52-2491', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '2-3188', phase_index: 0, even_term: '7-4327', even_term_index: 20, odd_term: '22-6163', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '32-270', phase_index: 0, even_term: '37-7998', even_term_index: 22, odd_term: '53-1434', odd_term_index: 23 }
  ],
  1638 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '2-6594', phase_index: 0, even_term: '8-3270', even_term_index: 0, odd_term: '23-5105', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '31-5074', phase_index: 0, even_term: '38-6941', even_term_index: 2, odd_term: '54-376', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '1-3228', phase_index: 0, even_term: '9-2212', even_term_index: 4, odd_term: '24-4048', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '31-577', phase_index: 0, even_term: '39-5883', even_term_index: 6, odd_term: '54-7719', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '0-5457', phase_index: 0, even_term: '10-1155', even_term_index: 8, odd_term: '25-2990', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '30-1054', phase_index: 0, even_term: '40-4826', even_term_index: 10, odd_term: '55-6661', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '59-4248', phase_index: 0, even_term: '11-97', even_term_index: 12, odd_term: '26-1933', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '29-6733', phase_index: 0, even_term: '41-3768', even_term_index: 14, odd_term: '56-5604', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '58-608', phase_index: 0, even_term: '11-7440', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '27-3216', phase_index: 0, even_term: '42-2711', even_term_index: 18, odd_term: '27-875', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '57-6637', phase_index: 0, even_term: '12-6382', even_term_index: 20, odd_term: '57-4546', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '26-2533', phase_index: 0, even_term: '43-1653', even_term_index: 22, odd_term: '27-8218', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '56-7700', phase_index: 0, even_term: '13-5325', even_term_index: 0, odd_term: '58-3489', odd_term_index: 23 }
  ],
  1639 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '56-7700', phase_index: 0, even_term: '13-5325', even_term_index: 0, odd_term: '58-3489', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '25-5272', phase_index: 0, even_term: '44-596', even_term_index: 2, odd_term: '28-7160', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '55-3157', phase_index: 0, even_term: '14-4267', even_term_index: 4, odd_term: '59-2431', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '25-1149', phase_index: 0, even_term: '44-7938', even_term_index: 6, odd_term: '29-6103', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '55-7127', phase_index: 0, even_term: '15-3210', even_term_index: 8, odd_term: '0-1374', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '24-3894', phase_index: 0, even_term: '45-6881', even_term_index: 10, odd_term: '30-5045', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '54-8253', phase_index: 0, even_term: '16-2152', even_term_index: 12, odd_term: '1-316', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '23-3413', phase_index: 0, even_term: '46-5823', even_term_index: 14, odd_term: '31-3988', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '53-6531', phase_index: 0, even_term: '17-1095', even_term_index: 16, odd_term: '1-7659', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '22-966', phase_index: 0, even_term: '47-4766', even_term_index: 18, odd_term: '32-2930', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '51-3707', phase_index: 0, even_term: '18-37', even_term_index: 20, odd_term: '2-6601', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '21-6884', phase_index: 0, even_term: '48-3708', even_term_index: 22, odd_term: '33-1873', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '50-2493', phase_index: 0, even_term: '18-7380', even_term_index: 0, odd_term: '3-5544', odd_term_index: 23 }
  ],
  1640 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '50-2493', phase_index: 0, even_term: '18-7380', even_term_index: 0, odd_term: '3-5544', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: true,  remainder: '20-7341', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '34-815', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '49-4311', phase_index: 0, even_term: '49-2651', even_term_index: 2, odd_term: '4-4486', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '19-1506', phase_index: 0, even_term: '19-6322', even_term_index: 4, odd_term: '34-8158', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '49-7278', phase_index: 0, even_term: '50-1593', even_term_index: 6, odd_term: '5-3429', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '18-4722', phase_index: 0, even_term: '20-5265', even_term_index: 8, odd_term: '35-7100', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '48-1756', phase_index: 0, even_term: '51-536', even_term_index: 10, odd_term: '6-2371', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '18-6452', phase_index: 0, even_term: '21-4207', even_term_index: 12, odd_term: '36-6043', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '47-2158', phase_index: 0, even_term: '51-7878', even_term_index: 14, odd_term: '7-1314', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '16-5945', phase_index: 0, even_term: '22-3150', even_term_index: 16, odd_term: '37-4985', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '46-1082', phase_index: 0, even_term: '52-6821', even_term_index: 18, odd_term: '8-256', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '15-4413', phase_index: 0, even_term: '23-2092', even_term_index: 20, odd_term: '38-3928', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '45-7707', phase_index: 0, even_term: '53-5763', even_term_index: 22, odd_term: '8-7599', odd_term_index: 23 }
  ],
  1641 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '14-3046', phase_index: 0, even_term: '24-1035', even_term_index: 0, odd_term: '39-2870', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '44-7454', phase_index: 0, even_term: '54-4706', even_term_index: 2, odd_term: '9-6541', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '13-3705', phase_index: 0, even_term: '24-8377', even_term_index: 4, odd_term: '40-1813', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '43-178', phase_index: 0, even_term: '55-3648', even_term_index: 6, odd_term: '10-5484', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '12-5245', phase_index: 0, even_term: '25-7320', even_term_index: 8, odd_term: '41-755', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '42-2103', phase_index: 0, even_term: '56-2591', even_term_index: 10, odd_term: '11-4426', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '12-7487', phase_index: 0, even_term: '26-6262', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '41-4145', phase_index: 0, even_term: '57-1533', even_term_index: 14, odd_term: '41-8098', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '11-502', phase_index: 0, even_term: '27-5205', even_term_index: 16, odd_term: '12-3369', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '40-4997', phase_index: 0, even_term: '58-476', even_term_index: 18, odd_term: '42-7040', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '10-850', phase_index: 0, even_term: '28-4147', even_term_index: 20, odd_term: '13-2311', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '39-4910', phase_index: 0, even_term: '58-7818', even_term_index: 22, odd_term: '43-5983', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '9-365', phase_index: 0, even_term: '29-3090', even_term_index: 0, odd_term: '14-1254', odd_term_index: 23 }
  ],
  1642 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '9-365', phase_index: 0, even_term: '29-3090', even_term_index: 0, odd_term: '14-1254', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '38-4136', phase_index: 0, even_term: '59-6761', even_term_index: 2, odd_term: '44-4925', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '8-7905', phase_index: 0, even_term: '30-2032', even_term_index: 4, odd_term: '15-196', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '37-3459', phase_index: 0, even_term: '0-5703', even_term_index: 6, odd_term: '45-3868', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '7-7589', phase_index: 0, even_term: '31-975', even_term_index: 8, odd_term: '15-7539', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '36-3539', phase_index: 0, even_term: '1-4646', even_term_index: 10, odd_term: '46-2810', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '6-8140', phase_index: 0, even_term: '31-8317', even_term_index: 12, odd_term: '16-6481', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '35-4602', phase_index: 0, even_term: '2-3588', even_term_index: 14, odd_term: '47-1753', odd_term_index: 13 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '5-1500', phase_index: 0, even_term: '32-7260', even_term_index: 16, odd_term: '17-5424', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '35-6880', phase_index: 0, even_term: '3-2531', even_term_index: 18, odd_term: '48-695', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '4-3677', phase_index: 0, even_term: '33-6202', even_term_index: 20, odd_term: '18-4366', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: true,  remainder: '34-279', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '48-8038', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '3-5062', phase_index: 0, even_term: '4-1473', even_term_index: 22, odd_term: '19-3309', odd_term_index: 23 }
  ],
  1643 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '33-1217', phase_index: 0, even_term: '34-5145', even_term_index: 0, odd_term: '49-6980', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '2-5281', phase_index: 0, even_term: '5-416', even_term_index: 2, odd_term: '20-2251', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '32-279', phase_index: 0, even_term: '35-4087', even_term_index: 4, odd_term: '50-5923', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '1-3538', phase_index: 0, even_term: '5-7758', even_term_index: 6, odd_term: '21-1194', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '31-6960', phase_index: 0, even_term: '36-3030', even_term_index: 8, odd_term: '51-4865', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '0-2196', phase_index: 0, even_term: '6-6701', even_term_index: 10, odd_term: '22-136', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '29-6128', phase_index: 0, even_term: '37-1972', even_term_index: 12, odd_term: '52-3808', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '59-2092', phase_index: 0, even_term: '7-5643', even_term_index: 14, odd_term: '22-7479', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '29-7197', phase_index: 0, even_term: '38-915', even_term_index: 16, odd_term: '53-2750', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '58-4548', phase_index: 0, even_term: '8-4586', even_term_index: 18, odd_term: '23-6421', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '28-2020', phase_index: 0, even_term: '38-8257', even_term_index: 20, odd_term: '54-1693', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '58-7745', phase_index: 0, even_term: '9-3528', even_term_index: 22, odd_term: '24-5364', odd_term_index: 23 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '27-4859', phase_index: 0, even_term: '39-7200', even_term_index: 0, odd_term: '55-635', odd_term_index: 1 }
  ],
  1644 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '27-4859', phase_index: 0, even_term: '39-7200', even_term_index: 0, odd_term: '55-635', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '57-1621', phase_index: 0, even_term: '10-2471', even_term_index: 2, odd_term: '25-4306', odd_term_index: 3 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '26-5984', phase_index: 0, even_term: '40-6142', even_term_index: 4, odd_term: '55-7978', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '56-1098', phase_index: 0, even_term: '11-1413', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '25-3930', phase_index: 0, even_term: '41-5085', even_term_index: 8, odd_term: '26-3249', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '55-6670', phase_index: 0, even_term: '12-356', even_term_index: 10, odd_term: '56-6920', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '24-1244', phase_index: 0, even_term: '42-4027', even_term_index: 12, odd_term: '27-2191', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '53-4532', phase_index: 0, even_term: '12-7698', even_term_index: 14, odd_term: '57-5863', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '23-132', phase_index: 0, even_term: '43-2970', even_term_index: 16, odd_term: '28-1134', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '52-4932', phase_index: 0, even_term: '13-6641', even_term_index: 18, odd_term: '58-4805', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '22-2153', phase_index: 0, even_term: '44-1912', even_term_index: 20, odd_term: '29-76', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '52-63', phase_index: 0, even_term: '14-5583', even_term_index: 22, odd_term: '59-3748', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '22-6464', phase_index: 0, even_term: '45-855', even_term_index: 0, odd_term: '29-7419', odd_term_index: 23 }
  ],
  1645 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '22-6464', phase_index: 0, even_term: '45-855', even_term_index: 0, odd_term: '29-7419', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '51-4267', phase_index: 0, even_term: '15-4526', even_term_index: 2, odd_term: '0-2690', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '21-1420', phase_index: 0, even_term: '45-8197', even_term_index: 4, odd_term: '30-6361', odd_term_index: 3 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '50-6092', phase_index: 0, even_term: '16-3468', even_term_index: 6, odd_term: '1-1633', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '20-1479', phase_index: 0, even_term: '46-7140', even_term_index: 8, odd_term: '31-5304', odd_term_index: 7 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '49-4408', phase_index: 0, even_term: '17-2411', even_term_index: 10, odd_term: '2-575', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '19-6726', phase_index: 0, even_term: '47-6082', even_term_index: 12, odd_term: '32-4246', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true,  remainder: '48-660', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '2-7918', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '17-3516', phase_index: 0, even_term: '18-1353', even_term_index: 14, odd_term: '33-3189', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '47-7149', phase_index: 0, even_term: '48-5025', even_term_index: 16, odd_term: '3-6860', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '16-3242', phase_index: 0, even_term: '19-296', even_term_index: 18, odd_term: '34-2131', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '46-204', phase_index: 0, even_term: '49-3967', even_term_index: 20, odd_term: '4-5803', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '16-6413', phase_index: 0, even_term: '19-7638', even_term_index: 22, odd_term: '35-1074', odd_term_index: 23 }
  ],
  1646 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '45-4864', phase_index: 0, even_term: '50-2910', even_term_index: 0, odd_term: '5-4745', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '15-3135', phase_index: 0, even_term: '20-6581', even_term_index: 2, odd_term: '36-16', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '45-593', phase_index: 0, even_term: '51-1852', even_term_index: 4, odd_term: '6-3688', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '14-5583', phase_index: 0, even_term: '21-5523', even_term_index: 6, odd_term: '36-7359', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '44-1264', phase_index: 0, even_term: '52-795', even_term_index: 8, odd_term: '7-2630', odd_term_index: 9 },
    { is_many_days: true,  month: 4, leaped: false, remainder: '13-4487', phase_index: 0, even_term: '22-4466', even_term_index: 10, odd_term: '37-6301', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '43-6933', phase_index: 0, even_term: '52-8137', even_term_index: 12, odd_term: '8-1573', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '12-539', phase_index: 0, even_term: '23-3408', even_term_index: 14, odd_term: '38-5244', odd_term_index: 15 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '41-3066', phase_index: 0, even_term: '53-7080', even_term_index: 16, odd_term: '9-515', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '11-6386', phase_index: 0, even_term: '24-2351', even_term_index: 18, odd_term: '39-4186', odd_term_index: 19 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '40-2159', phase_index: 0, even_term: '54-6022', even_term_index: 20, odd_term: '9-7858', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '10-7240', phase_index: 0, even_term: '25-1293', even_term_index: 22, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '39-4777', phase_index: 0, even_term: '55-4965', even_term_index: 0, odd_term: '40-3129', odd_term_index: 23 }
  ],
  1647 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '39-4777', phase_index: 0, even_term: '55-4965', even_term_index: 0, odd_term: '40-3129', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '9-3059', phase_index: 0, even_term: '26-236', even_term_index: 2, odd_term: '10-6800', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '39-1421', phase_index: 0, even_term: '56-3907', even_term_index: 4, odd_term: '41-2071', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '9-7557', phase_index: 0, even_term: '26-7578', even_term_index: 6, odd_term: '11-5743', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '38-4431', phase_index: 0, even_term: '57-2850', even_term_index: 8, odd_term: '42-1014', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '8-435', phase_index: 0, even_term: '27-6521', even_term_index: 10, odd_term: '12-4685', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '37-4006', phase_index: 0, even_term: '58-1792', even_term_index: 12, odd_term: '42-8356', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '7-6798', phase_index: 0, even_term: '28-5463', even_term_index: 14, odd_term: '13-3628', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '36-804', phase_index: 0, even_term: '59-735', even_term_index: 16, odd_term: '43-7299', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '5-3192', phase_index: 0, even_term: '29-4406', even_term_index: 18, odd_term: '14-2570', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '34-6224', phase_index: 0, even_term: '59-8077', even_term_index: 20, odd_term: '44-6241', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '4-1718', phase_index: 0, even_term: '30-3348', even_term_index: 22, odd_term: '15-1513', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '34-6486', phase_index: 0, even_term: '0-7020', even_term_index: 0, odd_term: '45-5184', odd_term_index: 23 }
  ],
  1648 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '34-6486', phase_index: 0, even_term: '0-7020', even_term_index: 0, odd_term: '45-5184', odd_term_index: 23 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '3-3704', phase_index: 0, even_term: '31-2291', even_term_index: 2, odd_term: '16-455', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '33-1411', phase_index: 0, even_term: '1-5962', even_term_index: 4, odd_term: '46-4126', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: true,  remainder: '3-7692', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '16-7798', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '32-5512', phase_index: 0, even_term: '32-1233', even_term_index: 6, odd_term: '47-3069', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '2-2661', phase_index: 0, even_term: '2-4905', even_term_index: 8, odd_term: '17-6740', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '32-7394', phase_index: 0, even_term: '33-176', even_term_index: 10, odd_term: '48-2011', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '1-2926', phase_index: 0, even_term: '3-3847', even_term_index: 12, odd_term: '18-5683', odd_term_index: 13 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '30-6277', phase_index: 0, even_term: '33-7518', even_term_index: 14, odd_term: '49-954', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '0-920', phase_index: 0, even_term: '4-2790', even_term_index: 16, odd_term: '19-4625', odd_term_index: 17 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '29-3754', phase_index: 0, even_term: '34-6461', even_term_index: 18, odd_term: '49-8296', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '59-6672', phase_index: 0, even_term: '5-1732', even_term_index: 20, odd_term: '20-3568', odd_term_index: 21 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '28-1894', phase_index: 0, even_term: '35-5403', even_term_index: 22, odd_term: '50-7239', odd_term_index: 23 }
  ],
  1649 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '58-6351', phase_index: 0, even_term: '6-675', even_term_index: 0, odd_term: '21-2510', odd_term_index: 1 },
    { is_many_days: true,  month: 12, leaped: false, remainder: '27-3096', phase_index: 0, even_term: '36-4346', even_term_index: 2, odd_term: '51-6181', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '57-85', phase_index: 0, even_term: '6-8017', even_term_index: 4, odd_term: '22-1453', odd_term_index: 5 },
    { is_many_days: true,  month: 2, leaped: false, remainder: '26-5687', phase_index: 0, even_term: '37-3288', even_term_index: 6, odd_term: '52-5124', odd_term_index: 7 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '56-3030', phase_index: 0, even_term: '7-6960', even_term_index: 8, odd_term: '23-395', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '26-307', phase_index: 0, even_term: '38-2231', even_term_index: 10, odd_term: '53-4066', odd_term_index: 11 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '55-5365', phase_index: 0, even_term: '8-5902', even_term_index: 12, odd_term: '23-7738', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '25-1332', phase_index: 0, even_term: '39-1173', even_term_index: 14, odd_term: '', odd_term_index: -1 },
    { is_many_days: true,  month: 7, leaped: false, remainder: '54-5349', phase_index: 0, even_term: '9-4845', even_term_index: 16, odd_term: '54-3009', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '24-694', phase_index: 0, even_term: '40-116', even_term_index: 18, odd_term: '24-6680', odd_term_index: 17 },
    { is_many_days: true,  month: 9, leaped: false, remainder: '53-4209', phase_index: 0, even_term: '10-3787', even_term_index: 20, odd_term: '55-1951', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '23-7578', phase_index: 0, even_term: '40-7458', even_term_index: 22, odd_term: '25-5623', odd_term_index: 21 },
    { is_many_days: true,  month: 11, leaped: false, remainder: '52-2655', phase_index: 0, even_term: '11-2730', even_term_index: 0, odd_term: '56-894', odd_term_index: 23 }
  ],
  1650 => [
    { is_many_days: true,  month: 11, leaped: false, remainder: '52-2655', phase_index: 0, even_term: '11-2730', even_term_index: 0, odd_term: '56-894', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '22-6780', phase_index: 0, even_term: '41-6401', even_term_index: 2, odd_term: '26-4565', odd_term_index: 1 },
    { is_many_days: true,  month: 1, leaped: false, remainder: '51-2838', phase_index: 0, even_term: '12-1672', even_term_index: 4, odd_term: '56-8236', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '21-7517', phase_index: 0, even_term: '42-5343', even_term_index: 6, odd_term: '27-3508', odd_term_index: 5 },
    { is_many_days: true,  month: 3, leaped: false, remainder: '50-3986', phase_index: 0, even_term: '13-615', even_term_index: 8, odd_term: '57-7179', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '20-664', phase_index: 0, even_term: '43-4286', even_term_index: 10, odd_term: '28-2450', odd_term_index: 9 },
    { is_many_days: true,  month: 5, leaped: false, remainder: '49-5937', phase_index: 0, even_term: '13-7957', even_term_index: 12, odd_term: '58-6121', odd_term_index: 11 },
    { is_many_days: true,  month: 6, leaped: false, remainder: '19-2787', phase_index: 0, even_term: '44-3228', even_term_index: 14, odd_term: '29-1393', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '49-7747', phase_index: 0, even_term: '14-6900', even_term_index: 16, odd_term: '59-5064', odd_term_index: 15 },
    { is_many_days: true,  month: 8, leaped: false, remainder: '18-4045', phase_index: 0, even_term: '45-2171', even_term_index: 18, odd_term: '30-335', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '48-102', phase_index: 0, even_term: '15-5842', even_term_index: 20, odd_term: '0-4006', odd_term_index: 19 },
    { is_many_days: true,  month: 10, leaped: false, remainder: '17-4359', phase_index: 0, even_term: '46-1113', even_term_index: 22, odd_term: '30-7678', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: true,  remainder: '47-3', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '1-2949', odd_term_index: 23 }
  ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
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
              SENMYOU_EXPECTED_MONTHS.each do |year, expects|
                actuals = \
                  Zakuro::Senmyou::Range::AnnualRange.get(
                    context: Zakuro::Context.new(version_name: 'Senmyou'),
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
            #   Zakuro::Senmyou::Range::AnnualRange.get(
            #     context: Zakuro::Context.new(version_name: 'Senmyou'),
            #     western_year: 1333
            #   )
            # end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
