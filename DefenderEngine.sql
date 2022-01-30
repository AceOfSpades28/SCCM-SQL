select Distinct VRS.Name0,
VRS.operatingSystem0 'OS', 
AV.EngineVersion 'Engine Ver', 
AV.AntivirusSignatureVersion 'AV Signature',
--AV.AntispywareSignatureVersion 'Spyware', 
AV.AntivirusSignatureAge 'AV Sig Age Days_old',
ES.SignatureUpTo1DayOld 'Sig Up to Date',
Convert(smalldatetime,AV.LastFullScanDateTimeEnd) 'Last Scan', 
--Convert (Time, AV.AntivirusSignatureUpdateDateTime) as 'Time',

Convert(smalldatetime,AV.AntivirusSignatureUpdateDateTime) as 'AV Updated on' 

from v_R_System VRS
INNER join v_GS_AntimalwareHealthStatus AV on AV.ResourceID = VRS.ResourceID
INNER JOIN v_FullCollectionMembership FCM on FCM.ResourceID = VRS.ResourceID
INNER JOIN v_EndpointProtectionStatus ES on ES.ResourceID = VRS.ResourceID 

--Where AV.AntivirusSignatureVersion Not like '1.339.692.0' 

Where VRS.operatingSystem0 like '% Server %'
and AV.EngineVersion like '0.0.0.0'

Order by VRS.Name0 ASC