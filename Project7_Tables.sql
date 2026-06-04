-- Test veritabanının oluşturulması
CREATE DATABASE NetworkAutomationDB;
USE NetworkAutomationDB;

-- Sistem hareketlerini simüle edecek test tablosu
CREATE TABLE SystemLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    LogMessage VARCHAR(255),
    LogDate DATETIME DEFAULT GETDATE()
);

-- Tabloya test verilerinin basılması
INSERT INTO SystemLogs (LogMessage) 
VALUES ('Sistem basariyla baslatildi.'),
('Ag trafigi normalize edildi.');