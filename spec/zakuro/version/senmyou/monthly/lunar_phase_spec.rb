# frozen_string_literal: true

require File.expand_path('../../../../../' \
  'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/monthly/lunar_phase',
                         __dir__)

NOVEMBER_1ST = {
  1400 => '3-4118',
  1401 => '58-7106',
  1402 => '22-7569',
  1403 => '16-4828',
  1404 => '40-5774',
  1405 => '35-1208',
  1406 => '29-3001',
  1407 => '53-1479',
  1408 => '47-1323',
  1409 => '41-2850',
  1410 => '5-2619',
  1411 => '0-7126',
  1412 => '54-4501', # 閏
  1413 => '18-5125',
  1414 => '13-6',
  1415 => '37-7585',
  1416 => '31-7841',
  1417 => '25-8028',
  1418 => '49-7105',
  1419 => '43-1768',
  1420 => '38-6858',
  1421 => '2-8011',
  1422 => '56-4337',
  1423 => '20-4260',
  1424 => '14-5899',
  1425 => '8-5819',
  1426 => '32-4231',
  1427 => '26-5829',
  1428 => '21-1108',
  1429 => '45-1910',
  1430 => '40-7622',
  1431 => '34-3413',
  1432 => '58-2979',
  1433 => '52-4084',
  1434 => '16-2310',
  1435 => '10-2539',
  1436 => '4-4739',
  1437 => '28-4872',
  1438 => '23-1627',
  1439 => '18-7122',
  1440 => '42-7408',
  1441 => '36-1564',
  1442 => '0-423',
  1443 => '54-271',
  1444 => '48-1041',
  1445 => '12-454',
  1446 => '6-4204',
  1447 => '1-1422',
  1448 => '25-2389',
  1449 => '20-6415',
  1450 => '14-22', # 閏
  1451 => '38-6946',
  1452 => '32-6780',
  1453 => '55-5508',
  1454 => '50-7777',
  1455 => '44-3725',
  1456 => '8-4839',
  1457 => '3-1822',
  1458 => '57-5300',
  1459 => '21-4515',
  1460 => '15-4964',
  1461 => '39-3165',
  1462 => '33-4003',
  1463 => '28-6900',
  1464 => '52-7360',
  1465 => '46-4582',
  1466 => '41-1114',
  1467 => '5-1061',
  1468 => '59-2907',
  1469 => '53-2951',  # 閏
  1470 => '17-1263',
  1471 => '11-2698',
  1472 => '35-2467',
  1473 => '30-6885',
  1474 => '24-4250',
  1475 => '48-4945',
  1476 => '43-8279',
  1477 => '37-1170',
  1478 => '1-7810',
  1479 => '55-7935',
  1480 => '19-7009',
  1481 => '13-1581',
  1482 => '8-6587',
  1483 => '32-7784',
  1484 => '26-4159',
  1485 => '21-6934',
  1486 => '44-5835',
  1487 => '38-5760',
  1488 => '33-6398',
  1489 => '56-5698',
  1490 => '51-887',
  1491 => '15-1688',
  1492 => '10-7393',
  1493 => '4-3236',
  1494 => '28-2872',
  1495 => '22-4026',
  1496 => '16-3853',
  1497 => '40-2452',
  1498 => '34-4573',
  1499 => '58-4706',
  1500 => '53-1375',
  1501 => '48-6892',
  1502 => '12-7249',
  1503 => '6-1459',
  1504 => '0-2102',
  1505 => '24-230',
  1506 => '18-915',
  1507 => '12-3658',
  1508 => '36-4002',
  1509 => '31-1154',
  1510 => '55-2177',
  1511 => '49-6258',
  1512 => '44-8316',
  1513 => '8-6907',
  1514 => '2-6709',
  1515 => '56-7983',
  1516 => '20-7614',
  1517 => '14-3491',
  1518 => '38-4608',
  1519 => '33-1612',
  1520 => '27-5144',
  1521 => '51-4429',
  1522 => '45-4922',
  1523 => '39-4961',
  1524 => '3-3896',
  1525 => '58-6702',
  1526 => '52-3164',
  1527 => '16-4344',
  1528 => '11-910',
  1529 => '35-924',
  1530 => '29-2821',
  1531 => '23-2892',
  1532 => '47-1211',
  1533 => '41-2557',
  1534 => '35-5983',
  1535 => '0-6653',
  1536 => '54-4011',
  1537 => '18-4773',
  1538 => '13-8142',
  1539 => '7-1084',
  1540 => '31-7787',
  1541 => '25-7851',
  1542 => '19-1407',
  1543 => '43-1402',
  1544 => '38-6325',
  1545 => '32-3576',
  1546 => '56-3989',
  1547 => '51-6810',
  1548 => '14-5768',
  1549 => '8-5719',
  1550 => '2-6279',
  1551 => '26-5575',
  1552 => '21-674',
  1553 => '15-6124',
  1554 => '40-7172',
  1555 => '34-3069',
  1556 => '58-2774',  # 閏
  1557 => '52-3966',
  1558 => '46-3772',
  1559 => '10-2386',
  1560 => '4-4416',
  1561 => '59-139',
  1562 => '23-1132',
  1563 => '18-6671',
  1564 => '12-2024',
  1565 => '36-1361',
  1566 => '30-2049',
  1567 => '54-198',
  1568 => '48-806',
  1569 => '42-3467',
  1570 => '6-3809',
  1571 => '1-894',
  1572 => '55-6039',
  1573 => '19-6110',
  1574 => '14-8221',
  1575 => '38-6877',
  1576 => '32-6648',
  1577 => '26-7831',
  1578 => '50-7472',
  1579 => '44-3263',
  1580 => '39-622',
  1581 => '3-1410',
  1582 => '57-4997',
  1583 => '52-6551',
  1584 => '15-4888',
  1585 => '9-4865',
  1586 => '33-3798',
  1587 => '28-6513',
  1588 => '22-2905',
  1589 => '46-4108',
  1590 => '41-710',
  1591 => '35-3735',
  1592 => '59-2743',
  1593 => '53-2843',
  1594 => '17-1168',
  1595 => '11-2425',
  1596 => '5-5760',
  1597 => '30-6435',
  1598 => '24-3778',
  1599 => '19-8273',
  1600 => '43-8015',
  1601 => '37-1008',
  1602 => '31-885',
  1603 => '55-7774',
  1604 => '49-1238',
  1605 => '13-1232',
  1606 => '7-6071',
  1607 => '2-3344',
  1608 => '26-3825',
  1609 => '21-6684',
  1610 => '15-7554',
  1611 => '38-5688',
  1612 => '32-6170',
  1613 => '56-5462',
  1614 => '51-471',
  1615 => '45-5854',
  1616 => '10-6958',
  1617 => '4-2908',
  1618 => '58-5224',
  1619 => '22-3910',
  1620 => '16-3714',
  1621 => '10-4761',
  1622 => '34-4269',
  1623 => '29-8300',
  1624 => '53-897',
  1625 => '48-6459',
  1626 => '42-1865',
  1627 => '6-1272',
  1628 => '0-1992',
  1629 => '54-1898',
  1630 => '18-716',
  1631 => '12-3285',
  1632 => '36-3626',
  1633 => '31-643',
  1634 => '25-5830',
  1635 => '49-5969',
  1636 => '44-8132',
  1637 => '38-8380',
  1638 => '2-6594',
  1639 => '56-7700',
  1640 => '50-2493',  # 閏
  1641 => '14-3046',
  1642 => '9-365',
  1643 => '33-1217',
  1644 => '27-4859',
  1645 => '22-6464',
  1646 => '45-4864',
  1647 => '39-4777',
  1648 => '34-6486',
  1649 => '58-6351',
  1650 => '52-2655',
  1651 => '16-3877',
  1652 => '11-519',
  1653 => '5-3599',
  1654 => '29-2675',
  1655 => '23-2801',
  1656 => '17-3148',
  1657 => '41-2300',
  1658 => '35-5550',
  1659 => '30-2428',
  1660 => '54-3544'
}

describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Monthly' do
      describe 'LunarPhase' do
        describe '.next_phase' do
          context 'november 1st every year' do
            it 'should be expected values' do
              NOVEMBER_1ST.each do |year, value|
                # 11月定朔
                lunar_phase = Zakuro::Senmyou::Monthly::LunarPhase.new(
                  western_year: year
                )
                actual = lunar_phase.next_phase

                expect(actual.format).to eq value
              end
            end
          end
        end
      end
    end
  end
end