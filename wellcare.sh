cd To_Wellcare
lftp -u ssi,ahiix7 sftp://edi.wellcare.com << --EOF--
cd /Home/SSI/To_WellCare 
mput  * 
quit
--EOF--