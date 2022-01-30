select PackageName as 'Package / Task Sequence',
ai.AdvertisementID as 'DeploymentID',
ai.CollectionName, 
Name0 as 'Computer Name',
User_Name0 as 'User Name', 
LastAcceptanceMessageIDName, 
LastAcceptanceStateName, 
LastAcceptanceStatusTime, 
LastStatusMessageIDName, 
LastStateName, 
LastState,
LastStatusTime
from v_ClientAdvertisementStatus cas
inner join v_R_System sys on sys.ResourceID=cas.ResourceID
inner join v_AdvertisementInfo ai on ai.AdvertisementID=cas.AdvertisementID
where PackageName = 'Windows 10 Feature Upgrade 21H1 Available' 
and ai.CollectionName like 'Windows 10 - v2004 (Users) MM-split2'
and LastStatusTime is not null 
ORDER BY LastStatusTime Desc