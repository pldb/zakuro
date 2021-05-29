# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength
GIHOU_EXPECTED_MONTHS = {
  # 700 => [
  #   { is_many_days: true, month: 11, leaped: false, remainder: '47-1041', phase_index: 0, even_term: '8-1328', even_term_index: 0, odd_term: '53-1035', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '17-756', phase_index: 0, even_term: '39-573', even_term_index: 2, odd_term: '24-280', odd_term_index: 1 },
  #   { is_many_days: true, month: 1, leaped: false, remainder: '47-465', phase_index: 0, even_term: '9-1159', even_term_index: 4, odd_term: '54-866', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '17-102', phase_index: 0, even_term: '40-405', even_term_index: 6, odd_term: '25-112', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '46-960', phase_index: 0, even_term: '10-990', even_term_index: 8, odd_term: '55-697', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '16-255', phase_index: 0, even_term: '41-236', even_term_index: 10, odd_term: '25-1283', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '45-810', phase_index: 0, even_term: '11-822', even_term_index: 12, odd_term: '56-529', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '14-1253', phase_index: 0, even_term: '42-67', even_term_index: 14, odd_term: '26-1114', odd_term_index: 13 },
  #   { is_many_days: false,  month: 7, leaped: false, remainder: '44-295', phase_index: 0, even_term: '12-653', even_term_index: 16, odd_term: '57-360', odd_term_index: 15 },
  #   { is_many_days: false,  month: 7, leaped: true, remainder: '13-684', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '27-946', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '42-1118', phase_index: 0, even_term: '42-1239', even_term_index: 18, odd_term: '58-191', odd_term_index: 19 },
  #   # TODO: 9月10月が通らない
  #   { is_many_days: false, month: 9, leaped: false, remainder: '12-475', phase_index: 0, even_term: '13-484', even_term_index: 20, odd_term: '28-777', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '41-1255', phase_index: 0, even_term: '43-1070', even_term_index: 22, odd_term: '59-23', odd_term_index: 23 }
  # ],
  # TODO: correction
  699 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '53-1058', phase_index: 0, even_term: '3-1000', even_term_index: 0, odd_term: '18-1292', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '23-728', phase_index: 0, even_term: '34-245', even_term_index: 2, odd_term: '49-538', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '53-286', phase_index: 0, even_term: '4-831', even_term_index: 4, odd_term: '19-1124', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '22-1101', phase_index: 0, even_term: '35-77', even_term_index: 6, odd_term: '50-369', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '52-367', phase_index: 0, even_term: '5-662', even_term_index: 8, odd_term: '20-955', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '21-834', phase_index: 0, even_term: '35-1248', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '50-1230', phase_index: 0, even_term: '6-494', even_term_index: 12, odd_term: '51-201', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '20-247', phase_index: 0, even_term: '36-1079', even_term_index: 14, odd_term: '21-786', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '49-690', phase_index: 0, even_term: '7-325', even_term_index: 16, odd_term: '52-32', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '18-1222', phase_index: 0, even_term: '37-911', even_term_index: 18, odd_term: '22-618', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '48-543', phase_index: 0, even_term: '8-156', even_term_index: 20, odd_term: '52-1203', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '18-83', phase_index: 0, even_term: '38-742', even_term_index: 22, odd_term: '23-449', odd_term_index: 21 }
  ],
  700 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '47-1041', phase_index: 0, even_term: '8-1328', even_term_index: 0, odd_term: '53-1035', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '17-756', phase_index: 0, even_term: '39-573', even_term_index: 2, odd_term: '24-280', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '47-465', phase_index: 0, even_term: '9-1159', even_term_index: 4, odd_term: '54-866', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '17-102', phase_index: 0, even_term: '40-405', even_term_index: 6, odd_term: '25-112', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '46-960', phase_index: 0, even_term: '10-990', even_term_index: 8, odd_term: '55-697', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '16-255', phase_index: 0, even_term: '41-236', even_term_index: 10, odd_term: '25-1283', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '45-810', phase_index: 0, even_term: '11-822', even_term_index: 12, odd_term: '56-529', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '14-1253', phase_index: 0, even_term: '42-67', even_term_index: 14, odd_term: '26-1114', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '44-295', phase_index: 0, even_term: '12-653', even_term_index: 16, odd_term: '57-360', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '13-684', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '27-946', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '42-1118', phase_index: 0, even_term: '42-1239', even_term_index: 18, odd_term: '58-191', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '12-475', phase_index: 0, even_term: '13-484', even_term_index: 20, odd_term: '28-777', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '41-1255', phase_index: 0, even_term: '43-1070', even_term_index: 22, odd_term: '59-23', odd_term_index: 23 }
  ],
  701 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '11-808', phase_index: 0, even_term: '14-316', even_term_index: 0, odd_term: '29-608', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '41-455', phase_index: 0, even_term: '44-901', even_term_index: 2, odd_term: '59-1194', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '11-142', phase_index: 0, even_term: '15-147', even_term_index: 4, odd_term: '30-440', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '40-1196', phase_index: 0, even_term: '45-733', even_term_index: 6, odd_term: '0-1025', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '10-670', phase_index: 0, even_term: '15-1318', even_term_index: 8, odd_term: '31-271', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '40-67', phase_index: 0, even_term: '46-564', even_term_index: 10, odd_term: '1-857', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '9-695', phase_index: 0, even_term: '16-1150', even_term_index: 12, odd_term: '32-102', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '38-1218', phase_index: 0, even_term: '47-395', even_term_index: 14, odd_term: '2-688', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '8-339', phase_index: 0, even_term: '17-981', even_term_index: 16, odd_term: '32-1274', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '37-727', phase_index: 0, even_term: '48-227', even_term_index: 18, odd_term: '3-519', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '6-1203', phase_index: 0, even_term: '18-812', even_term_index: 20, odd_term: '33-1105', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '36-477', phase_index: 0, even_term: '49-58', even_term_index: 22, odd_term: '4-351', odd_term_index: 23 }
  ],
  702 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '5-1179', phase_index: 0, even_term: '19-644', even_term_index: 0, odd_term: '34-936', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '35-656', phase_index: 0, even_term: '49-1229', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '5-199', phase_index: 0, even_term: '20-475', even_term_index: 4, odd_term: '5-182', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '34-1174', phase_index: 0, even_term: '50-1061', even_term_index: 6, odd_term: '35-768', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '4-781', phase_index: 0, even_term: '21-306', even_term_index: 8, odd_term: '6-13', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '34-316', phase_index: 0, even_term: '51-892', even_term_index: 10, odd_term: '36-599', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '3-1129', phase_index: 0, even_term: '22-138', even_term_index: 12, odd_term: '6-1185', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '33-491', phase_index: 0, even_term: '52-723', even_term_index: 14, odd_term: '37-430', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '2-1117', phase_index: 0, even_term: '22-1309', even_term_index: 16, odd_term: '7-1016', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '32-321', phase_index: 0, even_term: '53-555', even_term_index: 18, odd_term: '38-262', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '1-793', phase_index: 0, even_term: '23-1140', even_term_index: 20, odd_term: '8-847', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '31-15', phase_index: 0, even_term: '54-386', even_term_index: 22, odd_term: '39-93', odd_term_index: 21 }
  ],
  703 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '0-556', phase_index: 0, even_term: '24-972', even_term_index: 0, odd_term: '9-679', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '29-1196', phase_index: 0, even_term: '55-217', even_term_index: 2, odd_term: '39-1264', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '59-572', phase_index: 0, even_term: '25-803', even_term_index: 4, odd_term: '10-510', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '29-23', phase_index: 0, even_term: '56-49', even_term_index: 6, odd_term: '40-1096', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '58-894', phase_index: 0, even_term: '26-634', even_term_index: 8, odd_term: '11-341', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '28-360', phase_index: 0, even_term: '56-1220', even_term_index: 10, odd_term: '41-927', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: true, remainder: '57-1245', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '12-173', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '27-763', phase_index: 0, even_term: '27-466', even_term_index: 12, odd_term: '42-758', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '57-213', phase_index: 0, even_term: '57-1051', even_term_index: 14, odd_term: '13-4', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '26-940', phase_index: 0, even_term: '28-297', even_term_index: 16, odd_term: '43-590', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '56-216', phase_index: 0, even_term: '58-883', even_term_index: 18, odd_term: '13-1175', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '25-892', phase_index: 0, even_term: '29-126', even_term_index: 20, odd_term: '44-421', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '55-156', phase_index: 0, even_term: '59-714', even_term_index: 22, odd_term: '14-1007', odd_term_index: 23 }
  ],
  704 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '24-715', phase_index: 0, even_term: '29-1300', even_term_index: 0, odd_term: '45-252', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '53-1287', phase_index: 0, even_term: '0-545', even_term_index: 2, odd_term: '15-838', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '23-565', phase_index: 0, even_term: '30-1131', even_term_index: 4, odd_term: '46-84', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '52-1285', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '16-669', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '22-605', phase_index: 0, even_term: '31-962', even_term_index: 8, odd_term: '46-1255', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '52-3', phase_index: 0, even_term: '2-208', even_term_index: 10, odd_term: '17-501', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '21-815', phase_index: 0, even_term: '32-794', even_term_index: 12, odd_term: '47-1086', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '51-335', phase_index: 0, even_term: '3-39', even_term_index: 14, odd_term: '18-332', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '20-1210', phase_index: 0, even_term: '33-625', even_term_index: 16, odd_term: '48-918', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '50-671', phase_index: 0, even_term: '3-1211', even_term_index: 18, odd_term: '19-163', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '20-117', phase_index: 0, even_term: '34-456', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '49-803', phase_index: 0, even_term: '4-1042', even_term_index: 22, odd_term: '49-749', odd_term_index: 21 }
  ],
  705 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '19-251', phase_index: 0, even_term: '35-288', even_term_index: 0, odd_term: '19-1335', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '48-881', phase_index: 0, even_term: '5-873', even_term_index: 2, odd_term: '50-590', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '18-90', phase_index: 0, even_term: '36-119', even_term_index: 4, odd_term: '20-1166', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '47-643', phase_index: 0, even_term: '6-705', even_term_index: 6, odd_term: '51-412', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '16-1200', phase_index: 0, even_term: '36-1290', even_term_index: 8, odd_term: '21-997', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '46-410', phase_index: 0, even_term: '7-536', even_term_index: 10, odd_term: '52-243', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '15-1060', phase_index: 0, even_term: '37-1122', even_term_index: 12, odd_term: '22-829', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '45-437', phase_index: 0, even_term: '8-367', even_term_index: 14, odd_term: '53-74', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '14-1251', phase_index: 0, even_term: '38-953', even_term_index: 16, odd_term: '23-660', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '44-800', phase_index: 0, even_term: '9-199', even_term_index: 18, odd_term: '53-1246', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '14-323', phase_index: 0, even_term: '39-784', even_term_index: 20, odd_term: '24-491', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '43-1302', phase_index: 0, even_term: '10-30', even_term_index: 22, odd_term: '54-1077', odd_term_index: 21 }
  ],
  706 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '13-827', phase_index: 0, even_term: '40-616', even_term_index: 0, odd_term: '25-323', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '43-283', phase_index: 0, even_term: '10-1201', even_term_index: 2, odd_term: '55-908', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '12-982', phase_index: 0, even_term: '41-447', even_term_index: 4, odd_term: '26-154', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: true, remainder: '42-236', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '56-740', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '11-781', phase_index: 0, even_term: '11-1033', even_term_index: 6, odd_term: '26-1325', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '40-1164', phase_index: 0, even_term: '42-278', even_term_index: 8, odd_term: '57-571', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '10-302', phase_index: 0, even_term: '12-864', even_term_index: 10, odd_term: '27-1157', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '39-847', phase_index: 0, even_term: '43-110', even_term_index: 12, odd_term: '58-402', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '9-140', phase_index: 0, even_term: '13-695', even_term_index: 14, odd_term: '28-988', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '38-889', phase_index: 0, even_term: '43-1281', even_term_index: 16, odd_term: '59-234', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '8-367', phase_index: 0, even_term: '14-527', even_term_index: 18, odd_term: '29-819', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '38-33', phase_index: 0, even_term: '44-1112', even_term_index: 20, odd_term: '0-65', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '7-1057', phase_index: 0, even_term: '15-358', even_term_index: 22, odd_term: '30-651', odd_term_index: 23 }
  ],
  707 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '37-680', phase_index: 0, even_term: '45-944', even_term_index: 0, odd_term: '0-1236', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '7-229', phase_index: 0, even_term: '16-139', even_term_index: 2, odd_term: '31-482', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '36-998', phase_index: 0, even_term: '46-775', even_term_index: 4, odd_term: '1-1068', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '6-345', phase_index: 0, even_term: '17-21', even_term_index: 6, odd_term: '32-313', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '35-820', phase_index: 0, even_term: '47-606', even_term_index: 8, odd_term: '2-899', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '4-1203', phase_index: 0, even_term: '17-1192', even_term_index: 10, odd_term: '33-145', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '34-260', phase_index: 0, even_term: '48-438', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 6, leaped: false, remainder: '3-713', phase_index: 0, even_term: '18-1023', even_term_index: 14, odd_term: '3-730', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '32-1276', phase_index: 0, even_term: '49-269', even_term_index: 16, odd_term: '33-1316', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '2-593', phase_index: 0, even_term: '19-855', even_term_index: 18, odd_term: '4-562', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '32-52', phase_index: 0, even_term: '50-100', even_term_index: 20, odd_term: '34-1147', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '1-1051', phase_index: 0, even_term: '20-686', even_term_index: 22, odd_term: '5-393', odd_term_index: 21 }
  ],
  708 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '31-753', phase_index: 0, even_term: '50-1272', even_term_index: 0, odd_term: '35-979', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '1-461', phase_index: 0, even_term: '21-517', even_term_index: 2, odd_term: '6-224', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '31-77', phase_index: 0, even_term: '51-1103', even_term_index: 4, odd_term: '36-810', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '0-935', phase_index: 0, even_term: '22-349', even_term_index: 6, odd_term: '7-56', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '30-313', phase_index: 0, even_term: '52-934', even_term_index: 8, odd_term: '37-641', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '59-819', phase_index: 0, even_term: '23-180', even_term_index: 10, odd_term: '7-1227', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '28-1257', phase_index: 0, even_term: '53-766', even_term_index: 12, odd_term: '38-473', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '58-276', phase_index: 0, even_term: '24-11', even_term_index: 14, odd_term: '8-1058', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '27-668', phase_index: 0, even_term: '54-597', even_term_index: 16, odd_term: '39-304', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '56-1157', phase_index: 0, even_term: '24-1183', even_term_index: 18, odd_term: '9-890', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: true, remainder: '26-370', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '40-135', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '55-1205', phase_index: 0, even_term: '55-428', even_term_index: 20, odd_term: '10-721', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '25-772', phase_index: 0, even_term: '25-1014', even_term_index: 22, odd_term: '40-1307', odd_term_index: 23 }
  ],
  709 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '55-445', phase_index: 0, even_term: '56-260', even_term_index: 0, odd_term: '11-552', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '25-169', phase_index: 0, even_term: '26-845', even_term_index: 2, odd_term: '41-1138', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '54-1182', phase_index: 0, even_term: '57-91', even_term_index: 4, odd_term: '12-384', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '24-802', phase_index: 0, even_term: '27-677', even_term_index: 6, odd_term: '42-969', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '54-146', phase_index: 0, even_term: '57-1262', even_term_index: 8, odd_term: '13-215', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '23-754', phase_index: 0, even_term: '28-508', even_term_index: 10, odd_term: '43-801', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '52-1250', phase_index: 0, even_term: '58-1094', even_term_index: 12, odd_term: '14-46', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '22-320', phase_index: 0, even_term: '29-339', even_term_index: 14, odd_term: '44-632', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '51-701', phase_index: 0, even_term: '59-925', even_term_index: 16, odd_term: '14-1218', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '20-1103', phase_index: 0, even_term: '30-171', even_term_index: 18, odd_term: '45-463', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '50-353', phase_index: 0, even_term: '0-756', even_term_index: 20, odd_term: '15-1049', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '19-1085', phase_index: 0, even_term: '31-2', even_term_index: 22, odd_term: '46-295', odd_term_index: 23 }
  ],
  710 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '49-577', phase_index: 0, even_term: '1-588', even_term_index: 0, odd_term: '16-830', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '19-182', phase_index: 0, even_term: '31-1173', even_term_index: 2, odd_term: '47-126', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '48-1180', phase_index: 0, even_term: '2-419', even_term_index: 4, odd_term: '17-712', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '18-891', phase_index: 0, even_term: '32-1005', even_term_index: 6, odd_term: '47-1297', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '48-467', phase_index: 0, even_term: '3-250', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 4, leaped: false, remainder: '17-1247', phase_index: 0, even_term: '33-836', even_term_index: 10, odd_term: '18-543', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '47-597', phase_index: 0, even_term: '4-82', even_term_index: 12, odd_term: '48-1129', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '16-1169', phase_index: 0, even_term: '34-667', even_term_index: 14, odd_term: '19-374', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '46-328', phase_index: 0, even_term: '4-1253', even_term_index: 16, odd_term: '49-960', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '15-756', phase_index: 0, even_term: '35-499', even_term_index: 18, odd_term: '20-206', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '44-1162', phase_index: 0, even_term: '5-1084', even_term_index: 20, odd_term: '50-791', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '14-405', phase_index: 0, even_term: '36-330', even_term_index: 22, odd_term: '21-37', odd_term_index: 21 }
  ],
  711 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '43-1051', phase_index: 0, even_term: '6-916', even_term_index: 0, odd_term: '51-623', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '13-474', phase_index: 0, even_term: '37-161', even_term_index: 2, odd_term: '21-1208', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '42-1317', phase_index: 0, even_term: '7-747', even_term_index: 4, odd_term: '52-454', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '12-896', phase_index: 0, even_term: '37-1333', even_term_index: 6, odd_term: '22-1040', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '42-532', phase_index: 0, even_term: '8-578', even_term_index: 8, odd_term: '53-285', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '12-69', phase_index: 0, even_term: '38-1164', even_term_index: 10, odd_term: '23-871', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '41-927', phase_index: 0, even_term: '9-410', even_term_index: 12, odd_term: '54-117', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '11-345', phase_index: 0, even_term: '39-995', even_term_index: 14, odd_term: '24-702', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: true, remainder: '40-1014', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '54-1288', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '10-272', phase_index: 0, even_term: '10-241', even_term_index: 16, odd_term: '25-534', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '39-756', phase_index: 0, even_term: '40-827', even_term_index: 18, odd_term: '55-1119', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '8-1330', phase_index: 0, even_term: '11-72', even_term_index: 20, odd_term: '26-365', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '38-519', phase_index: 0, even_term: '41-658', even_term_index: 22, odd_term: '56-951', odd_term_index: 23 }
  ],
  712 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '7-1110', phase_index: 0, even_term: '11-1244', even_term_index: 0, odd_term: '27-196', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '37-447', phase_index: 0, even_term: '42-489', even_term_index: 2, odd_term: '57-782', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '6-1184', phase_index: 0, even_term: '12-1075', even_term_index: 4, odd_term: '28-28', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '36-696', phase_index: 0, even_term: '43-321', even_term_index: 6, odd_term: '58-613', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '6-136', phase_index: 0, even_term: '13-906', even_term_index: 8, odd_term: '28-1199', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '35-989', phase_index: 0, even_term: '44-152', even_term_index: 10, odd_term: '59-445', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '5-528', phase_index: 0, even_term: '14-738', even_term_index: 12, odd_term: '29-1030', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '35-15', phase_index: 0, even_term: '44-1323', even_term_index: 14, odd_term: '0-276', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '4-786', phase_index: 0, even_term: '15-569', even_term_index: 16, odd_term: '30-862', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '34-123', phase_index: 0, even_term: '45-1155', even_term_index: 18, odd_term: '1-107', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '3-788', phase_index: 0, even_term: '16-400', even_term_index: 20, odd_term: '31-693', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '33-104', phase_index: 0, even_term: '46-986', even_term_index: 22, odd_term: '1-1279', odd_term_index: 23 }
  ],
  713 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '2-682', phase_index: 0, even_term: '17-232', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '31-1244', phase_index: 0, even_term: '47-817', even_term_index: 2, odd_term: '32-524', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '1-486', phase_index: 0, even_term: '18-63', even_term_index: 4, odd_term: '2-1110', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '30-1148', phase_index: 0, even_term: '48-649', even_term_index: 6, odd_term: '33-356', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '0-477', phase_index: 0, even_term: '18-1234', even_term_index: 8, odd_term: '3-941', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '29-1157', phase_index: 0, even_term: '49-480', even_term_index: 10, odd_term: '34-187', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '59-594', phase_index: 0, even_term: '19-1066', even_term_index: 12, odd_term: '4-773', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '29-84', phase_index: 0, even_term: '50-311', even_term_index: 14, odd_term: '35-18', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '58-964', phase_index: 0, even_term: '20-897', even_term_index: 16, odd_term: '5-604', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '28-475', phase_index: 0, even_term: '51-143', even_term_index: 18, odd_term: '35-1190', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '57-1248', phase_index: 0, even_term: '21-728', even_term_index: 20, odd_term: '6-435', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '27-757', phase_index: 0, even_term: '51-1314', even_term_index: 22, odd_term: '36-1021', odd_term_index: 21 }
  ],
  714 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '57-150', phase_index: 0, even_term: '22-560', even_term_index: 0, odd_term: '7-267', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '26-820', phase_index: 0, even_term: '52-1145', even_term_index: 2, odd_term: '37-852', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '56-67', phase_index: 0, even_term: '23-391', even_term_index: 4, odd_term: '8-98', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '25-597', phase_index: 0, even_term: '53-977', even_term_index: 6, odd_term: '38-684', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: true, remainder: '54-1174', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '8-1269', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '24-326', phase_index: 0, even_term: '24-222', even_term_index: 8, odd_term: '39-515', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '53-928', phase_index: 0, even_term: '54-808', even_term_index: 10, odd_term: '9-1101', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '23-259', phase_index: 0, even_term: '25-54', even_term_index: 12, odd_term: '40-346', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '52-1020', phase_index: 0, even_term: '55-639', even_term_index: 14, odd_term: '10-932', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '22-542', phase_index: 0, even_term: '25-1225', even_term_index: 16, odd_term: '41-178', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '52-81', phase_index: 0, even_term: '56-471', even_term_index: 18, odd_term: '11-763', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '21-1056', phase_index: 0, even_term: '26-1056', even_term_index: 20, odd_term: '42-9', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '51-631', phase_index: 0, even_term: '57-302', even_term_index: 22, odd_term: '12-595', odd_term_index: 23 }
  ],
  715 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '21-129', phase_index: 0, even_term: '27-888', even_term_index: 0, odd_term: '42-1180', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '50-889', phase_index: 0, even_term: '58-133', even_term_index: 2, odd_term: '13-426', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '20-187', phase_index: 0, even_term: '28-719', even_term_index: 4, odd_term: '43-1012', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '49-765', phase_index: 0, even_term: '58-1305', even_term_index: 6, odd_term: '14-257', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '18-1172', phase_index: 0, even_term: '29-550', even_term_index: 8, odd_term: '44-843', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '48-265', phase_index: 0, even_term: '59-1136', even_term_index: 10, odd_term: '15-89', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '17-769', phase_index: 0, even_term: '30-382', even_term_index: 12, odd_term: '45-674', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '47-6', phase_index: 0, even_term: '0-967', even_term_index: 14, odd_term: '15-1260', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '16-698', phase_index: 0, even_term: '31-213', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 8, leaped: false, remainder: '46-141', phase_index: 0, even_term: '1-799', even_term_index: 18, odd_term: '46-506', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '15-1061', phase_index: 0, even_term: '32-44', even_term_index: 20, odd_term: '16-1091', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '45-774', phase_index: 0, even_term: '2-630', even_term_index: 22, odd_term: '47-337', odd_term_index: 21 }
  ],
  716 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '9-442', phase_index: 0, even_term: '38-204', even_term_index: 0, odd_term: '22-1251', odd_term_index: 23 }
  ],
  717 => [
    { is_many_days: false, month: 11, leaped: true, remainder: '39-168', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '53-496', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '8-1178', phase_index: 0, even_term: '8-789', even_term_index: 2, odd_term: '23-1082', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '38-743', phase_index: 0, even_term: '39-35', even_term_index: 4, odd_term: '54-328', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '8-235', phase_index: 0, even_term: '9-621', even_term_index: 6, odd_term: '24-913', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '37-784', phase_index: 0, even_term: '39-1206', even_term_index: 8, odd_term: '55-159', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '6-1264', phase_index: 0, even_term: '10-452', even_term_index: 10, odd_term: '25-745', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '36-313', phase_index: 0, even_term: '40-1038', even_term_index: 12, odd_term: '55-1330', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '5-673', phase_index: 0, even_term: '11-283', even_term_index: 14, odd_term: '26-576', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '34-1115', phase_index: 0, even_term: '41-869', even_term_index: 16, odd_term: '56-1162', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '4-287', phase_index: 0, even_term: '12-115', even_term_index: 18, odd_term: '27-407', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '33-1010', phase_index: 0, even_term: '42-700', even_term_index: 20, odd_term: '57-993', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '3-529', phase_index: 0, even_term: '12-1286', even_term_index: 22, odd_term: '28-239', odd_term_index: 23 }
  ],
  718 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '33-149', phase_index: 0, even_term: '43-532', even_term_index: 0, odd_term: '58-824', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '2-1199', phase_index: 0, even_term: '13-1117', even_term_index: 2, odd_term: '29-70', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '32-900', phase_index: 0, even_term: '44-363', even_term_index: 4, odd_term: '59-656', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '2-555', phase_index: 0, even_term: '14-949', even_term_index: 6, odd_term: '29-1241', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '32-12', phase_index: 0, even_term: '45-194', even_term_index: 8, odd_term: '0-487', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '1-666', phase_index: 0, even_term: '15-780', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '30-1224', phase_index: 0, even_term: '46-26', even_term_index: 12, odd_term: '30-1073', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '0-330', phase_index: 0, even_term: '16-611', even_term_index: 14, odd_term: '1-318', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '29-727', phase_index: 0, even_term: '46-1197', even_term_index: 16, odd_term: '31-904', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '58-1110', phase_index: 0, even_term: '17-443', even_term_index: 18, odd_term: '2-150', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '28-252', phase_index: 0, even_term: '47-1028', even_term_index: 20, odd_term: '32-735', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '57-944', phase_index: 0, even_term: '18-274', even_term_index: 22, odd_term: '2-1321', odd_term_index: 21 }
  ],
  719 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '27-377', phase_index: 0, even_term: '48-860', even_term_index: 0, odd_term: '33-567', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '56-1269', phase_index: 0, even_term: '19-105', even_term_index: 2, odd_term: '3-1152', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '26-895', phase_index: 0, even_term: '49-691', even_term_index: 4, odd_term: '34-398', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '56-579', phase_index: 0, even_term: '19-1277', even_term_index: 6, odd_term: '4-984', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '26-243', phase_index: 0, even_term: '50-522', even_term_index: 8, odd_term: '35-229', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '55-1059', phase_index: 0, even_term: '20-1108', even_term_index: 10, odd_term: '5-815', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '25-465', phase_index: 0, even_term: '51-354', even_term_index: 12, odd_term: '36-61', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '54-1093', phase_index: 0, even_term: '21-939', even_term_index: 14, odd_term: '6-646', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '24-295', phase_index: 0, even_term: '52-185', even_term_index: 16, odd_term: '36-1232', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '53-767', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '7-478', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '22-1150', phase_index: 0, even_term: '22-771', even_term_index: 18, odd_term: '37-1063', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '52-354', phase_index: 0, even_term: '53-16', even_term_index: 20, odd_term: '8-309', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '21-954', phase_index: 0, even_term: '23-602', even_term_index: 22, odd_term: '38-895', odd_term_index: 23 }
  ],
  720 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '51-319', phase_index: 0, even_term: '53-1188', even_term_index: 0, odd_term: '9-140', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '20-1120', phase_index: 0, even_term: '24-433', even_term_index: 2, odd_term: '39-726', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '50-647', phase_index: 0, even_term: '54-1019', even_term_index: 4, odd_term: '9-1312', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '20-284', phase_index: 0, even_term: '25-265', even_term_index: 6, odd_term: '40-557', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '49-1154', phase_index: 0, even_term: '55-850', even_term_index: 8, odd_term: '10-1143', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '19-700', phase_index: 0, even_term: '26-96', even_term_index: 10, odd_term: '41-389', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '49-170', phase_index: 0, even_term: '56-682', even_term_index: 12, odd_term: '11-974', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '18-884', phase_index: 0, even_term: '26-1267', even_term_index: 14, odd_term: '42-220', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '48-190', phase_index: 0, even_term: '57-513', even_term_index: 16, odd_term: '12-806', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '17-734', phase_index: 0, even_term: '27-1099', even_term_index: 18, odd_term: '43-51', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '46-1288', phase_index: 0, even_term: '58-344', even_term_index: 20, odd_term: '13-637', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '16-503', phase_index: 0, even_term: '28-930', even_term_index: 22, odd_term: '43-1223', odd_term_index: 23 }
  ],
  721 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '45-1049', phase_index: 0, even_term: '59-176', even_term_index: 0, odd_term: '14-468', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '15-345', phase_index: 0, even_term: '29-761', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '44-1039', phase_index: 0, even_term: '0-7', even_term_index: 4, odd_term: '44-1054', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '14-489', phase_index: 0, even_term: '30-593', even_term_index: 6, odd_term: '15-300', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '43-1279', phase_index: 0, even_term: '0-1178', even_term_index: 8, odd_term: '45-885', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '13-744', phase_index: 0, even_term: '31-424', even_term_index: 10, odd_term: '16-131', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '43-277', phase_index: 0, even_term: '1-1010', even_term_index: 12, odd_term: '46-717', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '12-1134', phase_index: 0, even_term: '32-255', even_term_index: 14, odd_term: '16-1302', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '42-602', phase_index: 0, even_term: '2-841', even_term_index: 16, odd_term: '47-548', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '11-1337', phase_index: 0, even_term: '33-87', even_term_index: 18, odd_term: '17-1134', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '41-654', phase_index: 0, even_term: '3-672', even_term_index: 20, odd_term: '48-379', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '11-30', phase_index: 0, even_term: '33-1258', even_term_index: 22, odd_term: '18-965', odd_term_index: 21 }
  ],
  722 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '40-642', phase_index: 0, even_term: '4-504', even_term_index: 0, odd_term: '49-211', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '9-1218', phase_index: 0, even_term: '34-1089', even_term_index: 2, odd_term: '19-796', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '39-433', phase_index: 0, even_term: '5-335', even_term_index: 4, odd_term: '50-42', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '8-1042', phase_index: 0, even_term: '35-921', even_term_index: 6, odd_term: '20-628', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '38-384', phase_index: 0, even_term: '6-166', even_term_index: 8, odd_term: '50-1213', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '7-1005', phase_index: 0, even_term: '36-752', even_term_index: 10, odd_term: '21-459', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: true, remainder: '37-394', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '51-1045', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '6-1189', phase_index: 0, even_term: '6-1338', even_term_index: 12, odd_term: '22-290', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '36-708', phase_index: 0, even_term: '37-583', even_term_index: 14, odd_term: '52-876', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '6-252', phase_index: 0, even_term: '7-1169', even_term_index: 16, odd_term: '23-122', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '35-1051', phase_index: 0, even_term: '38-415', even_term_index: 18, odd_term: '53-707', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '5-579', phase_index: 0, even_term: '8-1000', even_term_index: 20, odd_term: '23-1293', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '35-27', phase_index: 0, even_term: '39-246', even_term_index: 22, odd_term: '54-539', odd_term_index: 23 }
  ],
  723 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '4-737', phase_index: 0, even_term: '9-832', even_term_index: 0, odd_term: '24-1124', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '34-32', phase_index: 0, even_term: '40-77', even_term_index: 2, odd_term: '55-370', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '3-577', phase_index: 0, even_term: '10-663', even_term_index: 4, odd_term: '25-956', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '32-1135', phase_index: 0, even_term: '40-1249', even_term_index: 6, odd_term: '56-201', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '2-272', phase_index: 0, even_term: '11-494', even_term_index: 8, odd_term: '26-787', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '31-822', phase_index: 0, even_term: '41-1080', even_term_index: 10, odd_term: '57-33', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '1-110', phase_index: 0, even_term: '12-326', even_term_index: 12, odd_term: '27-618', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '30-817', phase_index: 0, even_term: '42-911', even_term_index: 14, odd_term: '57-1204', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '0-295', phase_index: 0, even_term: '13-157', even_term_index: 16, odd_term: '28-450', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '29-1173', phase_index: 0, even_term: '43-743', even_term_index: 18, odd_term: '58-1035', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '59-779', phase_index: 0, even_term: '13-1328', even_term_index: 20, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 10, leaped: false, remainder: '29-409', phase_index: 0, even_term: '44-574', even_term_index: 22, odd_term: '29-281', odd_term_index: 21 }
  ],
  724 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '58-1290', phase_index: 0, even_term: '14-1160', even_term_index: 0, odd_term: '59-867', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '28-761', phase_index: 0, even_term: '45-405', even_term_index: 2, odd_term: '30-112', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '58-119', phase_index: 0, even_term: '15-991', even_term_index: 4, odd_term: '0-698', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '27-727', phase_index: 0, even_term: '46-237', even_term_index: 6, odd_term: '30-1284', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '56-1204', phase_index: 0, even_term: '16-822', even_term_index: 8, odd_term: '1-529', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '26-250', phase_index: 0, even_term: '47-68', even_term_index: 10, odd_term: '31-1115', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '55-716', phase_index: 0, even_term: '17-654', even_term_index: 12, odd_term: '2-361', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '24-1243', phase_index: 0, even_term: '47-1239', even_term_index: 14, odd_term: '32-946', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '54-535', phase_index: 0, even_term: '18-485', even_term_index: 16, odd_term: '3-192', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '23-1275', phase_index: 0, even_term: '48-1071', even_term_index: 18, odd_term: '33-778', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '53-753', phase_index: 0, even_term: '4-23', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 10, leaped: false, remainder: '23-471', phase_index: 0, even_term: '49-902', even_term_index: 22, odd_term: '34-609', odd_term_index: 21 }
  ],
  725 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '53-159', phase_index: 0, even_term: '20-148', even_term_index: 0, odd_term: '4-1195', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '22-1139', phase_index: 0, even_term: '50-733', even_term_index: 2, odd_term: '35-440', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '52-691', phase_index: 0, even_term: '20-1319', even_term_index: 4, odd_term: '5-1026', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: true, remainder: '22-126', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '36-272', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '51-817', phase_index: 0, even_term: '51-565', even_term_index: 6, odd_term: '6-857', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '20-1247', phase_index: 0, even_term: '21-1150', even_term_index: 8, odd_term: '37-103', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '50-298', phase_index: 0, even_term: '52-396', even_term_index: 10, odd_term: '7-689', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '19-677', phase_index: 0, even_term: '22-982', even_term_index: 12, odd_term: '37-1274', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '48-1127', phase_index: 0, even_term: '53-227', even_term_index: 14, odd_term: '8-520', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '18-346', phase_index: 0, even_term: '23-813', even_term_index: 16, odd_term: '38-1106', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '47-982', phase_index: 0, even_term: '54-59', even_term_index: 18, odd_term: '9-351', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '17-504', phase_index: 0, even_term: '24-644', even_term_index: 20, odd_term: '39-937', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '47-146', phase_index: 0, even_term: '54-1230', even_term_index: 22, odd_term: '10-183', odd_term_index: 23 }
  ],
  726 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '16-1197', phase_index: 0, even_term: '25-476', even_term_index: 0, odd_term: '40-768', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '46-911', phase_index: 0, even_term: '55-1061', even_term_index: 2, odd_term: '11-14', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '16-526', phase_index: 0, even_term: '26-307', even_term_index: 4, odd_term: '41-600', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '46-65', phase_index: 0, even_term: '56-893', even_term_index: 6, odd_term: '11-1185', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '15-721', phase_index: 0, even_term: '27-138', even_term_index: 8, odd_term: '42-431', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '44-1247', phase_index: 0, even_term: '57-724', even_term_index: 10, odd_term: '12-1017', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '14-341', phase_index: 0, even_term: '27-1310', even_term_index: 12, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 6, leaped: false, remainder: '43-700', phase_index: 0, even_term: '58-555', even_term_index: 14, odd_term: '43-262', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '12-1096', phase_index: 0, even_term: '28-1141', even_term_index: 16, odd_term: '13-848', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '42-230', phase_index: 0, even_term: '59-387', even_term_index: 18, odd_term: '44-94', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '11-839', phase_index: 0, even_term: '29-972', even_term_index: 20, odd_term: '14-679', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '41-318', phase_index: 0, even_term: '0-218', even_term_index: 22, odd_term: '44-1265', odd_term_index: 21 }
  ],
  727 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '10-1220', phase_index: 0, even_term: '30-804', even_term_index: 0, odd_term: '15-511', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '40-893', phase_index: 0, even_term: '1-49', even_term_index: 2, odd_term: '45-1096', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '10-603', phase_index: 0, even_term: '31-635', even_term_index: 4, odd_term: '16-342', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '40-287', phase_index: 0, even_term: '1-1221', even_term_index: 6, odd_term: '46-928', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '9-1191', phase_index: 0, even_term: '32-466', even_term_index: 8, odd_term: '17-173', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '39-550', phase_index: 0, even_term: '2-1052', even_term_index: 10, odd_term: '47-759', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '8-1167', phase_index: 0, even_term: '33-298', even_term_index: 12, odd_term: '18-5', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '38-325', phase_index: 0, even_term: '3-883', even_term_index: 14, odd_term: '48-590', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '7-748', phase_index: 0, even_term: '34-129', even_term_index: 16, odd_term: '18-1176', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '36-1135', phase_index: 0, even_term: '4-715', even_term_index: 18, odd_term: '49-422', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '6-179', phase_index: 0, even_term: '34-1300', even_term_index: 20, odd_term: '19-1007', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: true, remainder: '35-831', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '50-253', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '5-208', phase_index: 0, even_term: '5-546', even_term_index: 22, odd_term: '20-839', odd_term_index: 23 }
  ],
  728 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '34-1042', phase_index: 0, even_term: '35-1132', even_term_index: 0, odd_term: '51-84', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '4-630', phase_index: 0, even_term: '6-377', even_term_index: 2, odd_term: '21-670', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '34-275', phase_index: 0, even_term: '36-963', even_term_index: 4, odd_term: '51-1256', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '3-1338', phase_index: 0, even_term: '7-209', even_term_index: 6, odd_term: '22-501', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '33-848', phase_index: 0, even_term: '37-794', even_term_index: 8, odd_term: '52-1087', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '3-303', phase_index: 0, even_term: '8-40', even_term_index: 10, odd_term: '23-333', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '32-991', phase_index: 0, even_term: '38-626', even_term_index: 12, odd_term: '53-918', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '2-238', phase_index: 0, even_term: '8-1211', even_term_index: 14, odd_term: '24-164', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '31-754', phase_index: 0, even_term: '39-457', even_term_index: 16, odd_term: '54-750', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '0-1180', phase_index: 0, even_term: '9-1043', even_term_index: 18, odd_term: '24-1335', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '30-322', phase_index: 0, even_term: '40-288', even_term_index: 20, odd_term: '55-581', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '59-885', phase_index: 0, even_term: '10-874', even_term_index: 22, odd_term: '25-1167', odd_term_index: 23 }
  ],
  729 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '29-192', phase_index: 0, even_term: '41-120', even_term_index: 0, odd_term: '56-412', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '58-948', phase_index: 0, even_term: '11-705', even_term_index: 2, odd_term: '26-998', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '28-429', phase_index: 0, even_term: '41-1291', even_term_index: 4, odd_term: '57-244', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '58-7', phase_index: 0, even_term: '12-537', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 3, leaped: false, remainder: '27-904', phase_index: 0, even_term: '42-1122', even_term_index: 8, odd_term: '27-829', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '57-450', phase_index: 0, even_term: '13-368', even_term_index: 10, odd_term: '58-75', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '26-1308', phase_index: 0, even_term: '43-954', even_term_index: 12, odd_term: '28-661', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '56-728', phase_index: 0, even_term: '14-199', even_term_index: 14, odd_term: '58-1246', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '26-79', phase_index: 0, even_term: '44-785', even_term_index: 16, odd_term: '29-492', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '55-683', phase_index: 0, even_term: '15-31', even_term_index: 18, odd_term: '59-1078', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '24-1221', phase_index: 0, even_term: '45-616', even_term_index: 20, odd_term: '30-323', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '54-480', phase_index: 0, even_term: '15-1202', even_term_index: 22, odd_term: '0-909', odd_term_index: 21 }
  ],
  730 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '23-1012', phase_index: 0, even_term: '46-448', even_term_index: 0, odd_term: '31-155', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '53-265', phase_index: 0, even_term: '16-1033', even_term_index: 2, odd_term: '1-740', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '22-922', phase_index: 0, even_term: '47-279', even_term_index: 4, odd_term: '31-1326', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '52-312', phase_index: 0, even_term: '17-865', even_term_index: 6, odd_term: '2-572', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '21-1111', phase_index: 0, even_term: '48-110', even_term_index: 8, odd_term: '32-1157', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '51-521', phase_index: 0, even_term: '18-696', even_term_index: 10, odd_term: '3-403', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '21-27', phase_index: 0, even_term: '48-1282', even_term_index: 12, odd_term: '33-989', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '50-896', phase_index: 0, even_term: '19-527', even_term_index: 14, odd_term: '4-234', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: true, remainder: '20-396', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '34-820', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '49-1182', phase_index: 0, even_term: '49-1113', even_term_index: 16, odd_term: '5-66', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '19-518', phase_index: 0, even_term: '20-359', even_term_index: 18, odd_term: '35-651', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '48-1267', phase_index: 0, even_term: '50-944', even_term_index: 20, odd_term: '5-1237', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '18-583', phase_index: 0, even_term: '21-190', even_term_index: 22, odd_term: '36-493', odd_term_index: 23 }
  ],
  731 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '47-1181', phase_index: 0, even_term: '51-776', even_term_index: 0, odd_term: '6-1068', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '17-400', phase_index: 0, even_term: '22-21', even_term_index: 2, odd_term: '37-314', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '46-966', phase_index: 0, even_term: '52-607', even_term_index: 4, odd_term: '7-900', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '16-291', phase_index: 0, even_term: '22-1193', even_term_index: 6, odd_term: '38-145', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '45-879', phase_index: 0, even_term: '53-438', even_term_index: 8, odd_term: '6-731', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '15-217', phase_index: 0, even_term: '23-1024', even_term_index: 10, odd_term: '38-1317', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '44-974', phase_index: 0, even_term: '54-270', even_term_index: 12, odd_term: '9-562', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '14-1156', phase_index: 0, even_term: '24-855', even_term_index: 14, odd_term: '39-1148', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '44-5', phase_index: 0, even_term: '55-101', even_term_index: 16, odd_term: '10-3911', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '13-854', phase_index: 0, even_term: '25-687', even_term_index: 18, odd_term: '40-979', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '43-369', phase_index: 0, even_term: '55-1272', even_term_index: 20, odd_term: '11-225', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '12-1216', phase_index: 0, even_term: '26-518', even_term_index: 22, odd_term: '41-811', odd_term_index: 23 }
  ],
  732 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '42-628', phase_index: 0, even_term: '56-1104', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '11-1313', phase_index: 0, even_term: '27-349', even_term_index: 2, odd_term: '12-56', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '41-554', phase_index: 0, even_term: '57-935', even_term_index: 4, odd_term: '42-642', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '10-1092', phase_index: 0, even_term: '28-181', even_term_index: 6, odd_term: '12-1228', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '40-246', phase_index: 0, even_term: '58-766', even_term_index: 8, odd_term: '43-473', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '9-742', phase_index: 0, even_term: '29-12', even_term_index: 10, odd_term: '13-1059', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '38-1328', phase_index: 0, even_term: '59-598', even_term_index: 12, odd_term: '44-305', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '8-645', phase_index: 0, even_term: '29-1183', even_term_index: 14, odd_term: '14-880', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '38-67', phase_index: 0, even_term: '0-429', even_term_index: 16, odd_term: '45-136', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '7-921', phase_index: 0, even_term: '30-1015', even_term_index: 18, odd_term: '15-722', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '37-476', phase_index: 0, even_term: '1-260', even_term_index: 20, odd_term: '45-1307', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '7-160', phase_index: 0, even_term: '31-846', even_term_index: 22, odd_term: '16-553', odd_term_index: 21 }
  ],
  733 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '36-1082', phase_index: 0, even_term: '2-92', even_term_index: 0, odd_term: '46-1139', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '6-603', phase_index: 0, even_term: '32-677', even_term_index: 2, odd_term: '17-384', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '36-22', phase_index: 0, even_term: '2-1263', even_term_index: 4, odd_term: '47-970', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '5-668', phase_index: 0, even_term: '33-509', even_term_index: 6, odd_term: '18-216', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '34-1237', phase_index: 0, even_term: '3-1094', even_term_index: 8, odd_term: '48-801', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true, remainder: '4-260', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '19-47', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '33-687', phase_index: 0, even_term: '34-340', even_term_index: 10, odd_term: '49-633', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '2-1172', phase_index: 0, even_term: '4-926', even_term_index: 12, odd_term: '19-1218', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '32-404', phase_index: 0, even_term: '35-171', even_term_index: 14, odd_term: '50-464', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '1-1094', phase_index: 0, even_term: '5-757', even_term_index: 16, odd_term: '20-1050', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '31-519', phase_index: 0, even_term: '36-3', even_term_index: 18, odd_term: '51-295', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '1-164', phase_index: 0, even_term: '6-588', even_term_index: 20, odd_term: '21-881', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '30-1207', phase_index: 0, even_term: '36-1174', even_term_index: 22, odd_term: '52-127', odd_term_index: 23 }
  ],
  734 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '0-881', phase_index: 0, even_term: '7-1420', even_term_index: 0, odd_term: '22-712', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '30-491', phase_index: 0, even_term: '37-1005', even_term_index: 2, odd_term: '52-1298', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '59-1320', phase_index: 0, even_term: '8-251', even_term_index: 4, odd_term: '23-544', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '29-728', phase_index: 0, even_term: '38-837', even_term_index: 6, odd_term: '53-1129', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '58-1246', phase_index: 0, even_term: '9-82', even_term_index: 8, odd_term: '24-375', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '28-322', phase_index: 0, even_term: '39-668', even_term_index: 10, odd_term: '54-961', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '57-694', phase_index: 0, even_term: '9-1254', even_term_index: 12, odd_term: '25-206', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '26-1095', phase_index: 0, even_term: '40-499', even_term_index: 14, odd_term: '55-792', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '56-260', phase_index: 0, even_term: '10-1085', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 8, leaped: false, remainder: '25-855', phase_index: 0, even_term: '41-331', even_term_index: 18, odd_term: '26-38', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '55-263', phase_index: 0, even_term: '11-916', even_term_index: 20, odd_term: '56-623', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '24-1209', phase_index: 0, even_term: '42-162', even_term_index: 22, odd_term: '26-1209', odd_term_index: 21 }
  ],
  735 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '48-978', phase_index: 0, even_term: '17-1076', even_term_index: 0, odd_term: '2-783', odd_term_index: 23 }
  ],
  736 => [
    { is_many_days: true, month: 11, leaped: true, remainder: '18-601', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '33-28', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '48-297', phase_index: 0, even_term: '48-321', even_term_index: 2, odd_term: '3-614', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '17-1339', phase_index: 0, even_term: '18-907', even_term_index: 4, odd_term: '33-1200', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '47-1009', phase_index: 0, even_term: '49-153', even_term_index: 6, odd_term: '4-445', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '17-408', phase_index: 0, even_term: '19-738', even_term_index: 8, odd_term: '34-1031', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '46-1078', phase_index: 0, even_term: '49-1324', even_term_index: 10, odd_term: '5-277', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '16-293', phase_index: 0, even_term: '20-570', even_term_index: 12, odd_term: '35-862', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '45-754', phase_index: 0, even_term: '50-1155', even_term_index: 14, odd_term: '6-108', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '14-1163', phase_index: 0, even_term: '21-401', even_term_index: 16, odd_term: '36-694', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '44-193', phase_index: 0, even_term: '51-887', even_term_index: 18, odd_term: '6-1279', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '13-738', phase_index: 0, even_term: '22-232', even_term_index: 20, odd_term: '37-525', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '43-70', phase_index: 0, even_term: '52-818', even_term_index: 22, odd_term: '7-1111', odd_term_index: 23 }
  ],
  737 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '12-843', phase_index: 0, even_term: '23-64', even_term_index: 0, odd_term: '38-356', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '42-387', phase_index: 0, even_term: '53-649', even_term_index: 2, odd_term: '8-942', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '11-1333', phase_index: 0, even_term: '23-1235', even_term_index: 4, odd_term: '39-188', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '41-1020', phase_index: 0, even_term: '54-481', even_term_index: 6, odd_term: '9-773', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '11-617', phase_index: 0, even_term: '24-1066', even_term_index: 8, odd_term: '40-19', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '41-111', phase_index: 0, even_term: '55-312', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 5, leaped: false, remainder: '10-859', phase_index: 0, even_term: '25-898', even_term_index: 12, odd_term: '10-605', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '40-153', phase_index: 0, even_term: '56-143', even_term_index: 14, odd_term: '40-1190', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '9-715', phase_index: 0, even_term: '26-729', even_term_index: 16, odd_term: '11-436', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '38-1191', phase_index: 0, even_term: '56-1315', even_term_index: 18, odd_term: '41-1022', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '8-294', phase_index: 0, even_term: '27-560', even_term_index: 20, odd_term: '12-267', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '37-841', phase_index: 0, even_term: '57-1146', even_term_index: 22, odd_term: '42-853', odd_term_index: 21 }
  ],
  738 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '7-96', phase_index: 0, even_term: '28-392', even_term_index: 0, odd_term: '13-99', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '36-800', phase_index: 0, even_term: '58-977', even_term_index: 2, odd_term: '43-684', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '6-239', phase_index: 0, even_term: '29-223', even_term_index: 4, odd_term: '13-1270', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '35-1099', phase_index: 0, even_term: '59-809', even_term_index: 6, odd_term: '44-516', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '5-674', phase_index: 0, even_term: '30-54', even_term_index: 8, odd_term: '14-1101', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '35-190', phase_index: 0, even_term: '0-640', even_term_index: 10, odd_term: '45-347', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '4-1080', phase_index: 0, even_term: '30-1226', even_term_index: 12, odd_term: '15-933', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '34-548', phase_index: 0, even_term: '1-471', even_term_index: 14, odd_term: '46-178', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '3-1280', phase_index: 0, even_term: '31-1057', even_term_index: 16, odd_term: '16-764', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: true, remainder: '33-600', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '47-10', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '2-1144', phase_index: 0, even_term: '2-303', even_term_index: 18, odd_term: '17-595', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '32-438', phase_index: 0, even_term: '32-888', even_term_index: 20, odd_term: '47-1181', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '1-991', phase_index: 0, even_term: '3-134', even_term_index: 22, odd_term: '18-427', odd_term_index: 23 }
  ],
  739 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '31-206', phase_index: 0, even_term: '33-720', even_term_index: 0, odd_term: '48-1012', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '0-828', phase_index: 0, even_term: '3-1305', even_term_index: 2, odd_term: '19-258', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '30-167', phase_index: 0, even_term: '34-551', even_term_index: 4, odd_term: '49-844', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '59-959', phase_index: 0, even_term: '4-1137', even_term_index: 6, odd_term: '20-89', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '29-325', phase_index: 0, even_term: '35-382', even_term_index: 8, odd_term: '50-675', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '58-1130', phase_index: 0, even_term: '5-968', even_term_index: 10, odd_term: '20-1261', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '28-647', phase_index: 0, even_term: '36-214', even_term_index: 12, odd_term: '51-506', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '58-168', phase_index: 0, even_term: '6-799', even_term_index: 14, odd_term: '21-1092', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '27-995', phase_index: 0, even_term: '37-45', even_term_index: 16, odd_term: '52-338', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '57-390', phase_index: 0, even_term: '7-631', even_term_index: 18, odd_term: '22-823', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '26-1130', phase_index: 0, even_term: '37-1216', even_term_index: 20, odd_term: '53-169', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '56-504', phase_index: 0, even_term: '8-462', even_term_index: 22, odd_term: '23-755', odd_term_index: 23 }
  ],
  740 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '25-1134', phase_index: 0, even_term: '38-1048', even_term_index: 0, odd_term: '54-0', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '55-376', phase_index: 0, even_term: '9-293', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '24-917', phase_index: 0, even_term: '39-879', even_term_index: 4, odd_term: '24-586', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '54-187', phase_index: 0, even_term: '10-125', even_term_index: 6, odd_term: '54-1172', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '23-789', phase_index: 0, even_term: '40-710', even_term_index: 8, odd_term: '25-417', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '53-68', phase_index: 0, even_term: '10-1296', even_term_index: 10, odd_term: '55-1003', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '22-781', phase_index: 0, even_term: '41-542', even_term_index: 12, odd_term: '26-249', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '52-222', phase_index: 0, even_term: '11-1127', even_term_index: 14, odd_term: '56-834', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '21-1086', phase_index: 0, even_term: '42-373', even_term_index: 16, odd_term: '27-80', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '51-631', phase_index: 0, even_term: '12-959', even_term_index: 18, odd_term: '57-666', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '21-130', phase_index: 0, even_term: '43-204', even_term_index: 20, odd_term: '27-1251', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '50-1036', phase_index: 0, even_term: '13-790', even_term_index: 22, odd_term: '58-497', odd_term_index: 21 }
  ],
  741 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '20-494', phase_index: 0, even_term: '44-36', even_term_index: 0, odd_term: '28-1083', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '49-1225', phase_index: 0, even_term: '14-621', even_term_index: 2, odd_term: '59-328', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '19-518', phase_index: 0, even_term: '44-1207', even_term_index: 4, odd_term: '29-914', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '48-1069', phase_index: 0, even_term: '15-453', even_term_index: 6, odd_term: '0-160', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '18-252', phase_index: 0, even_term: '45-1038', even_term_index: 8, odd_term: '30-745', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true, remainder: '47-693', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '0-1331', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '16-1233', phase_index: 0, even_term: '16-284', even_term_index: 10, odd_term: '31-577', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '46-503', phase_index: 0, even_term: '46-870', even_term_index: 12, odd_term: '1-1162', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '15-1205', phase_index: 0, even_term: '17-115', even_term_index: 14, odd_term: '32-408', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '45-680', phase_index: 0, even_term: '47-701', even_term_index: 16, odd_term: '2-994', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '15-201', phase_index: 0, even_term: '17-1287', even_term_index: 18, odd_term: '33-239', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '44-1223', phase_index: 0, even_term: '48-532', even_term_index: 20, odd_term: '3-825', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '14-853', phase_index: 0, even_term: '18-1118', even_term_index: 22, odd_term: '34-71', odd_term_index: 23 }
  ],
  742 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '44-415', phase_index: 0, even_term: '49-364', even_term_index: 0, odd_term: '4-656', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '13-1235', phase_index: 0, even_term: '19-949', even_term_index: 2, odd_term: '34-1242', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '43-592', phase_index: 0, even_term: '50-195', even_term_index: 4, odd_term: '5-488', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '12-1221', phase_index: 0, even_term: '20-781', even_term_index: 6, odd_term: '35-1073', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '42-292', phase_index: 0, even_term: '51-26', even_term_index: 8, odd_term: '6-319', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '11-682', phase_index: 0, even_term: '21-612', even_term_index: 10, odd_term: '36-905', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '40-1128', phase_index: 0, even_term: '51-1198', even_term_index: 12, odd_term: '7-150', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '10-306', phase_index: 0, even_term: '22-443', even_term_index: 14, odd_term: '37-736', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '39-938', phase_index: 0, even_term: '52-1029', even_term_index: 16, odd_term: '7-1322', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '9-321', phase_index: 0, even_term: '23-275', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 9, leaped: false, remainder: '38-1205', phase_index: 0, even_term: '53-860', even_term_index: 20, odd_term: '38-567', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '8-906', phase_index: 0, even_term: '24-106', even_term_index: 22, odd_term: '8-1153', odd_term_index: 21 }
  ],
  743 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '38-602', phase_index: 0, even_term: '54-692', even_term_index: 0, odd_term: '39-399', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '8-258', phase_index: 0, even_term: '24-1277', even_term_index: 2, odd_term: '9-984', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '37-1147', phase_index: 0, even_term: '55-523', even_term_index: 4, odd_term: '40-230', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '7-598', phase_index: 0, even_term: '25-1109', even_term_index: 6, odd_term: '10-816', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '36-1226', phase_index: 0, even_term: '56-354', even_term_index: 8, odd_term: '41-61', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '6-335', phase_index: 0, even_term: '26-940', even_term_index: 10, odd_term: '11-647', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '35-728', phase_index: 0, even_term: '57-186', even_term_index: 12, odd_term: '41-1233', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '4-1092', phase_index: 0, even_term: '27-771', even_term_index: 14, odd_term: '12-478', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '34-202', phase_index: 0, even_term: '58-17', even_term_index: 16, odd_term: '42-1064', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '3-753', phase_index: 0, even_term: '28-603', even_term_index: 18, odd_term: '13-310', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '33-47', phase_index: 0, even_term: '58-1188', even_term_index: 20, odd_term: '43-895', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '2-953', phase_index: 0, even_term: '29-434', even_term_index: 22, odd_term: '14-141', odd_term_index: 21 }
  ],
  744 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '32-584', phase_index: 0, even_term: '59-1020', even_term_index: 0, odd_term: '44-727', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '2-302', phase_index: 0, even_term: '30-265', even_term_index: 2, odd_term: '14-1312', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '32-13', phase_index: 0, even_term: '0-851', even_term_index: 4, odd_term: '45-558', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: true, remainder: '1-973', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '15-1144', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '31-516', phase_index: 0, even_term: '31-97', even_term_index: 6, odd_term: '46-389', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '0-1128', phase_index: 0, even_term: '16-975', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 4, leaped: false, remainder: '30-327', phase_index: 0, even_term: '31-1268', even_term_index: 10, odd_term: '47-221', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '59-761', phase_index: 0, even_term: '2-514', even_term_index: 12, odd_term: '17-806', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '28-1129', phase_index: 0, even_term: '32-1099', even_term_index: 14, odd_term: '48-52', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '58-185', phase_index: 0, even_term: '3-345', even_term_index: 16, odd_term: '18-638', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '27-639', phase_index: 0, even_term: '33-931', even_term_index: 18, odd_term: '48-1223', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '56-1311', phase_index: 0, even_term: '4-176', even_term_index: 20, odd_term: '19-469', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '26-770', phase_index: 0, even_term: '34-762', even_term_index: 22, odd_term: '49-1055', odd_term_index: 23 }
  ],
  745 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '56-333', phase_index: 0, even_term: '5-8', even_term_index: 0, odd_term: '20-300', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '25-1336', phase_index: 0, even_term: '35-593', even_term_index: 2, odd_term: '50-886', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '55-1035', phase_index: 0, even_term: '5-1179', even_term_index: 4, odd_term: '21-132', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '25-738', phase_index: 0, even_term: '36-425', even_term_index: 6, odd_term: '51-717', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '55-238', phase_index: 0, even_term: '6-1010', even_term_index: 8, odd_term: '21-1303', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '24-956', phase_index: 0, even_term: '37-256', even_term_index: 10, odd_term: '52-549', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '54-232', phase_index: 0, even_term: '7-842', even_term_index: 12, odd_term: '22-1134', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '23-736', phase_index: 0, even_term: '38-87', even_term_index: 14, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 7, leaped: false, remainder: '52-1178', phase_index: 0, even_term: '8-673', even_term_index: 16, odd_term: '53-380', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '22-224', phase_index: 0, even_term: '38-1259', even_term_index: 18, odd_term: '23-966', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '51-669', phase_index: 0, even_term: '9-504', even_term_index: 20, odd_term: '54-211', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '20-1304', phase_index: 0, even_term: '39-1090', even_term_index: 22, odd_term: '24-797', odd_term_index: 21 }
  ],
  746 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '50-676', phase_index: 0, even_term: '10-336', even_term_index: 0, odd_term: '55-43', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '20-168', phase_index: 0, even_term: '40-921', even_term_index: 2, odd_term: '25-628', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '49-1074', phase_index: 0, even_term: '11-167', even_term_index: 4, odd_term: '55-1214', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '19-717', phase_index: 0, even_term: '41-753', even_term_index: 6, odd_term: '26-460', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '49-369', phase_index: 0, even_term: '11-1338', even_term_index: 8, odd_term: '56-1045', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '18-1233', phase_index: 0, even_term: '42-584', even_term_index: 10, odd_term: '27-291', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '48-696', phase_index: 0, even_term: '12-1170', even_term_index: 12, odd_term: '57-877', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '18-46', phase_index: 0, even_term: '43-415', even_term_index: 14, odd_term: '28-122', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '47-650', phase_index: 0, even_term: '13-1001', even_term_index: 16, odd_term: '58-709', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '16-1179', phase_index: 0, even_term: '44-247', even_term_index: 18, odd_term: '28-1294', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '46-261', phase_index: 0, even_term: '14-832', even_term_index: 20, odd_term: '59-539', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: true, remainder: '15-817', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '29-1125', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '45-27', phase_index: 0, even_term: '45-78', even_term_index: 22, odd_term: '0-371', odd_term_index: 23 }
  ],
  747 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '14-678', phase_index: 0, even_term: '15-664', even_term_index: 0, odd_term: '30-956', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '44-76', phase_index: 0, even_term: '45-1249', even_term_index: 2, odd_term: '1-202', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '13-881', phase_index: 0, even_term: '16-495', even_term_index: 4, odd_term: '31-788', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '43-463', phase_index: 0, even_term: '46-1081', even_term_index: 6, odd_term: '2-33', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '12-1279', phase_index: 0, even_term: '17-326', even_term_index: 8, odd_term: '32-619', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '42-830', phase_index: 0, even_term: '47-912', even_term_index: 10, odd_term: '2-1205', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '12-344', phase_index: 0, even_term: '18-158', even_term_index: 12, odd_term: '33-450', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '41-1118', phase_index: 0, even_term: '48-743', even_term_index: 14, odd_term: '3-1036', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '11-486', phase_index: 0, even_term: '18-1329', even_term_index: 16, odd_term: '34-282', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '40-1090', phase_index: 0, even_term: '49-575', even_term_index: 18, odd_term: '4-867', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '10-371', phase_index: 0, even_term: '19-1160', even_term_index: 20, odd_term: '35-113', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '39-965', phase_index: 0, even_term: '50-406', even_term_index: 22, odd_term: '5-699', odd_term_index: 23 }
  ],
  748 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '9-170', phase_index: 0, even_term: '20-992', even_term_index: 0, odd_term: '35-1284', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '38-758', phase_index: 0, even_term: '51-237', even_term_index: 2, odd_term: '6-530', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '8-54', phase_index: 0, even_term: '21-823', even_term_index: 4, odd_term: '36-1116', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '37-784', phase_index: 0, even_term: '52-69', even_term_index: 6, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 3, leaped: false, remainder: '7-160', phase_index: 0, even_term: '22-654', even_term_index: 8, odd_term: '7-361', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '36-811', phase_index: 0, even_term: '52-1240', even_term_index: 10, odd_term: '37-947', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '6-402', phase_index: 0, even_term: '23-486', even_term_index: 12, odd_term: '8-193', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '35-1263', phase_index: 0, even_term: '53-1071', even_term_index: 14, odd_term: '38-778', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '5-782', phase_index: 0, even_term: '24-317', even_term_index: 16, odd_term: '9-24', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '35-233', phase_index: 0, even_term: '54-903', even_term_index: 18, odd_term: '39-610', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '4-963', phase_index: 0, even_term: '25-148', even_term_index: 20, odd_term: '9-1195', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '34-399', phase_index: 0, even_term: '55-734', even_term_index: 22, odd_term: '40-441', odd_term_index: 21 }
  ],
  749 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '3-1067', phase_index: 0, even_term: '25-1320', even_term_index: 0, odd_term: '10-1027', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '33-341', phase_index: 0, even_term: '56-565', even_term_index: 2, odd_term: '41-272', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '2-891', phase_index: 0, even_term: '26-1151', even_term_index: 4, odd_term: '11-858', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '32-112', phase_index: 0, even_term: '57-397', even_term_index: 6, odd_term: '42-104', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '1-725', phase_index: 0, even_term: '27-982', even_term_index: 8, odd_term: '12-689', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '30-1285', phase_index: 0, even_term: '58-228', even_term_index: 10, odd_term: '42-1275', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '0-614', phase_index: 0, even_term: '28-814', even_term_index: 12, odd_term: '13-521', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true, remainder: '30-12', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '43-1106', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '59-833', phase_index: 0, even_term: '59-59', even_term_index: 14, odd_term: '14-352', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '29-386', phase_index: 0, even_term: '29-645', even_term_index: 16, odd_term: '44-938', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '58-1230', phase_index: 0, even_term: '59-1231', even_term_index: 18, odd_term: '15-183', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '28-827', phase_index: 0, even_term: '30-476', even_term_index: 20, odd_term: '45-769', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '58-335', phase_index: 0, even_term: '0-1062', even_term_index: 22, odd_term: '16-15', odd_term_index: 23 }
  ],
  750 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '27-1109', phase_index: 0, even_term: '31-308', even_term_index: 0, odd_term: '46-600', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '57-459', phase_index: 0, even_term: '1-893', even_term_index: 2, odd_term: '16-1186', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '26-1040', phase_index: 0, even_term: '32-139', even_term_index: 4, odd_term: '47-432', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '56-251', phase_index: 0, even_term: '2-725', even_term_index: 6, odd_term: '17-1017', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '25-670', phase_index: 0, even_term: '32-1310', even_term_index: 8, odd_term: '48-263', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '54-1162', phase_index: 0, even_term: '3-556', even_term_index: 10, odd_term: '16-849', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '24-389', phase_index: 0, even_term: '33-1142', even_term_index: 12, odd_term: '49-94', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '53-1034', phase_index: 0, even_term: '4-387', even_term_index: 14, odd_term: '19-680', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '23-456', phase_index: 0, even_term: '34-973', even_term_index: 16, odd_term: '49-1266', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '52-1294', phase_index: 0, even_term: '5-219', even_term_index: 18, odd_term: '20-511', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '22-922', phase_index: 0, even_term: '35-804', even_term_index: 20, odd_term: '50-1097', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '52-599', phase_index: 0, even_term: '6-50', even_term_index: 22, odd_term: '21-343', odd_term_index: 23 }
  ],
  751 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '22-199', phase_index: 0, even_term: '36-636', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '51-1076', phase_index: 0, even_term: '6-1221', even_term_index: 2, odd_term: '51-928', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '21-491', phase_index: 0, even_term: '37-467', even_term_index: 4, odd_term: '22-174', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '50-1156', phase_index: 0, even_term: '7-1053', even_term_index: 6, odd_term: '52-760', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '20-319', phase_index: 0, even_term: '38-298', even_term_index: 8, odd_term: '23-5', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '49-694', phase_index: 0, even_term: '8-884', even_term_index: 10, odd_term: '53-591', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '18-1109', phase_index: 0, even_term: '39-130', even_term_index: 12, odd_term: '23-1177', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '48-239', phase_index: 0, even_term: '9-715', even_term_index: 14, odd_term: '54-422', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '17-810', phase_index: 0, even_term: '39-1301', even_term_index: 16, odd_term: '24-1008', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '47-150', phase_index: 0, even_term: '10-547', even_term_index: 18, odd_term: '55-254', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '16-923', phase_index: 0, even_term: '40-1132', even_term_index: 20, odd_term: '25-838', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '46-602', phase_index: 0, even_term: '11-378', even_term_index: 22, odd_term: '56-85', odd_term_index: 21 }
  ],
  752 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '16-302', phase_index: 0, even_term: '41-964', even_term_index: 0, odd_term: '26-671', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '45-1336', phase_index: 0, even_term: '12-209', even_term_index: 2, odd_term: '56-1256', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '15-944', phase_index: 0, even_term: '42-795', even_term_index: 4, odd_term: '27-502', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '45-442', phase_index: 0, even_term: '13-141', even_term_index: 6, odd_term: '57-1088', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '14-1193', phase_index: 0, even_term: '43-626', even_term_index: 8, odd_term: '28-333', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: true, remainder: '44-328', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '58-919', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '13-755', phase_index: 0, even_term: '13-1212', even_term_index: 10, odd_term: '29-165', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '42-1115', phase_index: 0, even_term: '44-458', even_term_index: 12, odd_term: '59-750', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '12-174', phase_index: 0, even_term: '14-1043', even_term_index: 14, odd_term: '29-1336', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '41-677', phase_index: 0, even_term: '45-289', even_term_index: 16, odd_term: '0-582', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '10-1251', phase_index: 0, even_term: '15-875', even_term_index: 18, odd_term: '30-1167', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '40-724', phase_index: 0, even_term: '46-120', even_term_index: 20, odd_term: '1-1113', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '10-309', phase_index: 0, even_term: '16-706', even_term_index: 22, odd_term: '31-899', odd_term_index: 23 }
  ],
  753 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '39-1327', phase_index: 0, even_term: '46-1292', even_term_index: 0, odd_term: '2-244', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '9-1059', phase_index: 0, even_term: '17-537', even_term_index: 2, odd_term: '32-830', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '39-723', phase_index: 0, even_term: '47-1123', even_term_index: 4, odd_term: '3-76', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '9-321', phase_index: 0, even_term: '18-369', even_term_index: 6, odd_term: '33-661', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '38-1030', phase_index: 0, even_term: '48-954', even_term_index: 8, odd_term: '3-1247', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '8-277', phase_index: 0, even_term: '19-200', even_term_index: 10, odd_term: '34-1193', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '37-765', phase_index: 0, even_term: '49-786', even_term_index: 12, odd_term: '4-1078', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '6-1158', phase_index: 0, even_term: '20-31', even_term_index: 14, odd_term: '35-324', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '36-193', phase_index: 0, even_term: '50-617', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 8, leaped: false, remainder: '5-613', phase_index: 0, even_term: '20-1203', even_term_index: 18, odd_term: '5-910', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '34-1175', phase_index: 0, even_term: '51-448', even_term_index: 20, odd_term: '36-155', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '4-592', phase_index: 0, even_term: '21-1034', even_term_index: 22, odd_term: '6-741', odd_term_index: 21 }
  ],
  754 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '34-93', phase_index: 0, even_term: '52-280', even_term_index: 0, odd_term: '36-1327', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '3-1054', phase_index: 0, even_term: '22-865', even_term_index: 2, odd_term: '7-572', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '33-732', phase_index: 0, even_term: '53-111', even_term_index: 4, odd_term: '37-1158', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '3-438', phase_index: 0, even_term: '23-697', even_term_index: 6, odd_term: '8-404', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '33-43', phase_index: 0, even_term: '53-1282', even_term_index: 8, odd_term: '38-989', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '2-802', phase_index: 0, even_term: '24-528', even_term_index: 10, odd_term: '9-235', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '32-140', phase_index: 0, even_term: '54-1114', even_term_index: 12, odd_term: '39-821', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '1-699', phase_index: 0, even_term: '25-359', even_term_index: 14, odd_term: '10-66', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '30-1176', phase_index: 0, even_term: '55-945', even_term_index: 16, odd_term: '40-652', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '0-253', phase_index: 0, even_term: '26-191', even_term_index: 18, odd_term: '10-1238', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '29-618', phase_index: 0, even_term: '56-776', even_term_index: 20, odd_term: '41-483', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '58-1220', phase_index: 0, even_term: '27-22', even_term_index: 22, odd_term: '11-1068', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: true, remainder: '28-539', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '42-315', odd_term_index: 23 }
  ],
  755 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '57-1314', phase_index: 0, even_term: '57-609', even_term_index: 0, odd_term: '12-900', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '27-839', phase_index: 0, even_term: '27-1193', even_term_index: 2, odd_term: '43-146', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '57-433', phase_index: 0, even_term: '58-439', even_term_index: 4, odd_term: '13-732', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '27-121', phase_index: 0, even_term: '28-1025', even_term_index: 6, odd_term: '43-1317', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '56-894', phase_index: 0, even_term: '59-270', even_term_index: 8, odd_term: '14-563', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '26-502', phase_index: 0, even_term: '29-856', even_term_index: 10, odd_term: '44-1149', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '55-1247', phase_index: 0, even_term: '0-102', even_term_index: 12, odd_term: '15-394', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '25-556', phase_index: 0, even_term: '30-687', even_term_index: 14, odd_term: '45-980', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '54-1136', phase_index: 0, even_term: '0-1273', even_term_index: 16, odd_term: '16-226', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '24-271', phase_index: 0, even_term: '31-519', even_term_index: 18, odd_term: '46-811', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '53-791', phase_index: 0, even_term: '1-1104', even_term_index: 20, odd_term: '17-57', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '22-1326', phase_index: 0, even_term: '32-350', even_term_index: 22, odd_term: '47-643', odd_term_index: 23 }
  ],
  756 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '52-581', phase_index: 0, even_term: '2-936', even_term_index: 0, odd_term: '17-1228', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '21-1278', phase_index: 0, even_term: '33-181', even_term_index: 2, odd_term: '48-474', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '51-696', phase_index: 0, even_term: '3-767', even_term_index: 4, odd_term: '18-1060', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '21-215', phase_index: 0, even_term: '34-13', even_term_index: 6, odd_term: '49-305', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '50-1049', phase_index: 0, even_term: '4-598', even_term_index: 8, odd_term: '19-891', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '20-570', phase_index: 0, even_term: '34-1184', even_term_index: 10, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 5, leaped: false, remainder: '50-115', phase_index: 0, even_term: '5-430', even_term_index: 12, odd_term: '50-137', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '19-928', phase_index: 0, even_term: '35-1015', even_term_index: 14, odd_term: '20-722', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '49-340', phase_index: 0, even_term: '6-261', even_term_index: 16, odd_term: '50-1308', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '18-1005', phase_index: 0, even_term: '36-847', even_term_index: 18, odd_term: '21-554', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '48-276', phase_index: 0, even_term: '7-92', even_term_index: 20, odd_term: '51-1139', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '17-922', phase_index: 0, even_term: '37-678', even_term_index: 22, odd_term: '22-385', odd_term_index: 21 }
  ],
  757 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '47-143', phase_index: 0, even_term: '7-1264', even_term_index: 0, odd_term: '52-971', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '16-705', phase_index: 0, even_term: '38-509', even_term_index: 2, odd_term: '23-216', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '45-1308', phase_index: 0, even_term: '8-1095', even_term_index: 4, odd_term: '53-802', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '15-639', phase_index: 0, even_term: '39-341', even_term_index: 6, odd_term: '24-48', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '45-27', phase_index: 0, even_term: '9-926', even_term_index: 8, odd_term: '54-633', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '14-716', phase_index: 0, even_term: '40-172', even_term_index: 10, odd_term: '24-1219', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '44-172', phase_index: 0, even_term: '10-758', even_term_index: 12, odd_term: '55-465', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '13-1013', phase_index: 0, even_term: '41-3', even_term_index: 14, odd_term: '25-1050', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '43-546', phase_index: 0, even_term: '11-589', even_term_index: 16, odd_term: '56-296', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '13-45', phase_index: 0, even_term: '41-1175', even_term_index: 18, odd_term: '26-882', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: true, remainder: '42-779', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '57-127', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '12-261', phase_index: 0, even_term: '12-420', even_term_index: 20, odd_term: '27-713', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '41-979', phase_index: 0, even_term: '42-1006', even_term_index: 22, odd_term: '57-1299', odd_term_index: 23 }
  ],
  758 => [
    { is_many_days: false, month: 11, leaped: false, remainder: '11-288', phase_index: 0, even_term: '13-252', even_term_index: 0, odd_term: '28-544', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '40-870', phase_index: 0, even_term: '43-837', even_term_index: 2, odd_term: '58-1130', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '10-63', phase_index: 0, even_term: '14-83', even_term_index: 4, odd_term: '29-376', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '39-677', phase_index: 0, even_term: '44-669', even_term_index: 6, odd_term: '59-961', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '8-1196', phase_index: 0, even_term: '14-1254', even_term_index: 8, odd_term: '30-207', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '38-473', phase_index: 0, even_term: '45-500', even_term_index: 10, odd_term: '0-793', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '7-1166', phase_index: 0, even_term: '15-1086', even_term_index: 12, odd_term: '31-38', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '37-599', phase_index: 0, even_term: '46-331', even_term_index: 14, odd_term: '1-624', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '7-127', phase_index: 0, even_term: '16-917', even_term_index: 16, odd_term: '31-1210', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '36-1006', phase_index: 0, even_term: '47-163', even_term_index: 18, odd_term: '2-455', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '6-586', phase_index: 0, even_term: '17-748', even_term_index: 20, odd_term: '32-1041', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '36-151', phase_index: 0, even_term: '47-1334', even_term_index: 22, odd_term: '3-287', odd_term_index: 23 }
  ],
  759 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '5-967', phase_index: 0, even_term: '18-580', even_term_index: 0, odd_term: '33-872', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '35-371', phase_index: 0, even_term: '48-1165', even_term_index: 2, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '4-1001', phase_index: 0, even_term: '19-411', even_term_index: 4, odd_term: '4-116', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '34-224', phase_index: 0, even_term: '49-997', even_term_index: 6, odd_term: '34-704', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '3-675', phase_index: 0, even_term: '20-242', even_term_index: 8, odd_term: '4-1289', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '32-1115', phase_index: 0, even_term: '50-828', even_term_index: 10, odd_term: '35-535', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '2-301', phase_index: 0, even_term: '21-74', even_term_index: 12, odd_term: '5-1121', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '31-894', phase_index: 0, even_term: '51-659', even_term_index: 14, odd_term: '36-366', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '1-257', phase_index: 0, even_term: '21-1245', even_term_index: 16, odd_term: '6-952', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '30-1061', phase_index: 0, even_term: '52-491', even_term_index: 18, odd_term: '37-198', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '0-608', phase_index: 0, even_term: '22-1076', even_term_index: 20, odd_term: '7-783', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '30-321', phase_index: 0, even_term: '53-322', even_term_index: 22, odd_term: '38-29', odd_term_index: 21 }
  ],
  760 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '59-1300', phase_index: 0, even_term: '23-908', even_term_index: 0, odd_term: '8-615', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '29-883', phase_index: 0, even_term: '54-153', even_term_index: 2, odd_term: '38-1200', odd_term_index: 1 },
    { is_many_days: false, month: 1, leaped: false, remainder: '59-361', phase_index: 0, even_term: '24-739', even_term_index: 4, odd_term: '9-446', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '28-1070', phase_index: 0, even_term: '54-1325', even_term_index: 6, odd_term: '39-1032', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '58-337', phase_index: 0, even_term: '25-570', even_term_index: 8, odd_term: '10-277', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '27-723', phase_index: 0, even_term: '55-1156', even_term_index: 10, odd_term: '40-863', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: true, remainder: '56-1110', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '11-109', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '26-201', phase_index: 0, even_term: '26-402', even_term_index: 12, odd_term: '41-694', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '55-714', phase_index: 0, even_term: '56-987', even_term_index: 14, odd_term: '11-1280', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '25-3', phase_index: 0, even_term: '27-233', even_term_index: 16, odd_term: '42-526', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '54-705', phase_index: 0, even_term: '57-819', even_term_index: 18, odd_term: '12-1111', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '24-312', phase_index: 0, even_term: '28-64', even_term_index: 20, odd_term: '43-357', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '53-1337', phase_index: 0, even_term: '58-650', even_term_index: 22, odd_term: '13-943', odd_term_index: 23 }
  ],
  761 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '23-1049', phase_index: 0, even_term: '28-1236', even_term_index: 0, odd_term: '44-188', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '53-711', phase_index: 0, even_term: '59-481', even_term_index: 2, odd_term: '14-774', odd_term_index: 3 },
    { is_many_days: false, month: 1, leaped: false, remainder: '23-260', phase_index: 0, even_term: '29-1067', even_term_index: 4, odd_term: '45-20', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '52-1074', phase_index: 0, even_term: '0-313', even_term_index: 6, odd_term: '15-605', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '22-301', phase_index: 0, even_term: '30-898', even_term_index: 8, odd_term: '45-1191', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '51-766', phase_index: 0, even_term: '1-144', even_term_index: 10, odd_term: '16-437', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '20-1153', phase_index: 0, even_term: '31-730', even_term_index: 12, odd_term: '46-1022', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '50-174', phase_index: 0, even_term: '1-1315', even_term_index: 14, odd_term: '17-268', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '19-625', phase_index: 0, even_term: '32-561', even_term_index: 16, odd_term: '47-854', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '48-1160', phase_index: 0, even_term: '2-1147', even_term_index: 18, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 9, leaped: false, remainder: '18-518', phase_index: 0, even_term: '33-392', even_term_index: 20, odd_term: '18-99', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '48-62', phase_index: 0, even_term: '3-978', even_term_index: 22, odd_term: '48-685', odd_term_index: 21 }
  ],
  762 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '17-1029', phase_index: 0, even_term: '34-224', even_term_index: 0, odd_term: '18-1271', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '47-748', phase_index: 0, even_term: '4-809', even_term_index: 2, odd_term: '49-516', odd_term_index: 1 },
    { is_many_days: true, month: 1, leaped: false, remainder: '17-451', phase_index: 0, even_term: '35-55', even_term_index: 4, odd_term: '19-1102', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '47-85', phase_index: 0, even_term: '5-641', even_term_index: 6, odd_term: '50-348', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '16-905', phase_index: 0, even_term: '35-1226', even_term_index: 8, odd_term: '20-933', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '46-197', phase_index: 0, even_term: '6-472', even_term_index: 10, odd_term: '51-179', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '15-743', phase_index: 0, even_term: '36-1058', even_term_index: 12, odd_term: '21-765', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '44-1178', phase_index: 0, even_term: '7-303', even_term_index: 14, odd_term: '52-10', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '14-221', phase_index: 0, even_term: '37-889', even_term_index: 16, odd_term: '22-596', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '43-612', phase_index: 0, even_term: '8-135', even_term_index: 18, odd_term: '52-1182', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '12-1065', phase_index: 0, even_term: '38-720', even_term_index: 20, odd_term: '23-427', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '42-441', phase_index: 0, even_term: '8-1306', even_term_index: 22, odd_term: '53-1013', odd_term_index: 21 }
  ],
  763 => [
    { is_many_days: true, month: 11, leaped: false, remainder: '11-1227', phase_index: 0, even_term: '39-552', even_term_index: 0, odd_term: '24-259', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '41-791', phase_index: 0, even_term: '9-1137', even_term_index: 2, odd_term: '54-844', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: true, remainder: '11-439', phase_index: 0, even_term: '40-383', even_term_index: 4, odd_term: '25-90', odd_term_index: 3 },
    { is_many_days: true, month: 1, leaped: false, remainder: '41-130', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '55-676', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '10-1168', phase_index: 0, even_term: '10-969', even_term_index: 6, odd_term: '25-1261', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '40-625', phase_index: 0, even_term: '41-214', even_term_index: 8, odd_term: '56-507', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '10-16', phase_index: 0, even_term: '11-800', even_term_index: 10, odd_term: '26-1093', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '39-633', phase_index: 0, even_term: '42-46', even_term_index: 12, odd_term: '57-338', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '8-1152', phase_index: 0, even_term: '12-631', even_term_index: 14, odd_term: '27-924', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '38-270', phase_index: 0, even_term: '42-1217', even_term_index: 16, odd_term: '58-170', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '7-650', phase_index: 0, even_term: '13-463', even_term_index: 18, odd_term: '28-755', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '36-1159', phase_index: 0, even_term: '43-1048', even_term_index: 20, odd_term: '59-1', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '6-435', phase_index: 0, even_term: '14-294', even_term_index: 22, odd_term: '29-587', odd_term_index: 23 }
  ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Gihou' do
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
              GIHOU_EXPECTED_MONTHS.each do |year, expects|
                actuals = \
                  Zakuro::Gihou::Range::AnnualRange.get(
                    context: Zakuro::Context.new(version_name: 'Gihou'),
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
            #   Zakuro::Gihou::Range::AnnualRange.get(
            #     context: Zakuro::Context.new(version_name: 'Gihou'),
            #     western_year: 700
            #   )
            # end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
