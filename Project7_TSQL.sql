DECLARE @BackupFile NVARCHAR(255);
DECLARE @DateStamp NVARCHAR(20);

SET @DateStamp = CONVERT(NVARCHAR, GETDATE(), 112);


SET @BackupFile = 'C:\SQLBackups\NetworkDB_Backup_'
+ @DateStamp + '.bak';


BACKUP DATABASE [NetworkAutomationDB] 
TO DISK = @BackupFile 
WITH NOFORMAT, NOINIT, 
NAME = 'NetworkAutomationDB-Full Automated Backup', 
SKIP, NOREWIND, NOUNLOAD, STATS = 10;