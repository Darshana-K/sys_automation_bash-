#!/bin/bash
#!DarshanaK


year="2017"
month="11"
user="root"
pass="root"
database="openmint"

date_01=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-01 07:00:00' AND '$year-$month-02 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_02=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-02 07:00:00' AND '$year-$month-03 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_03=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-03 07:00:00' AND '$year-$month-04 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_04=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-04 07:00:00' AND '$year-$month-05 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_05=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-05 07:00:00' AND '$year-$month-06 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_06=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-06 07:00:00' AND '$year-$month-07 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_07=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-07 07:00:00' AND '$year-$month-08 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_08=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-08 07:00:00' AND '$year-$month-09 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_09=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-09 07:00:00' AND '$year-$month-10 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_10=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-10 07:00:00' AND '$year-$month-11 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_11=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-11 07:00:00' AND '$year-$month-12 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_12=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-12 07:00:00' AND '$year-$month-13 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_13=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-13 07:00:00' AND '$year-$month-14 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_14=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-14 07:00:00' AND '$year-$month-15 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_15=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-15 07:00:00' AND '$year-$month-16 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_16=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-16 07:00:00' AND '$year-$month-17 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_17=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-17 07:00:00' AND '$year-$month-18 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_18=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-18 07:00:00' AND '$year-$month-19 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_19=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-19 07:00:00' AND '$year-$month-20 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_20=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-20 07:00:00' AND '$year-$month-21 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_21=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-21 07:00:00' AND '$year-$month-22 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_22=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-22 07:00:00' AND '$year-$month-23 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_23=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-23 07:00:00' AND '$year-$month-24 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_24=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-24 07:00:00' AND '$year-$month-25 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_25=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-25 07:00:00' AND '$year-$month-26 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_26=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-26 07:00:00' AND '$year-$month-27 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_27=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-27 07:00:00' AND '$year-$month-28 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_28=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-28 07:00:00' AND '$year-$month-29 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_29=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-29 07:00:00' AND '$year-$month-30 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_30=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-30 07:00:00' AND '$year-$month-31 06:59:59' ;" | mysql -u$user -p$pass $database)
#date_31=$(echo "select sum(bob_peso_KG) from ildp_bobinas where bob_hora_inicio BETWEEN '$year-$month-31 07:00:00' AND '$year-$((month+1)) - 06:59:59' ;" | mysql -u $user -p $pass $database)

echo $year $month 01 : $date_01
echo $year $month 02 : $date_02
echo $year $month 03 : $date_03
echo $year $month 04 : $date_04
echo $year $month 05 : $date_05
echo $year $month 06 : $date_06
echo $year $month 07 : $date_07
echo $year $month 08 : $date_08
echo $year $month 09 : $date_09
echo $year $month 10 : $date_10
echo $year $month 11 : $date_11
echo $year $month 12 : $date_12
echo $year $month 13 : $date_13
echo $year $month 14 : $date_14
echo $year $month 15 : $date_15
echo $year $month 16 : $date_16
echo $year $month 17 : $date_17
echo $year $month 18 : $date_18
echo $year $month 19 : $date_19
echo $year $month 20 : $date_20
echo $year $month 21 : $date_21
echo $year $month 22 : $date_22
echo $year $month 23 : $date_23
echo $year $month 24 : $date_24
echo $year $month 25 : $date_25
echo $year $month 26 : $date_26
echo $year $month 27 : $date_27
echo $year $month 28 : $date_28
echo $year $month 29 : $date_29
echo $year $month 30 : $date_30
echo $year $month 31 : $date_31