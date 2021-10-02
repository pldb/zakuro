# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/genka/range/annual_range',
                         __dir__)

# rubocop:disable Layout/LineLength
GENKA_EXPECTED_MONTHS = {
  445 => [
    { is_many_days: true, month: 1, leaped: false, remainder: '27.6157', phase_index: 0, even_term: '52.4836', even_term_index: 4, odd_term: '37.2649', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '57.1463', phase_index: 0, even_term: '22.9208', even_term_index: 6, odd_term: '7.7022', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '26.6769', phase_index: 0, even_term: '53.3580', even_term_index: 8, odd_term: '38.1394', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '56.2074', phase_index: 0, even_term: '23.7952', even_term_index: 10, odd_term: '8.5766', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '25.7380', phase_index: 0, even_term: '54.2325', even_term_index: 12, odd_term: '39.0138', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: true, remainder: '55.2686', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '9.4511', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '24.7992', phase_index: 0, even_term: '24.6697', even_term_index: 14, odd_term: '39.8883', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '54.3298', phase_index: 0, even_term: '55.1069', even_term_index: 16, odd_term: '10.3255', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '23.8604', phase_index: 0, even_term: '25.5441', even_term_index: 18, odd_term: '40.7627', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '53.3910', phase_index: 0, even_term: '55.9814', even_term_index: 20, odd_term: '11.2000', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '22.9215', phase_index: 0, even_term: '26.4186', even_term_index: 22, odd_term: '41.6372', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '52.4521', phase_index: 0, even_term: '56.8558', even_term_index: 0, odd_term: '12.0744', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '21.9827', phase_index: 0, even_term: '27.2930', even_term_index: 2, odd_term: '42.5117', odd_term_index: 3 }
  ],
  446 => [
    { is_many_days: true, month: 1, leaped: false, remainder: '51.5133', phase_index: 0, even_term: '57.7303', even_term_index: 4, odd_term: '12.9489', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '21.0439', phase_index: 0, even_term: '28.1675', even_term_index: 6, odd_term: '43.3861', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '50.5745', phase_index: 0, even_term: '58.6047', even_term_index: 8, odd_term: '13.8233', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '20.1051', phase_index: 0, even_term: '29.0419', even_term_index: 10, odd_term: '44.2606', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '49.6356', phase_index: 0, even_term: '59.4792', even_term_index: 12, odd_term: '14.6978', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '19.1662', phase_index: 0, even_term: '29.9164', even_term_index: 14, odd_term: '45.1350', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '48.6968', phase_index: 0, even_term: '0.3536', even_term_index: 16, odd_term: '15.5722', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '18.2274', phase_index: 0, even_term: '30.7908', even_term_index: 18, odd_term: '46.0095', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '47.7580', phase_index: 0, even_term: '1.2281', even_term_index: 20, odd_term: '16.4467', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '17.2886', phase_index: 0, even_term: '31.6653', even_term_index: 22, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 11, leaped: false, remainder: '46.8191', phase_index: 0, even_term: '2.1025', even_term_index: 0, odd_term: '46.8839', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '16.3497', phase_index: 0, even_term: '32.5397', even_term_index: 2, odd_term: '17.3211', odd_term_index: 1 }
  ],
  447 => [
    { is_many_days: true, month: 1, leaped: false, remainder: '45.8803', phase_index: 0, even_term: '2.9770', even_term_index: 4, odd_term: '47.7584', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '15.4109', phase_index: 0, even_term: '33.4142', even_term_index: 6, odd_term: '18.1956', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '44.9415', phase_index: 0, even_term: '3.8514', even_term_index: 8, odd_term: '48.6328', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '14.4721', phase_index: 0, even_term: '34.2887', even_term_index: 10, odd_term: '19.0700', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '44.0027', phase_index: 0, even_term: '4.7259', even_term_index: 12, odd_term: '49.5073', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '13.5332', phase_index: 0, even_term: '35.1631', even_term_index: 14, odd_term: '19.9445', odd_term_index: 13 },
    { is_many_days: false, month: 7, leaped: false, remainder: '43.0638', phase_index: 0, even_term: '5.6003', even_term_index: 16, odd_term: '50.3817', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '12.5944', phase_index: 0, even_term: '36.0376', even_term_index: 18, odd_term: '20.8189', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '42.1250', phase_index: 0, even_term: '6.4748', even_term_index: 20, odd_term: '51.2562', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '11.6556', phase_index: 0, even_term: '36.9120', even_term_index: 22, odd_term: '21.6934', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '41.1862', phase_index: 0, even_term: '7.3492', even_term_index: 0, odd_term: '52.1306', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '10.7168', phase_index: 0, even_term: '37.7865', even_term_index: 2, odd_term: '22.5678', odd_term_index: 1 }
  ],
  448 => [
    { is_many_days: false, month: 1, leaped: false, remainder: '40.2473', phase_index: 0, even_term: '8.2237', even_term_index: 4, odd_term: '53.0051', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '9.7779', phase_index: 0, even_term: '38.6609', even_term_index: 6, odd_term: '23.4423', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: true, remainder: '39.3085', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '53.8795', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '8.8391', phase_index: 0, even_term: '9.0981', even_term_index: 8, odd_term: '24.3167', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '38.3697', phase_index: 0, even_term: '39.5354', even_term_index: 10, odd_term: '54.7540', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '7.9003', phase_index: 0, even_term: '9.9726', even_term_index: 12, odd_term: '25.1912', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '37.4309', phase_index: 0, even_term: '40.4098', even_term_index: 14, odd_term: '55.6284', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '6.9614', phase_index: 0, even_term: '10.8470', even_term_index: 16, odd_term: '26.0657', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '36.4920', phase_index: 0, even_term: '41.2843', even_term_index: 18, odd_term: '56.5029', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '6.0226', phase_index: 0, even_term: '11.7215', even_term_index: 20, odd_term: '26.9401', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '35.5532', phase_index: 0, even_term: '42.1587', even_term_index: 22, odd_term: '57.3773', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '5.0838', phase_index: 0, even_term: '12.5959', even_term_index: 0, odd_term: '27.8146', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '34.6144', phase_index: 0, even_term: '43.0332', even_term_index: 2, odd_term: '58.2518', odd_term_index: 3 }
  ],
  449 => [
    { is_many_days: false, month: 1, leaped: false, remainder: '4.1449', phase_index: 0, even_term: '13.4704', even_term_index: 4, odd_term: '28.6890', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '33.6755', phase_index: 0, even_term: '43.9076', even_term_index: 6, odd_term: '59.1262', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '3.2061', phase_index: 0, even_term: '14.3448', even_term_index: 8, odd_term: '29.5635', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '32.7367', phase_index: 0, even_term: '44.7821', even_term_index: 10, odd_term: '0.0007', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '2.2673', phase_index: 0, even_term: '15.2193', even_term_index: 12, odd_term: '30.4379', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '31.7979', phase_index: 0, even_term: '45.6565', even_term_index: 14, odd_term: '0.8751', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '1.3285', phase_index: 0, even_term: '16.0938', even_term_index: 16, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 8, leaped: false, remainder: '30.8590', phase_index: 0, even_term: '46.5310', even_term_index: 18, odd_term: '31.3124', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '0.3896', phase_index: 0, even_term: '16.9682', even_term_index: 20, odd_term: '1.7496', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '29.9202', phase_index: 0, even_term: '47.4054', even_term_index: 22, odd_term: '32.1868', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '59.4508', phase_index: 0, even_term: '17.8427', even_term_index: 0, odd_term: '2.6240', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '28.9814', phase_index: 0, even_term: '48.2799', even_term_index: 2, odd_term: '33.0613', odd_term_index: 1 }
  ],
  450 => [
    { is_many_days: true, month: 1, leaped: false, remainder: '58.5120', phase_index: 0, even_term: '18.7171', even_term_index: 4, odd_term: '3.4985', odd_term_index: 3 },
    { is_many_days: false, month: 2, leaped: false, remainder: '28.0426', phase_index: 0, even_term: '49.1543', even_term_index: 6, odd_term: '33.9357', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '57.5731', phase_index: 0, even_term: '19.5916', even_term_index: 8, odd_term: '4.3729', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '27.1037', phase_index: 0, even_term: '50.0288', even_term_index: 10, odd_term: '34.8102', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '56.6343', phase_index: 0, even_term: '20.4660', even_term_index: 12, odd_term: '5.2474', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '26.1649', phase_index: 0, even_term: '50.9032', even_term_index: 14, odd_term: '35.6846', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '55.6955', phase_index: 0, even_term: '21.3405', even_term_index: 16, odd_term: '6.1218', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '25.2261', phase_index: 0, even_term: '51.7777', even_term_index: 18, odd_term: '36.5591', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '54.7566', phase_index: 0, even_term: '22.2149', even_term_index: 20, odd_term: '6.9963', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '24.2872', phase_index: 0, even_term: '52.6521', even_term_index: 22, odd_term: '37.4335', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: true, remainder: '53.8178', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '7.8708', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '23.3484', phase_index: 0, even_term: '23.0894', even_term_index: 0, odd_term: '38.3080', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '52.8790', phase_index: 0, even_term: '53.5266', even_term_index: 2, odd_term: '8.7452', odd_term_index: 3 }
  ],
  451 => [
    { is_many_days: false, month: 1, leaped: false, remainder: '22.4096', phase_index: 0, even_term: '23.9638', even_term_index: 4, odd_term: '39.1824', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '51.9402', phase_index: 0, even_term: '54.4010', even_term_index: 6, odd_term: '9.6197', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '21.4707', phase_index: 0, even_term: '24.8383', even_term_index: 8, odd_term: '40.0569', odd_term_index: 9 },
    { is_many_days: false, month: 4, leaped: false, remainder: '51.0013', phase_index: 0, even_term: '55.2755', even_term_index: 10, odd_term: '10.4941', odd_term_index: 11 },
    { is_many_days: true, month: 5, leaped: false, remainder: '20.5319', phase_index: 0, even_term: '25.7127', even_term_index: 12, odd_term: '40.9313', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: false, remainder: '50.0625', phase_index: 0, even_term: '56.1499', even_term_index: 14, odd_term: '11.3686', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '19.5931', phase_index: 0, even_term: '26.5872', even_term_index: 16, odd_term: '41.8058', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '49.1237', phase_index: 0, even_term: '57.0244', even_term_index: 18, odd_term: '12.2430', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '18.6543', phase_index: 0, even_term: '27.4616', even_term_index: 20, odd_term: '42.6802', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '48.1848', phase_index: 0, even_term: '57.8988', even_term_index: 22, odd_term: '13.1175', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '17.7154', phase_index: 0, even_term: '28.3361', even_term_index: 0, odd_term: '43.5547', odd_term_index: 1 },
    { is_many_days: false, month: 12, leaped: false, remainder: '47.2460', phase_index: 0, even_term: '58.7733', even_term_index: 2, odd_term: '13.9919', odd_term_index: 3 }
  ],
  452 => [
    { is_many_days: true, month: 1, leaped: false, remainder: '16.7766', phase_index: 0, even_term: '29.2105', even_term_index: 4, odd_term: '44.4291', odd_term_index: 5 },
    { is_many_days: false, month: 2, leaped: false, remainder: '46.3072', phase_index: 0, even_term: '59.6478', even_term_index: 6, odd_term: '14.8664', odd_term_index: 7 },
    { is_many_days: true, month: 3, leaped: false, remainder: '15.8378', phase_index: 0, even_term: '30.0850', even_term_index: 8, odd_term: '', odd_term_index: -1 },
    { is_many_days: false, month: 4, leaped: false, remainder: '45.3684', phase_index: 0, even_term: '0.5222', even_term_index: 10, odd_term: '45.3036', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '14.8989', phase_index: 0, even_term: '30.9594', even_term_index: 12, odd_term: '15.7408', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '44.4295', phase_index: 0, even_term: '1.3967', even_term_index: 14, odd_term: '46.1780', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '13.9601', phase_index: 0, even_term: '31.8339', even_term_index: 16, odd_term: '16.6153', odd_term_index: 15 },
    { is_many_days: true, month: 8, leaped: false, remainder: '43.4907', phase_index: 0, even_term: '2.2711', even_term_index: 18, odd_term: '47.0525', odd_term_index: 17 },
    { is_many_days: false, month: 9, leaped: false, remainder: '13.0213', phase_index: 0, even_term: '32.7083', even_term_index: 20, odd_term: '17.4897', odd_term_index: 19 },
    { is_many_days: true, month: 10, leaped: false, remainder: '42.5519', phase_index: 0, even_term: '3.1456', even_term_index: 22, odd_term: '47.9269', odd_term_index: 21 },
    { is_many_days: false, month: 11, leaped: false, remainder: '12.0824', phase_index: 0, even_term: '33.5828', even_term_index: 0, odd_term: '18.3642', odd_term_index: 23 },
    { is_many_days: true, month: 12, leaped: false, remainder: '41.6130', phase_index: 0, even_term: '4.0200', even_term_index: 2, odd_term: '48.8014', odd_term_index: 1 }
  ],
  453 => [
    { is_many_days: false, month: 1, leaped: false, remainder: '11.1436', phase_index: 0, even_term: '34.4572', even_term_index: 4, odd_term: '19.2386', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '40.6742', phase_index: 0, even_term: '4.8945', even_term_index: 6, odd_term: '49.6758', odd_term_index: 5 },
    { is_many_days: false, month: 3, leaped: false, remainder: '10.2048', phase_index: 0, even_term: '35.3317', even_term_index: 8, odd_term: '20.1131', odd_term_index: 7 },
    { is_many_days: true, month: 4, leaped: false, remainder: '39.7354', phase_index: 0, even_term: '5.7689', even_term_index: 10, odd_term: '50.5503', odd_term_index: 9 },
    { is_many_days: false, month: 5, leaped: false, remainder: '9.2660', phase_index: 0, even_term: '36.2061', even_term_index: 12, odd_term: '20.9875', odd_term_index: 11 },
    { is_many_days: true, month: 6, leaped: false, remainder: '38.7965', phase_index: 0, even_term: '6.6434', even_term_index: 14, odd_term: '51.4248', odd_term_index: 13 },
    { is_many_days: false, month: 6, leaped: true, remainder: '8.3271', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '21.8620', odd_term_index: 15 },
    { is_many_days: true, month: 7, leaped: false, remainder: '37.8577', phase_index: 0, even_term: '37.0806', even_term_index: 16, odd_term: '52.2992', odd_term_index: 17 },
    { is_many_days: false, month: 8, leaped: false, remainder: '7.3883', phase_index: 0, even_term: '7.5178', even_term_index: 18, odd_term: '22.7364', odd_term_index: 19 },
    { is_many_days: true, month: 9, leaped: false, remainder: '36.9189', phase_index: 0, even_term: '37.9550', even_term_index: 20, odd_term: '53.1737', odd_term_index: 21 },
    { is_many_days: false, month: 10, leaped: false, remainder: '6.4495', phase_index: 0, even_term: '8.3923', even_term_index: 22, odd_term: '23.6109', odd_term_index: 23 },
    { is_many_days: true, month: 11, leaped: false, remainder: '35.9801', phase_index: 0, even_term: '38.8295', even_term_index: 0, odd_term: '54.0481', odd_term_index: 1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '5.5106', phase_index: 0, even_term: '9.2667', even_term_index: 2, odd_term: '24.4853', odd_term_index: 3 }
  ],
  454 => [
    { is_many_days: false, month: 1, leaped: false, remainder: '35.0412', phase_index: 0, even_term: '39.7039', even_term_index: 4, odd_term: '54.9226', odd_term_index: 5 },
    { is_many_days: true, month: 2, leaped: false, remainder: '4.5718', phase_index: 0, even_term: '10.1412', even_term_index: 6, odd_term: '25.3598', odd_term_index: 7 },
    { is_many_days: false, month: 3, leaped: false, remainder: '34.1024', phase_index: 0, even_term: '40.5784', even_term_index: 8, odd_term: '55.7970', odd_term_index: 9 },
    { is_many_days: true, month: 4, leaped: false, remainder: '3.6330', phase_index: 0, even_term: '11.0156', even_term_index: 10, odd_term: '26.2342', odd_term_index: 11 },
    { is_many_days: false, month: 5, leaped: false, remainder: '33.1636', phase_index: 0, even_term: '41.4529', even_term_index: 12, odd_term: '56.6715', odd_term_index: 13 },
    { is_many_days: true, month: 6, leaped: false, remainder: '2.6941', phase_index: 0, even_term: '11.8901', even_term_index: 14, odd_term: '27.1087', odd_term_index: 15 },
    { is_many_days: false, month: 7, leaped: false, remainder: '32.2247', phase_index: 0, even_term: '42.3273', even_term_index: 16, odd_term: '57.5459', odd_term_index: 17 },
    { is_many_days: true, month: 8, leaped: false, remainder: '1.7553', phase_index: 0, even_term: '12.7645', even_term_index: 18, odd_term: '27.9831', odd_term_index: 19 },
    { is_many_days: false, month: 9, leaped: false, remainder: '31.2859', phase_index: 0, even_term: '43.2018', even_term_index: 20, odd_term: '58.4204', odd_term_index: 21 },
    { is_many_days: true, month: 10, leaped: false, remainder: '0.8165', phase_index: 0, even_term: '13.6390', even_term_index: 22, odd_term: '28.8576', odd_term_index: 23 },
    { is_many_days: false, month: 11, leaped: false, remainder: '30.3471', phase_index: 0, even_term: '44.0762', even_term_index: 0, odd_term: '', odd_term_index: -1 },
    { is_many_days: true, month: 12, leaped: false, remainder: '59.8777', phase_index: 0, even_term: '14.5134', even_term_index: 2, odd_term: '59.2948', odd_term_index: 1 }
  ],
  455 => [
    { is_many_days: false, month: 1, leaped: false, remainder: '29.4082', phase_index: 0, even_term: '44.9507', even_term_index: 4, odd_term: '29.7320', odd_term_index: 3 },
    { is_many_days: true, month: 2, leaped: false, remainder: '58.9388', phase_index: 0, even_term: '15.3879', even_term_index: 6, odd_term: '0.1693', odd_term_index: 5 },
    { is_many_days: true, month: 3, leaped: false, remainder: '28.4694', phase_index: 0, even_term: '45.8251', even_term_index: 8, odd_term: '30.6065', odd_term_index: 7 },
    { is_many_days: false, month: 4, leaped: false, remainder: '58.0000', phase_index: 0, even_term: '16.2623', even_term_index: 10, odd_term: '1.0437', odd_term_index: 9 },
    { is_many_days: true, month: 5, leaped: false, remainder: '27.5306', phase_index: 0, even_term: '46.6996', even_term_index: 12, odd_term: '31.4809', odd_term_index: 11 },
    { is_many_days: false, month: 6, leaped: false, remainder: '57.0612', phase_index: 0, even_term: '17.1368', even_term_index: 14, odd_term: '1.9182', odd_term_index: 13 },
    { is_many_days: true, month: 7, leaped: false, remainder: '26.5918', phase_index: 0, even_term: '47.5740', even_term_index: 16, odd_term: '32.3554', odd_term_index: 15 },
    { is_many_days: false, month: 8, leaped: false, remainder: '56.1223', phase_index: 0, even_term: '18.0112', even_term_index: 18, odd_term: '2.7926', odd_term_index: 17 },
    { is_many_days: true, month: 9, leaped: false, remainder: '25.6529', phase_index: 0, even_term: '48.4485', even_term_index: 20, odd_term: '33.2299', odd_term_index: 19 },
    { is_many_days: false, month: 10, leaped: false, remainder: '55.1835', phase_index: 0, even_term: '18.8857', even_term_index: 22, odd_term: '3.6671', odd_term_index: 21 },
    { is_many_days: true, month: 11, leaped: false, remainder: '24.7141', phase_index: 0, even_term: '49.3229', even_term_index: 0, odd_term: '34.1043', odd_term_index: 23 },
    { is_many_days: false, month: 12, leaped: false, remainder: '54.2447', phase_index: 0, even_term: '19.7601', even_term_index: 2, odd_term: '4.5415', odd_term_index: 1 }
  ],
  # 456 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '23.7753', phase_index: 0, even_term: '50.1974', even_term_index: 4, odd_term: '34.9788', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '53.3059', phase_index: 0, even_term: '20.6346', even_term_index: 6, odd_term: '5.4160', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '22.8364', phase_index: 0, even_term: '51.0718', even_term_index: 8, odd_term: '35.8532', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: true, remainder: '52.3670', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '6.2904', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '21.8976', phase_index: 0, even_term: '21.5090', even_term_index: 10, odd_term: '36.7277', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '51.4282', phase_index: 0, even_term: '51.9463', even_term_index: 12, odd_term: '7.1649', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '20.9588', phase_index: 0, even_term: '22.3835', even_term_index: 14, odd_term: '37.6021', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '50.4894', phase_index: 0, even_term: '52.8207', even_term_index: 16, odd_term: '8.0393', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '20.0199', phase_index: 0, even_term: '23.2579', even_term_index: 18, odd_term: '38.4766', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '49.5505', phase_index: 0, even_term: '53.6952', even_term_index: 20, odd_term: '8.9138', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '19.0811', phase_index: 0, even_term: '24.1324', even_term_index: 22, odd_term: '39.3510', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '48.6117', phase_index: 0, even_term: '54.5696', even_term_index: 0, odd_term: '9.7882', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '18.1423', phase_index: 0, even_term: '25.0069', even_term_index: 2, odd_term: '40.2255', odd_term_index: 3 }
  # ],
  # 457 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '47.6729', phase_index: 0, even_term: '55.4441', even_term_index: 4, odd_term: '10.6627', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '17.2035', phase_index: 0, even_term: '25.8813', even_term_index: 6, odd_term: '41.0999', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '46.7340', phase_index: 0, even_term: '56.3185', even_term_index: 8, odd_term: '11.5371', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '16.2646', phase_index: 0, even_term: '26.7558', even_term_index: 10, odd_term: '41.9744', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '45.7952', phase_index: 0, even_term: '57.1930', even_term_index: 12, odd_term: '12.4116', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '15.3258', phase_index: 0, even_term: '27.6302', even_term_index: 14, odd_term: '42.8488', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '44.8564', phase_index: 0, even_term: '58.0674', even_term_index: 16, odd_term: '13.2860', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '14.3870', phase_index: 0, even_term: '28.5047', even_term_index: 18, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '43.9176', phase_index: 0, even_term: '58.9419', even_term_index: 20, odd_term: '43.7233', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '13.4481', phase_index: 0, even_term: '29.3791', even_term_index: 22, odd_term: '14.1605', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '42.9787', phase_index: 0, even_term: '59.8163', even_term_index: 0, odd_term: '44.5977', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '12.5093', phase_index: 0, even_term: '30.2536', even_term_index: 2, odd_term: '15.0350', odd_term_index: 1 }
  # ],
  # 458 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '43.8324', phase_index: 0, even_term: '53.1579', even_term_index: 4, odd_term: '8.3765', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '13.3630', phase_index: 0, even_term: '23.5951', even_term_index: 6, odd_term: '38.8137', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '42.8936', phase_index: 0, even_term: '54.0323', even_term_index: 8, odd_term: '9.2510', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '12.4242', phase_index: 0, even_term: '24.4696', even_term_index: 10, odd_term: '39.6882', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '41.9548', phase_index: 0, even_term: '54.9068', even_term_index: 12, odd_term: '10.1254', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '11.4854', phase_index: 0, even_term: '25.3440', even_term_index: 14, odd_term: '40.5626', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '41.0160', phase_index: 0, even_term: '55.7813', even_term_index: 16, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '10.5465', phase_index: 0, even_term: '26.2185', even_term_index: 18, odd_term: '10.9999', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '40.0771', phase_index: 0, even_term: '56.6557', even_term_index: 20, odd_term: '41.4371', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '9.6077', phase_index: 0, even_term: '27.0929', even_term_index: 22, odd_term: '11.8743', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '39.1383', phase_index: 0, even_term: '57.5302', even_term_index: 0, odd_term: '42.3115', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '8.6689', phase_index: 0, even_term: '27.9674', even_term_index: 2, odd_term: '12.7488', odd_term_index: 1 }
  # ],
  # 459 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '5.9375', phase_index: 0, even_term: '5.9375', even_term_index: 4, odd_term: '21.1561', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '35.4681', phase_index: 0, even_term: '36.3747', even_term_index: 6, odd_term: '51.5933', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '4.9987', phase_index: 0, even_term: '6.8120', even_term_index: 8, odd_term: '22.0306', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '34.5293', phase_index: 0, even_term: '37.2492', even_term_index: 10, odd_term: '52.4678', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '4.0598', phase_index: 0, even_term: '7.6864', even_term_index: 12, odd_term: '22.9050', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '33.5904', phase_index: 0, even_term: '38.1236', even_term_index: 14, odd_term: '53.3422', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '3.1210', phase_index: 0, even_term: '8.5609', even_term_index: 16, odd_term: '23.7795', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '32.6516', phase_index: 0, even_term: '38.9981', even_term_index: 18, odd_term: '54.2167', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '2.1822', phase_index: 0, even_term: '9.4353', even_term_index: 20, odd_term: '24.6539', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '31.7128', phase_index: 0, even_term: '39.8725', even_term_index: 22, odd_term: '55.0911', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '1.2434', phase_index: 0, even_term: '10.3098', even_term_index: 0, odd_term: '25.5284', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '30.7739', phase_index: 0, even_term: '40.7470', even_term_index: 2, odd_term: '55.9656', odd_term_index: 3 }
  # ],
  # 460 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '0.3045', phase_index: 0, even_term: '11.1842', even_term_index: 4, odd_term: '26.4028', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '29.8351', phase_index: 0, even_term: '41.6214', even_term_index: 6, odd_term: '56.8400', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '59.3657', phase_index: 0, even_term: '12.0587', even_term_index: 8, odd_term: '27.2773', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '28.8963', phase_index: 0, even_term: '42.4959', even_term_index: 10, odd_term: '57.7145', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '58.4269', phase_index: 0, even_term: '12.9331', even_term_index: 12, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '27.9574', phase_index: 0, even_term: '43.3703', even_term_index: 14, odd_term: '28.1517', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '57.4880', phase_index: 0, even_term: '13.8076', even_term_index: 16, odd_term: '58.5890', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '27.0186', phase_index: 0, even_term: '44.2448', even_term_index: 18, odd_term: '29.0262', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '56.5492', phase_index: 0, even_term: '14.6820', even_term_index: 20, odd_term: '59.4634', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '26.0798', phase_index: 0, even_term: '45.1192', even_term_index: 22, odd_term: '29.9006', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '55.6104', phase_index: 0, even_term: '15.5565', even_term_index: 0, odd_term: '0.3379', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '25.1410', phase_index: 0, even_term: '45.9937', even_term_index: 2, odd_term: '30.7751', odd_term_index: 1 }
  # ],
  # 461 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '54.6715', phase_index: 0, even_term: '16.4309', even_term_index: 4, odd_term: '1.2123', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '24.2021', phase_index: 0, even_term: '46.8681', even_term_index: 6, odd_term: '31.6495', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '53.7327', phase_index: 0, even_term: '17.3054', even_term_index: 8, odd_term: '2.0868', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '23.2633', phase_index: 0, even_term: '47.7426', even_term_index: 10, odd_term: '32.5240', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '52.7939', phase_index: 0, even_term: '18.1798', even_term_index: 12, odd_term: '2.9612', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '22.3245', phase_index: 0, even_term: '48.6171', even_term_index: 14, odd_term: '33.3994', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '51.8551', phase_index: 0, even_term: '19.0543', even_term_index: 16, odd_term: '3.8357', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '21.3856', phase_index: 0, even_term: '49.4915', even_term_index: 18, odd_term: '34.2729', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '50.9162', phase_index: 0, even_term: '19.9287', even_term_index: 20, odd_term: '4.7101', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '20.4468', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '35.1473', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '49.9774', phase_index: 0, even_term: '50.3660', even_term_index: 22, odd_term: '5.5846', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '19.5080', phase_index: 0, even_term: '20.8032', even_term_index: 0, odd_term: '36.0218', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: true, remainder: '49.0386', phase_index: 0, even_term: '51.2404', even_term_index: 2, odd_term: '6.4590', odd_term_index: 3 }
  # ],
  # 462 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '18.5691', phase_index: 0, even_term: '21.6776', even_term_index: 4, odd_term: '36.8962', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '48.0997', phase_index: 0, even_term: '52.1149', even_term_index: 6, odd_term: '7.3335', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '17.6303', phase_index: 0, even_term: '22.5521', even_term_index: 8, odd_term: '37.7707', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '47.1609', phase_index: 0, even_term: '52.9893', even_term_index: 10, odd_term: '8.2079', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '16.6915', phase_index: 0, even_term: '23.4265', even_term_index: 12, odd_term: '38.6451', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '46.2221', phase_index: 0, even_term: '53.8638', even_term_index: 14, odd_term: '9.0824', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '15.7527', phase_index: 0, even_term: '24.3010', even_term_index: 16, odd_term: '39.5196', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '45.2832', phase_index: 0, even_term: '54.7382', even_term_index: 48, odd_term: '9.9568', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '14.8138', phase_index: 0, even_term: '25.1754', even_term_index: 20, odd_term: '40.3941', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '44.3444', phase_index: 0, even_term: '55.6127', even_term_index: 22, odd_term: '10.8313', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '13.8750', phase_index: 0, even_term: '26.0499', even_term_index: 0, odd_term: '41.2685', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '43.4056', phase_index: 0, even_term: '56.4871', even_term_index: 2, odd_term: '11.7057', odd_term_index: 3 }
  # ],
  # 463 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '12.9362', phase_index: 0, even_term: '26.9243', even_term_index: 4, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '42.4668', phase_index: 0, even_term: '57.3616', even_term_index: 6, odd_term: '42.1430', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '11.9973', phase_index: 0, even_term: '27.7988', even_term_index: 8, odd_term: '12.5802', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '41.5279', phase_index: 0, even_term: '58.2360', even_term_index: 10, odd_term: '43.0174', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '11.0585', phase_index: 0, even_term: '28.6732', even_term_index: 12, odd_term: '13.4546', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '40.5891', phase_index: 0, even_term: '59.1105', even_term_index: 14, odd_term: '43.8919', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '10.1197', phase_index: 0, even_term: '29.5477', even_term_index: 16, odd_term: '14.3291', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '39.6503', phase_index: 0, even_term: '59.9849', even_term_index: 18, odd_term: '44.7663', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '9.1809', phase_index: 0, even_term: '30.4221', even_term_index: 20, odd_term: '15.2035', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '38.7114', phase_index: 0, even_term: '0.8594', even_term_index: 22, odd_term: '45.6408', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '8.2420', phase_index: 0, even_term: '31.2966', even_term_index: 0, odd_term: '16.0780', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '37.7726', phase_index: 0, even_term: '1.7338', even_term_index: 2, odd_term: '46.5152', odd_term_index: 1 }
  # ],
  # 464 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '7.3032', phase_index: 0, even_term: '32.1711', even_term_index: 4, odd_term: '16.9524', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '36.8338', phase_index: 0, even_term: '2.6083', even_term_index: 6, odd_term: '47.3897', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '6.3644', phase_index: 0, even_term: '33.0455', even_term_index: 8, odd_term: '17.8269', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '35.8949', phase_index: 0, even_term: '3.4827', even_term_index: 10, odd_term: '48.2641', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '5.4255', phase_index: 0, even_term: '33.9200', even_term_index: 12, odd_term: '18.7013', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: true, remainder: '34.9561', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '49.1386', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '4.4867', phase_index: 0, even_term: '4.3572', even_term_index: 14, odd_term: '19.5758', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '34.0173', phase_index: 0, even_term: '34.7944', even_term_index: 16, odd_term: '50.0130', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '3.5479', phase_index: 0, even_term: '5.2316', even_term_index: 18, odd_term: '20.4502', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '33.0785', phase_index: 0, even_term: '35.6689', even_term_index: 20, odd_term: '50.8875', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '2.6090', phase_index: 0, even_term: '6.1061', even_term_index: 22, odd_term: '21.3247', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '32.1396', phase_index: 0, even_term: '36.5433', even_term_index: 0, odd_term: '51.7619', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '1.6702', phase_index: 0, even_term: '6.9805', even_term_index: 2, odd_term: '22.1992', odd_term_index: 3 }
  # ],
  # 465 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '31.2008', phase_index: 0, even_term: '37.4178', even_term_index: 4, odd_term: '52.6364', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '0.7314', phase_index: 0, even_term: '7.8550', even_term_index: 6, odd_term: '23.0736', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '30.2620', phase_index: 0, even_term: '38.2922', even_term_index: 8, odd_term: '53.5108', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '59.7926', phase_index: 0, even_term: '8.7294', even_term_index: 10, odd_term: '23.9481', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '29.3231', phase_index: 0, even_term: '39.1667', even_term_index: 12, odd_term: '54.3853', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '58.9537', phase_index: 0, even_term: '9.6039', even_term_index: 14, odd_term: '24.8225', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '28.3843', phase_index: 0, even_term: '40.0411', even_term_index: 16, odd_term: '55.2597', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '57.9149', phase_index: 0, even_term: '10.4783', even_term_index: 18, odd_term: '25.6970', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '27.4455', phase_index: 0, even_term: '40.9156', even_term_index: 20, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '56.9761', phase_index: 0, even_term: '11.3528', even_term_index: 22, odd_term: '56.1342', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '26.5066', phase_index: 0, even_term: '41.7900', even_term_index: 0, odd_term: '26.5714', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '56.0372', phase_index: 0, even_term: '12.2272', even_term_index: 2, odd_term: '57.0086', odd_term_index: 1 }
  # ],
  # 466 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '25.5678', phase_index: 0, even_term: '42.6645', even_term_index: 4, odd_term: '27.4459', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '55.0984', phase_index: 0, even_term: '13.1017', even_term_index: 6, odd_term: '57.8831', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '24.6290', phase_index: 0, even_term: '43.5389', even_term_index: 8, odd_term: '28.3203', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '54.1596', phase_index: 0, even_term: '13.9762', even_term_index: 10, odd_term: '58.7575', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '23.6902', phase_index: 0, even_term: '44.4134', even_term_index: 12, odd_term: '29.1948', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '53.2207', phase_index: 0, even_term: '14.8506', even_term_index: 14, odd_term: '59.6320', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '22.7513', phase_index: 0, even_term: '45.2878', even_term_index: 16, odd_term: '30.0692', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '52.2819', phase_index: 0, even_term: '15.7251', even_term_index: 18, odd_term: '0.5064', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '21.8125', phase_index: 0, even_term: '46.1623', even_term_index: 20, odd_term: '30.9437', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '51.3431', phase_index: 0, even_term: '16.5995', even_term_index: 22, odd_term: '1.3808', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '20.8737', phase_index: 0, even_term: '47.0367', even_term_index: 0, odd_term: '31.8181', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '50.4043', phase_index: 0, even_term: '17.4740', even_term_index: 2, odd_term: '2.2553', odd_term_index: 1 }
  # ],
  # 467 => [
  #   { is_many_days: false, month: 1, leaped: true, remainder: '49.4654', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '3.1298', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '18.9960', phase_index: 0, even_term: '18.3484', even_term_index: 6, odd_term: '33.5670', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '48.5266', phase_index: 0, even_term: '48.7856', even_term_index: 8, odd_term: '4.0042', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '18.0572', phase_index: 0, even_term: '19.2229', even_term_index: 10, odd_term: '34.4415', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '47.5878', phase_index: 0, even_term: '49.6601', even_term_index: 12, odd_term: '4.8787', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '17.1184', phase_index: 0, even_term: '20.0973', even_term_index: 14, odd_term: '35.3159', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '46.6489', phase_index: 0, even_term: '50.5345', even_term_index: 16, odd_term: '5.7532', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '16.1795', phase_index: 0, even_term: '20.9718', even_term_index: 18, odd_term: '36.1804', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '45.7101', phase_index: 0, even_term: '51.4090', even_term_index: 20, odd_term: '6.6276', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '15.2407', phase_index: 0, even_term: '21.8462', even_term_index: 22, odd_term: '37.0648', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '44.7713', phase_index: 0, even_term: '52.2834', even_term_index: 0, odd_term: '7.5021', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '14.3019', phase_index: 0, even_term: '22.7207', even_term_index: 2, odd_term: '37.9393', odd_term_index: 3 }
  # ],
  # 469 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '38.1995', phase_index: 0, even_term: '58.4046', even_term_index: 4, odd_term: '43.1860', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '7.7301', phase_index: 0, even_term: '28.8418', even_term_index: 6, odd_term: '13.6232', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '37.2606', phase_index: 0, even_term: '59.2791', even_term_index: 8, odd_term: '44.0604', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '6.7912', phase_index: 0, even_term: '29.7163', even_term_index: 10, odd_term: '14.4977', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '36.3218', phase_index: 0, even_term: '0.1535', even_term_index: 12, odd_term: '44.9349', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '5.8524', phase_index: 0, even_term: '30.5907', even_term_index: 14, odd_term: '15.3721', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '35.3830', phase_index: 0, even_term: '1.0280', even_term_index: 16, odd_term: '45.8093', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '4.9136', phase_index: 0, even_term: '31.4652', even_term_index: 18, odd_term: '16.2466', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '34.4441', phase_index: 0, even_term: '1.9024', even_term_index: 20, odd_term: '46.6638', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '3.9747', phase_index: 0, even_term: '32.3396', even_term_index: 22, odd_term: '17.1210', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '33.5053', phase_index: 0, even_term: '2.7769', even_term_index: 0, odd_term: '47.5583', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: true, remainder: '3.0359', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '17.9955', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '32.5665', phase_index: 0, even_term: '33.2141', even_term_index: 2, odd_term: '48.4327', odd_term_index: 3 }
  # ],
  # 470 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '2.0971', phase_index: 0, even_term: '3.6513', even_term_index: 4, odd_term: '18.8699', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '31.6277', phase_index: 0, even_term: '34.0885', even_term_index: 6, odd_term: '49.3072', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '1.1582', phase_index: 0, even_term: '4.5258', even_term_index: 8, odd_term: '19.7444', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '30.6888', phase_index: 0, even_term: '34.9630', even_term_index: 10, odd_term: '50.1616', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '0.2194', phase_index: 0, even_term: '5.4002', even_term_index: 12, odd_term: '20.6188', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '29.7500', phase_index: 0, even_term: '35.8374', even_term_index: 14, odd_term: '51.0561', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '59.2806', phase_index: 0, even_term: '6.2747', even_term_index: 16, odd_term: '21.4933', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '28.8112', phase_index: 0, even_term: '36.7119', even_term_index: 18, odd_term: '51.9305', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '58.3418', phase_index: 0, even_term: '7.1491', even_term_index: 20, odd_term: '22.3677', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '27.8723', phase_index: 0, even_term: '37.5863', even_term_index: 22, odd_term: '52.8050', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '57.4029', phase_index: 0, even_term: '8.0236', even_term_index: 0, odd_term: '23.2422', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '26.9335', phase_index: 0, even_term: '38.4608', even_term_index: 2, odd_term: '53.6794', odd_term_index: 3 }
  # ],
  # 471 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '56.4641', phase_index: 0, even_term: '8.8980', even_term_index: 4, odd_term: '24.1166', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '25.9947', phase_index: 0, even_term: '39.3353', even_term_index: 6, odd_term: '54.5539', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '55.5253', phase_index: 0, even_term: '9.7725', even_term_index: 8, odd_term: '24.9911', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '25.0559', phase_index: 0, even_term: '40.2097', even_term_index: 10, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '54.5864', phase_index: 0, even_term: '10.6469', even_term_index: 12, odd_term: '55.4283', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '24.1170', phase_index: 0, even_term: '41.0842', even_term_index: 14, odd_term: '25.8655', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '53.6476', phase_index: 0, even_term: '11.5214', even_term_index: 16, odd_term: '56.3028', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '23.1782', phase_index: 0, even_term: '41.9586', even_term_index: 18, odd_term: '26.7400', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '52.7088', phase_index: 0, even_term: '12.3958', even_term_index: 20, odd_term: '57.1772', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '22.2394', phase_index: 0, even_term: '42.8331', even_term_index: 22, odd_term: '27.6144', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '51.7699', phase_index: 0, even_term: '13.2703', even_term_index: 0, odd_term: '58.0517', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '21.3005', phase_index: 0, even_term: '43.7075', even_term_index: 2, odd_term: '28.4889', odd_term_index: 1 }
  # ],
  # 472 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '50.8311', phase_index: 0, even_term: '14.1447', even_term_index: 4, odd_term: '58.9261', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '20.3617', phase_index: 0, even_term: '44.5820', even_term_index: 6, odd_term: '29.3633', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '49.8923', phase_index: 0, even_term: '15.0192', even_term_index: 8, odd_term: '59.8006', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '19.4229', phase_index: 0, even_term: '45.4564', even_term_index: 10, odd_term: '30.2378', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '48.9535', phase_index: 0, even_term: '15.8936', even_term_index: 12, odd_term: '0.6750', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '18.4840', phase_index: 0, even_term: '46.3309', even_term_index: 14, odd_term: '31.1123', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '48.0146', phase_index: 0, even_term: '16.7681', even_term_index: 16, odd_term: '1.5495', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: true, remainder: '17.5452', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '31.9867', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '47.0758', phase_index: 0, even_term: '47.2053', even_term_index: 18, odd_term: '2.4239', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '16.6064', phase_index: 0, even_term: '17.6425', even_term_index: 20, odd_term: '32.8612', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '46.1370', phase_index: 0, even_term: '48.0798', even_term_index: 22, odd_term: '3.2984', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '15.6676', phase_index: 0, even_term: '18.5170', even_term_index: 0, odd_term: '33.7356', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '45.1981', phase_index: 0, even_term: '48.9542', even_term_index: 2, odd_term: '4.1728', odd_term_index: 3 }
  # ],
  # 473 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '14.7287', phase_index: 0, even_term: '19.3914', even_term_index: 4, odd_term: '34.6101', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '44.2593', phase_index: 0, even_term: '49.8287', even_term_index: 6, odd_term: '5.0473', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '13.7899', phase_index: 0, even_term: '20.2659', even_term_index: 8, odd_term: '35.4845', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '43.3205', phase_index: 0, even_term: '50.7031', even_term_index: 10, odd_term: '5.9217', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '12.5511', phase_index: 0, even_term: '21.1404', even_term_index: 12, odd_term: '36.3590', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '42.3816', phase_index: 0, even_term: '51.5776', even_term_index: 14, odd_term: '6.7962', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '11.9122', phase_index: 0, even_term: '22.0148', even_term_index: 16, odd_term: '37.2334', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '41.4428', phase_index: 0, even_term: '52.4520', even_term_index: 18, odd_term: '7.6706', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '10.9734', phase_index: 0, even_term: '22.8883', even_term_index: 20, odd_term: '38.1079', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '40.5040', phase_index: 0, even_term: '53.3265', even_term_index: 22, odd_term: '8.5451', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '10.0346', phase_index: 0, even_term: '23.7637', even_term_index: 0, odd_term: '38.9823', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '39.5652', phase_index: 0, even_term: '54.2009', even_term_index: 2, odd_term: '', odd_term_index: -1 }
  # ],
  # 474 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '9.0957', phase_index: 0, even_term: '24.6382', even_term_index: 4, odd_term: '9.4195', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '38.6263', phase_index: 0, even_term: '55.0754', even_term_index: 6, odd_term: '39.8568', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '8.1569', phase_index: 0, even_term: '25.5126', even_term_index: 8, odd_term: '10.2940', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '37.6875', phase_index: 0, even_term: '55.9498', even_term_index: 10, odd_term: '40.7312', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '7.2181', phase_index: 0, even_term: '26.3871', even_term_index: 12, odd_term: '11.1684', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '36.7487', phase_index: 0, even_term: '56.8243', even_term_index: 14, odd_term: '41.6057', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '6.2793', phase_index: 0, even_term: '27.2615', even_term_index: 16, odd_term: '12.0429', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '35.8098', phase_index: 0, even_term: '57.6987', even_term_index: 18, odd_term: '42.4801', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '5.3404', phase_index: 0, even_term: '28.1360', even_term_index: 20, odd_term: '12.9174', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '34.8710', phase_index: 0, even_term: '58.5732', even_term_index: 22, odd_term: '43.3546', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '4.4016', phase_index: 0, even_term: '29.0104', even_term_index: 0, odd_term: '13.7918', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '33.9322', phase_index: 0, even_term: '59.4476', even_term_index: 2, odd_term: '44.2290', odd_term_index: 1 }
  # ],
  # 475 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '3.4628', phase_index: 0, even_term: '29.8849', even_term_index: 4, odd_term: '14.6663', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '32.9934', phase_index: 0, even_term: '0.3221', even_term_index: 6, odd_term: '45.1035', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '2.5239', phase_index: 0, even_term: '30.7593', even_term_index: 8, odd_term: '15.5407', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: true, remainder: '32.0545', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '45.9779', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '1.5851', phase_index: 0, even_term: '1.1965', even_term_index: 10, odd_term: '16.4152', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '31.1157', phase_index: 0, even_term: '31.6338', even_term_index: 12, odd_term: '46.8524', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '0.6463', phase_index: 0, even_term: '2.0710', even_term_index: 14, odd_term: '17.2896', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '30.1769', phase_index: 0, even_term: '32.5082', even_term_index: 16, odd_term: '47.7268', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '59.7074', phase_index: 0, even_term: '2.9454', even_term_index: 18, odd_term: '18.1641', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '29.2380', phase_index: 0, even_term: '33.3827', even_term_index: 20, odd_term: '48.6013', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '58.7686', phase_index: 0, even_term: '3.8199', even_term_index: 22, odd_term: '19.0385', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '28.2992', phase_index: 0, even_term: '34.2571', even_term_index: 0, odd_term: '49.4757', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '57.8298', phase_index: 0, even_term: '4.6944', even_term_index: 2, odd_term: '19.9130', odd_term_index: 3 }
  # ],
  # 476 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '27.3604', phase_index: 0, even_term: '35.1316', even_term_index: 4, odd_term: '50.3502', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '56.8910', phase_index: 0, even_term: '5.5688', even_term_index: 6, odd_term: '20.7874', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '26.4215', phase_index: 0, even_term: '36.0060', even_term_index: 8, odd_term: '51.2246', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '55.9521', phase_index: 0, even_term: '6.4433', even_term_index: 10, odd_term: '21.6619', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '25.4827', phase_index: 0, even_term: '36.8805', even_term_index: 12, odd_term: '52.0991', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '55.0133', phase_index: 0, even_term: '7.3177', even_term_index: 14, odd_term: '22.5363', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '24.5439', phase_index: 0, even_term: '37.7549', even_term_index: 16, odd_term: '52.9735', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '54.0745', phase_index: 0, even_term: '8.1922', even_term_index: 18, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '23.6051', phase_index: 0, even_term: '38.6294', even_term_index: 20, odd_term: '23.4108', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '53.1356', phase_index: 0, even_term: '9.0666', even_term_index: 22, odd_term: '53.8480', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '22.6662', phase_index: 0, even_term: '39.5038', even_term_index: 0, odd_term: '24.2852', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '52.1968', phase_index: 0, even_term: '9.9411', even_term_index: 2, odd_term: '54.7225', odd_term_index: 1 }
  # ],
  # 477 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '21.7274', phase_index: 0, even_term: '40.3783', even_term_index: 4, odd_term: '25.1597', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '51.2580', phase_index: 0, even_term: '10.8155', even_term_index: 6, odd_term: '55.5969', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '20.7886', phase_index: 0, even_term: '41.2527', even_term_index: 8, odd_term: '26.0341', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '50.3191', phase_index: 0, even_term: '11.6900', even_term_index: 10, odd_term: '56.4714', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '19.8497', phase_index: 0, even_term: '42.1272', even_term_index: 12, odd_term: '26.9086', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '49.3803', phase_index: 0, even_term: '12.5644', even_term_index: 14, odd_term: '57.3458', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '18.9109', phase_index: 0, even_term: '43.0016', even_term_index: 16, odd_term: '27.7830', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '48.4415', phase_index: 0, even_term: '13.4389', even_term_index: 18, odd_term: '58.2203', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '17.9721', phase_index: 0, even_term: '43.8761', even_term_index: 20, odd_term: '28.6575', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '47.5027', phase_index: 0, even_term: '14.3133', even_term_index: 22, odd_term: '59.0947', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '17.0332', phase_index: 0, even_term: '44.7505', even_term_index: 0, odd_term: '29.5319', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '46.5638', phase_index: 0, even_term: '15.1878', even_term_index: 2, odd_term: '59.9692', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: true, remainder: '16.0944', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '30.4064', odd_term_index: 3 }
  # ],
  # 478 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '45.6250', phase_index: 0, even_term: '45.6250', even_term_index: 4, odd_term: '0.8436', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '15.1556', phase_index: 0, even_term: '16.0622', even_term_index: 6, odd_term: '31.2808', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '44.6862', phase_index: 0, even_term: '46.4995', even_term_index: 8, odd_term: '1.7181', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '14.2168', phase_index: 0, even_term: '16.9367', even_term_index: 10, odd_term: '32.1553', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '43.7473', phase_index: 0, even_term: '47.3739', even_term_index: 12, odd_term: '2.5925', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '13.2779', phase_index: 0, even_term: '17.8111', even_term_index: 14, odd_term: '33.0297', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '42.8085', phase_index: 0, even_term: '48.2484', even_term_index: 16, odd_term: '3.4670', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '12.3391', phase_index: 0, even_term: '18.6856', even_term_index: 18, odd_term: '33.9042', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '41.8697', phase_index: 0, even_term: '49.1228', even_term_index: 20, odd_term: '4.3414', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '11.4003', phase_index: 0, even_term: '19.5600', even_term_index: 22, odd_term: '34.7786', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '40.9309', phase_index: 0, even_term: '49.9973', even_term_index: 0, odd_term: '5.2159', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '10.4614', phase_index: 0, even_term: '20.4345', even_term_index: 2, odd_term: '35.6531', odd_term_index: 3 }
  # ],
  # 479 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '39.9920', phase_index: 0, even_term: '50.8717', even_term_index: 4, odd_term: '6.0903', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '9.5226', phase_index: 0, even_term: '21.3089', even_term_index: 6, odd_term: '36.5275', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '39.0532', phase_index: 0, even_term: '51.7462', even_term_index: 8, odd_term: '6.9648', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '8.5838', phase_index: 0, even_term: '22.1834', even_term_index: 10, odd_term: '37.4020', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '38.1144', phase_index: 0, even_term: '52.6206', even_term_index: 12, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '7.6449', phase_index: 0, even_term: '23.0578', even_term_index: 14, odd_term: '7.8392', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '37.1755', phase_index: 0, even_term: '53.4951', even_term_index: 16, odd_term: '38.2765', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '6.7061', phase_index: 0, even_term: '23.9323', even_term_index: 18, odd_term: '8.7137', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '36.2367', phase_index: 0, even_term: '54.3685', even_term_index: 20, odd_term: '39.1509', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '5.7673', phase_index: 0, even_term: '24.8067', even_term_index: 22, odd_term: '9.5881', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '35.2979', phase_index: 0, even_term: '55.2440', even_term_index: 0, odd_term: '40.0254', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '4.8285', phase_index: 0, even_term: '25.6812', even_term_index: 2, odd_term: '10.4626', odd_term_index: 1 }
  # ],
  # 480 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '34.3590', phase_index: 0, even_term: '56.1184', even_term_index: 4, odd_term: '40.8998', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '3.8896', phase_index: 0, even_term: '26.5556', even_term_index: 6, odd_term: '11.3370', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '33.4202', phase_index: 0, even_term: '56.9929', even_term_index: 8, odd_term: '41.7743', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '2.9508', phase_index: 0, even_term: '27.4301', even_term_index: 10, odd_term: '12.2115', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '32.4814', phase_index: 0, even_term: '57.8673', even_term_index: 12, odd_term: '42.6487', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '2.0120', phase_index: 0, even_term: '28.3046', even_term_index: 14, odd_term: '13.0859', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '31.5426', phase_index: 0, even_term: '58.7418', even_term_index: 16, odd_term: '43.5232', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '1.0731', phase_index: 0, even_term: '29.1790', even_term_index: 18, odd_term: '13.9604', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '30.6037', phase_index: 0, even_term: '59.6162', even_term_index: 20, odd_term: '44.3976', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: true, remainder: '0.1343', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '14.8348', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '29.6649', phase_index: 0, even_term: '30.0535', even_term_index: 22, odd_term: '45.2721', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '59.1855', phase_index: 0, even_term: '0.4907', even_term_index: 0, odd_term: '15.7093', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '28.7261', phase_index: 0, even_term: '30.9279', even_term_index: 2, odd_term: '46.1465', odd_term_index: 3 }
  # ],
  # 481 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '58.2566', phase_index: 0, even_term: '1.3651', even_term_index: 4, odd_term: '16.5837', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '27.7872', phase_index: 0, even_term: '31.8024', even_term_index: 6, odd_term: '47.0210', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '57.3178', phase_index: 0, even_term: '2.2396', even_term_index: 8, odd_term: '17.4582', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '26.8484', phase_index: 0, even_term: '32.6768', even_term_index: 10, odd_term: '47.8954', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '56.3790', phase_index: 0, even_term: '3.1140', even_term_index: 12, odd_term: '18.3326', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '25.9096', phase_index: 0, even_term: '33.5513', even_term_index: 14, odd_term: '48.7699', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '55.4402', phase_index: 0, even_term: '3.9885', even_term_index: 16, odd_term: '19.2071', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '24.9707', phase_index: 0, even_term: '34.4257', even_term_index: 18, odd_term: '49.6443', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '54.5013', phase_index: 0, even_term: '4.8629', even_term_index: 20, odd_term: '20.0816', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '24.0319', phase_index: 0, even_term: '35.3002', even_term_index: 22, odd_term: '50.5188', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '53.5625', phase_index: 0, even_term: '5.7374', even_term_index: 0, odd_term: '20.9560', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '23.0931', phase_index: 0, even_term: '36.1746', even_term_index: 2, odd_term: '51.3932', odd_term_index: 3 }
  # ],
  # 482 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '52.6237', phase_index: 0, even_term: '6.6118', even_term_index: 4, odd_term: '21.8305', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '22.1543', phase_index: 0, even_term: '37.0491', even_term_index: 6, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '51.6848', phase_index: 0, even_term: '7.4863', even_term_index: 8, odd_term: '52.2677', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '21.2154', phase_index: 0, even_term: '37.9235', even_term_index: 10, odd_term: '22.7049', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '50.7460', phase_index: 0, even_term: '8.3607', even_term_index: 12, odd_term: '53.1421', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '20.2766', phase_index: 0, even_term: '38.7980', even_term_index: 14, odd_term: '23.5794', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '49.8072', phase_index: 0, even_term: '9.2352', even_term_index: 16, odd_term: '54.0166', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '19.3378', phase_index: 0, even_term: '39.6724', even_term_index: 18, odd_term: '24.4538', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '48.8684', phase_index: 0, even_term: '10.1096', even_term_index: 20, odd_term: '54.8910', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '18.3989', phase_index: 0, even_term: '40.5469', even_term_index: 22, odd_term: '25.3283', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '47.9295', phase_index: 0, even_term: '10.9841', even_term_index: 0, odd_term: '55.7655', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '17.4601', phase_index: 0, even_term: '41.4213', even_term_index: 2, odd_term: '26.2027', odd_term_index: 1 }
  # ],
  # 483 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '46.9907', phase_index: 0, even_term: '11.8586', even_term_index: 4, odd_term: '56.6399', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '16.5213', phase_index: 0, even_term: '42.2958', even_term_index: 6, odd_term: '27.0772', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '46.0519', phase_index: 0, even_term: '12.7330', even_term_index: 8, odd_term: '57.5144', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '15.5824', phase_index: 0, even_term: '43.1702', even_term_index: 10, odd_term: '27.9516', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '45.1130', phase_index: 0, even_term: '13.6075', even_term_index: 12, odd_term: '58.3888', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: true, remainder: '14.6436', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '28.8261', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '44.1742', phase_index: 0, even_term: '44.0447', even_term_index: 14, odd_term: '59.2633', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '13.7048', phase_index: 0, even_term: '14.4819', even_term_index: 16, odd_term: '29.7005', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '43.2354', phase_index: 0, even_term: '44.9191', even_term_index: 18, odd_term: '0.1377', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '12.7660', phase_index: 0, even_term: '15.3564', even_term_index: 20, odd_term: '30.5750', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '42.2965', phase_index: 0, even_term: '45.7936', even_term_index: 22, odd_term: '1.0122', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '11.8271', phase_index: 0, even_term: '16.2308', even_term_index: 0, odd_term: '31.4494', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '41.3577', phase_index: 0, even_term: '46.6680', even_term_index: 2, odd_term: '1.8867', odd_term_index: 3 }
  # ],
  # 484 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '10.8883', phase_index: 0, even_term: '17.1053', even_term_index: 4, odd_term: '32.3239', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '40.4189', phase_index: 0, even_term: '47.5425', even_term_index: 6, odd_term: '2.7611', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '9.9495', phase_index: 0, even_term: '17.9797', even_term_index: 8, odd_term: '33.1983', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '39.4801', phase_index: 0, even_term: '48.4169', even_term_index: 10, odd_term: '3.6356', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '9.0106', phase_index: 0, even_term: '18.8542', even_term_index: 12, odd_term: '34.0728', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '38.5412', phase_index: 0, even_term: '49.2914', even_term_index: 14, odd_term: '4.5100', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '8.0718', phase_index: 0, even_term: '19.7286', even_term_index: 16, odd_term: '34.9472', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '37.6024', phase_index: 0, even_term: '50.1658', even_term_index: 18, odd_term: '5.3845', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '7.1330', phase_index: 0, even_term: '20.6031', even_term_index: 20, odd_term: '35.8217', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '36.6636', phase_index: 0, even_term: '51.0403', even_term_index: 22, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '6.1941', phase_index: 0, even_term: '21.4775', even_term_index: 0, odd_term: '6.2589', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '35.7247', phase_index: 0, even_term: '51.9147', even_term_index: 2, odd_term: '36.6961', odd_term_index: 1 }
  # ],
  # 485 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '5.2553', phase_index: 0, even_term: '22.3520', even_term_index: 4, odd_term: '7.1334', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '34.7859', phase_index: 0, even_term: '52.7892', even_term_index: 6, odd_term: '37.5706', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '4.3165', phase_index: 0, even_term: '23.2264', even_term_index: 8, odd_term: '8.0078', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '33.8471', phase_index: 0, even_term: '53.6637', even_term_index: 10, odd_term: '38.4450', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '3.3777', phase_index: 0, even_term: '24.1009', even_term_index: 12, odd_term: '8.8823', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '32.9082', phase_index: 0, even_term: '54.5381', even_term_index: 14, odd_term: '39.3195', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '2.4388', phase_index: 0, even_term: '24.9753', even_term_index: 16, odd_term: '9.7567', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '31.9694', phase_index: 0, even_term: '55.4126', even_term_index: 18, odd_term: '40.1939', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '1.5000', phase_index: 0, even_term: '25.8498', even_term_index: 20, odd_term: '10.6312', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '31.0306', phase_index: 0, even_term: '56.2870', even_term_index: 22, odd_term: '41.0684', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '0.5612', phase_index: 0, even_term: '26.7242', even_term_index: 0, odd_term: '11.5056', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '30.0918', phase_index: 0, even_term: '57.1615', even_term_index: 2, odd_term: '41.9428', odd_term_index: 1 }
  # ],
  # 486 => [
  #   { is_many_days: false, month: 1, leaped: true, remainder: '29.1529', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '42.8173', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '58.6835', phase_index: 0, even_term: '58.0359', even_term_index: 6, odd_term: '13.2545', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '28.2141', phase_index: 0, even_term: '28.4731', even_term_index: 8, odd_term: '43.6917', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '57.7447', phase_index: 0, even_term: '58.9104', even_term_index: 10, odd_term: '14.1290', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '27.2753', phase_index: 0, even_term: '29.3476', even_term_index: 12, odd_term: '44.5662', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '56.8059', phase_index: 0, even_term: '59.7848', even_term_index: 14, odd_term: '15.0034', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '26.3364', phase_index: 0, even_term: '30.2220', even_term_index: 16, odd_term: '45.4407', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '55.8670', phase_index: 0, even_term: '0.6593', even_term_index: 18, odd_term: '15.8779', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '25.3976', phase_index: 0, even_term: '31.0965', even_term_index: 20, odd_term: '46.3151', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '54.9282', phase_index: 0, even_term: '1.5337', even_term_index: 22, odd_term: '16.7523', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '24.4588', phase_index: 0, even_term: '31.9709', even_term_index: 0, odd_term: '47.1896', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '53.9894', phase_index: 0, even_term: '2.4082', even_term_index: 2, odd_term: '17.6268', odd_term_index: 3 }
  # ],
  # 487 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '23.5199', phase_index: 0, even_term: '32.8454', even_term_index: 4, odd_term: '48.0640', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '53.0505', phase_index: 0, even_term: '3.2826', even_term_index: 6, odd_term: '18.5012', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '22.5811', phase_index: 0, even_term: '33.7198', even_term_index: 8, odd_term: '48.9385', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '52.1117', phase_index: 0, even_term: '4.1571', even_term_index: 10, odd_term: '19.3757', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '21.6423', phase_index: 0, even_term: '34.5843', even_term_index: 12, odd_term: '49.8129', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '51.1729', phase_index: 0, even_term: '5.0315', even_term_index: 14, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '20.7035', phase_index: 0, even_term: '35.4688', even_term_index: 16, odd_term: '20.2501', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '50.2340', phase_index: 0, even_term: '5.9060', even_term_index: 18, odd_term: '50.6874', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '19.7646', phase_index: 0, even_term: '36.3432', even_term_index: 20, odd_term: '21.1246', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '49.2952', phase_index: 0, even_term: '6.7804', even_term_index: 22, odd_term: '51.5618', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '18.8258', phase_index: 0, even_term: '37.2177', even_term_index: 0, odd_term: '21.9990', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '48.3564', phase_index: 0, even_term: '7.6549', even_term_index: 2, odd_term: '52.4363', odd_term_index: 1 }
  # ],
  # 488 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '17.8870', phase_index: 0, even_term: '38.0921', even_term_index: 4, odd_term: '22.8735', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '47.4176', phase_index: 0, even_term: '8.5293', even_term_index: 6, odd_term: '53.3107', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '16.9481', phase_index: 0, even_term: '38.9666', even_term_index: 8, odd_term: '23.7479', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '46.4787', phase_index: 0, even_term: '9.4038', even_term_index: 10, odd_term: '54.1852', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '16.0093', phase_index: 0, even_term: '39.8410', even_term_index: 12, odd_term: '24.6224', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '45.5399', phase_index: 0, even_term: '10.2782', even_term_index: 14, odd_term: '55.0596', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '15.0705', phase_index: 0, even_term: '40.7155', even_term_index: 16, odd_term: '25.4968', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '44.6011', phase_index: 0, even_term: '11.1527', even_term_index: 18, odd_term: '55.9341', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '14.1316', phase_index: 0, even_term: '41.5899', even_term_index: 20, odd_term: '26.3713', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '43.6622', phase_index: 0, even_term: '12.0271', even_term_index: 22, odd_term: '56.8085', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: true, remainder: '13.1929', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '27.2458', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '42.7234', phase_index: 0, even_term: '42.4644', even_term_index: 0, odd_term: '57.6830', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '12.2540', phase_index: 0, even_term: '12.9016', even_term_index: 2, odd_term: '28.1202', odd_term_index: 3 }
  # ],
  # 489 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '41.7846', phase_index: 0, even_term: '43.3388', even_term_index: 4, odd_term: '58.5574', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '11.3152', phase_index: 0, even_term: '13.7760', even_term_index: 6, odd_term: '28.9947', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '40.8457', phase_index: 0, even_term: '59.4319', even_term_index: 8, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '10.3763', phase_index: 0, even_term: '14.6505', even_term_index: 10, odd_term: '29.8691', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '39.9069', phase_index: 0, even_term: '45.0877', even_term_index: 12, odd_term: '0.3063', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '9.4375', phase_index: 0, even_term: '15.5249', even_term_index: 14, odd_term: '30.7436', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '38.9681', phase_index: 0, even_term: '45.9622', even_term_index: 16, odd_term: '1.1808', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '8.4987', phase_index: 0, even_term: '16.3994', even_term_index: 18, odd_term: '31.6180', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '38.0293', phase_index: 0, even_term: '46.8366', even_term_index: 20, odd_term: '2.0552', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '7.5598', phase_index: 0, even_term: '17.2738', even_term_index: 22, odd_term: '32.4925', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '37.0904', phase_index: 0, even_term: '47.7111', even_term_index: 0, odd_term: '2.9297', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '6.6210', phase_index: 0, even_term: '18.1483', even_term_index: 2, odd_term: '33.3669', odd_term_index: 3 }
  # ],
  # 490 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '36.1516', phase_index: 0, even_term: '48.5855', even_term_index: 4, odd_term: '3.8041', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '5.6822', phase_index: 0, even_term: '19.0228', even_term_index: 6, odd_term: '34.2414', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '35.2128', phase_index: 0, even_term: '49.4600', even_term_index: 8, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '4.7434', phase_index: 0, even_term: '19.8972', even_term_index: 10, odd_term: '4.6786', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '34.2739', phase_index: 0, even_term: '50.3344', even_term_index: 12, odd_term: '35.1158', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '3.8045', phase_index: 0, even_term: '20.7717', even_term_index: 14, odd_term: '5.5530', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '33.3351', phase_index: 0, even_term: '51.2089', even_term_index: 16, odd_term: '35.9903', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '2.8657', phase_index: 0, even_term: '21.6461', even_term_index: 18, odd_term: '6.4275', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '32.3963', phase_index: 0, even_term: '52.0833', even_term_index: 20, odd_term: '36.8647', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '1.9269', phase_index: 0, even_term: '22.5206', even_term_index: 22, odd_term: '7.3019', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '31.4574', phase_index: 0, even_term: '52.9578', even_term_index: 0, odd_term: '37.7392', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '0.9880', phase_index: 0, even_term: '23.3950', even_term_index: 2, odd_term: '8.1764', odd_term_index: 1 }
  # ],
  # 491 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '30.5186', phase_index: 0, even_term: '53.8322', even_term_index: 4, odd_term: '38.6136', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '0.0492', phase_index: 0, even_term: '24.2695', even_term_index: 6, odd_term: '9.0508', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '29.5298', phase_index: 0, even_term: '54.7067', even_term_index: 8, odd_term: '39.4881', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '59.1104', phase_index: 0, even_term: '25.1439', even_term_index: 10, odd_term: '9.9253', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '28.6410', phase_index: 0, even_term: '55.5811', even_term_index: 12, odd_term: '40.3625', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '58.1715', phase_index: 0, even_term: '26.0184', even_term_index: 14, odd_term: '10.7998', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '27.7021', phase_index: 0, even_term: '56.4556', even_term_index: 16, odd_term: '41.2370', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: true, remainder: '57.2327', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '11.6742', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '26.7633', phase_index: 0, even_term: '26.8928', even_term_index: 18, odd_term: '42.1114', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '56.2939', phase_index: 0, even_term: '57.3300', even_term_index: 20, odd_term: '12.5487', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '25.8245', phase_index: 0, even_term: '27.7673', even_term_index: 22, odd_term: '42.9859', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '55.3551', phase_index: 0, even_term: '58.2045', even_term_index: 0, odd_term: '13.4231', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '24.8856', phase_index: 0, even_term: '28.6417', even_term_index: 2, odd_term: '43.8603', odd_term_index: 3 }
  # ],
  # 492 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '54.4162', phase_index: 0, even_term: '59.0788', even_term_index: 4, odd_term: '14.2976', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '23.9468', phase_index: 0, even_term: '29.5162', even_term_index: 6, odd_term: '44.7348', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '53.4774', phase_index: 0, even_term: '59.9534', even_term_index: 8, odd_term: '15.1720', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '23.0080', phase_index: 0, even_term: '30.3806', even_term_index: 10, odd_term: '45.6092', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '52.5386', phase_index: 0, even_term: '0.8279', even_term_index: 12, odd_term: '16.0465', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '22.0691', phase_index: 0, even_term: '31.2651', even_term_index: 14, odd_term: '46.4837', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '51.5997', phase_index: 0, even_term: '1.7023', even_term_index: 16, odd_term: '16.9209', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '21.1303', phase_index: 0, even_term: '32.1395', even_term_index: 18, odd_term: '47.3591', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '50.6609', phase_index: 0, even_term: '2.5768', even_term_index: 20, odd_term: '17.7954', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '20.1915', phase_index: 0, even_term: '33.0140', even_term_index: 22, odd_term: '48.2326', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '49.7221', phase_index: 0, even_term: '3.4512', even_term_index: 0, odd_term: '18.6698', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '19.2527', phase_index: 0, even_term: '33.8884', even_term_index: 2, odd_term: '', odd_term_index: -1 }
  # ],
  # 493 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '48.7832', phase_index: 0, even_term: '4.3257', even_term_index: 4, odd_term: '49.1070', odd_term_index: 3 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '18.3138', phase_index: 0, even_term: '34.7629', even_term_index: 6, odd_term: '19.5443', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '47.8444', phase_index: 0, even_term: '5.2001', even_term_index: 8, odd_term: '49.9815', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '17.3750', phase_index: 0, even_term: '35.6373', even_term_index: 10, odd_term: '20.4187', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '46.9056', phase_index: 0, even_term: '6.0746', even_term_index: 12, odd_term: '50.8559', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '16.4362', phase_index: 0, even_term: '36.5118', even_term_index: 14, odd_term: '21.2932', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '45.9668', phase_index: 0, even_term: '6.9490', even_term_index: 16, odd_term: '51.7304', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '15.4973', phase_index: 0, even_term: '37.3862', even_term_index: 18, odd_term: '22.1676', odd_term_index: 17 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '45.0279', phase_index: 0, even_term: '7.8235', even_term_index: 20, odd_term: '52.6049', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '14.5585', phase_index: 0, even_term: '38.2607', even_term_index: 22, odd_term: '23.0421', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '44.0891', phase_index: 0, even_term: '8.6979', even_term_index: 0, odd_term: '53.4793', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '13.6197', phase_index: 0, even_term: '39.1351', even_term_index: 2, odd_term: '23.9165', odd_term_index: 1 }
  # ],
  # 494 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '43.1503', phase_index: 0, even_term: '9.5724', even_term_index: 4, odd_term: '54.3538', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '12.6809', phase_index: 0, even_term: '40.0096', even_term_index: 6, odd_term: '24.7910', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '42.2114', phase_index: 0, even_term: '10.4468', even_term_index: 8, odd_term: '55.2282', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '11.7420', phase_index: 0, even_term: '40.8840', even_term_index: 10, odd_term: '25.6654', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: true, remainder: '41.2726', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '56.1027', odd_term_index: 11 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '10.8032', phase_index: 0, even_term: '11.3213', even_term_index: 12, odd_term: '26.5399', odd_term_index: 13 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '40.3338', phase_index: 0, even_term: '41.7585', even_term_index: 14, odd_term: '56.9771', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '9.8644', phase_index: 0, even_term: '12.1957', even_term_index: 16, odd_term: '27.4143', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '39.3949', phase_index: 0, even_term: '42.6329', even_term_index: 18, odd_term: '57.8516', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '8.9255', phase_index: 0, even_term: '13.0702', even_term_index: 20, odd_term: '28.2888', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '38.4561', phase_index: 0, even_term: '43.5074', even_term_index: 22, odd_term: '58.7260', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '7.9867', phase_index: 0, even_term: '13.9446', even_term_index: 0, odd_term: '29.1632', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '37.5173', phase_index: 0, even_term: '44.3819', even_term_index: 2, odd_term: '59.6005', odd_term_index: 3 }
  # ],
  # 495 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '7.0479', phase_index: 0, even_term: '14.8191', even_term_index: 4, odd_term: '30.0377', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '36.5785', phase_index: 0, even_term: '45.2563', even_term_index: 6, odd_term: '0.4749', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '6.1090', phase_index: 0, even_term: '15.6935', even_term_index: 8, odd_term: '30.9121', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '35.6396', phase_index: 0, even_term: '46.1308', even_term_index: 10, odd_term: '1.3494', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '5.1702', phase_index: 0, even_term: '16.5690', even_term_index: 12, odd_term: '31.7866', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '34.7008', phase_index: 0, even_term: '47.0052', even_term_index: 14, odd_term: '2.2238', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '4.2314', phase_index: 0, even_term: '17.4424', even_term_index: 16, odd_term: '32.6610', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '33.7620', phase_index: 0, even_term: '47.8797', even_term_index: 18, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '3.2926', phase_index: 0, even_term: '18.3169', even_term_index: 20, odd_term: '3.0983', odd_term_index: 19 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '32.8231', phase_index: 0, even_term: '48.7541', even_term_index: 22, odd_term: '33.5355', odd_term_index: 21 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '2.3537', phase_index: 0, even_term: '19.1913', even_term_index: 0, odd_term: '3.9727', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '31.8843', phase_index: 0, even_term: '49.6286', even_term_index: 2, odd_term: '34.4100', odd_term_index: 1 }
  # ],
  # 496 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '1.4149', phase_index: 0, even_term: '20.0658', even_term_index: 4, odd_term: '4.8472', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '30.9455', phase_index: 0, even_term: '50.5030', even_term_index: 6, odd_term: '35.2844', odd_term_index: 5 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '0.4761', phase_index: 0, even_term: '20.9402', even_term_index: 8, odd_term: '5.7216', odd_term_index: 7 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '30.0066', phase_index: 0, even_term: '51.3775', even_term_index: 10, odd_term: '36.1589', odd_term_index: 9 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '59.5372', phase_index: 0, even_term: '21.8147', even_term_index: 12, odd_term: '6.5961', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '29.0678', phase_index: 0, even_term: '52.2519', even_term_index: 14, odd_term: '37.0333', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '58.5984', phase_index: 0, even_term: '22.6891', even_term_index: 16, odd_term: '7.4705', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '28.1290', phase_index: 0, even_term: '53.1264', even_term_index: 18, odd_term: '37.9078', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '57.6596', phase_index: 0, even_term: '23.5636', even_term_index: 20, odd_term: '8.3450', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '27.1902', phase_index: 0, even_term: '54.0008', even_term_index: 22, odd_term: '38.7822', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '56.7207', phase_index: 0, even_term: '24.4380', even_term_index: 0, odd_term: '9.2194', odd_term_index: 23 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '26.2513', phase_index: 0, even_term: '54.8753', even_term_index: 2, odd_term: '39.6567', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: true, remainder: '55.7819', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '10.0939', odd_term_index: 3 }
  # ],
  # 497 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '25.3125', phase_index: 0, even_term: '25.3125', even_term_index: 4, odd_term: '40.5311', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '54.8431', phase_index: 0, even_term: '55.7497', even_term_index: 6, odd_term: '10.9683', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '24.3737', phase_index: 0, even_term: '26.1870', even_term_index: 8, odd_term: '41.4056', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '53.9043', phase_index: 0, even_term: '56.6242', even_term_index: 10, odd_term: '11.8428', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '23.4348', phase_index: 0, even_term: '27.0614', even_term_index: 12, odd_term: '42.2800', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '52.9654', phase_index: 0, even_term: '57.4986', even_term_index: 14, odd_term: '12.7172', odd_term_index: 15 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '22.4960', phase_index: 0, even_term: '27.9359', even_term_index: 16, odd_term: '43.1545', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '52.0266', phase_index: 0, even_term: '58.3731', even_term_index: 18, odd_term: '13.5917', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '21.5572', phase_index: 0, even_term: '28.8103', even_term_index: 20, odd_term: '44.0289', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '51.0878', phase_index: 0, even_term: '59.2475', even_term_index: 22, odd_term: '14.4661', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '20.6184', phase_index: 0, even_term: '29.6848', even_term_index: 0, odd_term: '44.9034', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '50.1489', phase_index: 0, even_term: '0.1220', even_term_index: 2, odd_term: '15.3406', odd_term_index: 3 }
  # ],
  # 498 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '19.6795', phase_index: 0, even_term: '30.5592', even_term_index: 4, odd_term: '45.7778', odd_term_index: 5 },
  #   { is_many_days: false, month: 2, leaped: false, remainder: '49.2101', phase_index: 0, even_term: '0.9964', even_term_index: 6, odd_term: '16.2150', odd_term_index: 7 },
  #   { is_many_days: true, month: 3, leaped: false, remainder: '18.7407', phase_index: 0, even_term: '31.4337', even_term_index: 8, odd_term: '46.6523', odd_term_index: 9 },
  #   { is_many_days: false, month: 4, leaped: false, remainder: '48.2713', phase_index: 0, even_term: '1.8709', even_term_index: 10, odd_term: '', odd_term_index: -1 },
  #   { is_many_days: true, month: 5, leaped: false, remainder: '17.8019', phase_index: 0, even_term: '32.3031', even_term_index: 12, odd_term: '17.0895', odd_term_index: 11 },
  #   { is_many_days: false, month: 6, leaped: false, remainder: '47.3324', phase_index: 0, even_term: '2.7453', even_term_index: 14, odd_term: '47.5267', odd_term_index: 13 },
  #   { is_many_days: true, month: 7, leaped: false, remainder: '16.8630', phase_index: 0, even_term: '33.1826', even_term_index: 16, odd_term: '17.9640', odd_term_index: 15 },
  #   { is_many_days: false, month: 8, leaped: false, remainder: '46.3936', phase_index: 0, even_term: '3.6198', even_term_index: 18, odd_term: '48.4012', odd_term_index: 17 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '15.9242', phase_index: 0, even_term: '34.0570', even_term_index: 20, odd_term: '18.8384', odd_term_index: 19 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '45.4548', phase_index: 0, even_term: '4.4942', even_term_index: 22, odd_term: '49.2756', odd_term_index: 21 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '14.9854', phase_index: 0, even_term: '34.9315', even_term_index: 0, odd_term: '19.7129', odd_term_index: 23 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '44.5160', phase_index: 0, even_term: '5.3687', even_term_index: 2, odd_term: '50.1501', odd_term_index: 1 }
  # ],
  # 499 => [
  #   { is_many_days: false, month: 1, leaped: false, remainder: '14.0465', phase_index: 0, even_term: '35.8059', even_term_index: 4, odd_term: '20.5873', odd_term_index: 3 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '43.5771', phase_index: 0, even_term: '6.2431', even_term_index: 6, odd_term: '51.0245', odd_term_index: 5 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '13.1077', phase_index: 0, even_term: '36.6804', even_term_index: 8, odd_term: '21.4618', odd_term_index: 7 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '42.6383', phase_index: 0, even_term: '7.1176', even_term_index: 10, odd_term: '51.8990', odd_term_index: 9 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '12.1689', phase_index: 0, even_term: '37.5548', even_term_index: 12, odd_term: '22.3362', odd_term_index: 11 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '41.6995', phase_index: 0, even_term: '7.9921', even_term_index: 14, odd_term: '52.7734', odd_term_index: 13 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '11.2301', phase_index: 0, even_term: '38.4293', even_term_index: 16, odd_term: '23.2107', odd_term_index: 15 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '40.7606', phase_index: 0, even_term: '8.8665', even_term_index: 18, odd_term: '53.6479', odd_term_index: 17 },
  #   { is_many_days: false, month: 8, leaped: true, remainder: '10.2912', phase_index: 0, even_term: '', even_term_index: -1, odd_term: '24.0851', odd_term_index: 19 },
  #   { is_many_days: true, month: 9, leaped: false, remainder: '39.8218', phase_index: 0, even_term: '39.3037', even_term_index: 20, odd_term: '54.5223', odd_term_index: 21 },
  #   { is_many_days: false, month: 10, leaped: false, remainder: '9.3524', phase_index: 0, even_term: '9.7410', even_term_index: 22, odd_term: '24.9596', odd_term_index: 23 },
  #   { is_many_days: true, month: 11, leaped: false, remainder: '38.8830', phase_index: 0, even_term: '40.1782', even_term_index: 0, odd_term: '55.3968', odd_term_index: 1 },
  #   { is_many_days: false, month: 12, leaped: false, remainder: '8.4136', phase_index: 0, even_term: '10.6154', even_term_index: 2, odd_term: '25.8340', odd_term_index: 3 }
  # ],
  # 500 => [
  #   { is_many_days: true, month: 1, leaped: false, remainder: '37.9441', phase_index: 0, even_term: '41.0526', even_term_index: 4, odd_term: '56.2712', odd_term_index: 5 },
  #   { is_many_days: true, month: 2, leaped: false, remainder: '7.4747', phase_index: 0, even_term: '11.4899', even_term_index: 6, odd_term: '26.7085', odd_term_index: 7 },
  #   { is_many_days: false, month: 3, leaped: false, remainder: '37.0053', phase_index: 0, even_term: '41.9271', even_term_index: 8, odd_term: '57.1457', odd_term_index: 9 },
  #   { is_many_days: true, month: 4, leaped: false, remainder: '6.5359', phase_index: 0, even_term: '12.3643', even_term_index: 10, odd_term: '27.5829', odd_term_index: 11 },
  #   { is_many_days: false, month: 5, leaped: false, remainder: '36.0665', phase_index: 0, even_term: '42.8015', even_term_index: 12, odd_term: '58.0201', odd_term_index: 13 },
  #   { is_many_days: true, month: 6, leaped: false, remainder: '5.5971', phase_index: 0, even_term: '13.2388', even_term_index: 14, odd_term: '28.4574', odd_term_index: 15 },
  #   { is_many_days: false, month: 7, leaped: false, remainder: '35.1277', phase_index: 0, even_term: '43.6760', even_term_index: 16, odd_term: '58.8946', odd_term_index: 17 },
  #   { is_many_days: true, month: 8, leaped: false, remainder: '4.6582', phase_index: 0, even_term: '14.1132', even_term_index: 18, odd_term: '29.3318', odd_term_index: 19 },
  #   { is_many_days: false, month: 9, leaped: false, remainder: '34.1888', phase_index: 0, even_term: '44.5504', even_term_index: 20, odd_term: '59.7691', odd_term_index: 21 },
  #   { is_many_days: true, month: 10, leaped: false, remainder: '3.7194', phase_index: 0, even_term: '14.9877', even_term_index: 22, odd_term: '30.2063', odd_term_index: 23 },
  #   { is_many_days: false, month: 11, leaped: false, remainder: '33.2500', phase_index: 0, even_term: '45.4249', even_term_index: 0, odd_term: '0.6435', odd_term_index: 1 },
  #   { is_many_days: true, month: 12, leaped: false, remainder: '2.7806', phase_index: 0, even_term: '15.8621', even_term_index: 2, odd_term: '31.0807', odd_term_index: 3 }
  # ]
}.freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Genka' do
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
              GENKA_EXPECTED_MONTHS.each do |year, expects|
                actuals = \
                  Zakuro::Genka::Range::AnnualRange.get(
                    context: Zakuro::Context.new(version_name: 'Genka'),
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
