Select Distinct R.ResourceID 'ResourceID', 
U.extensionAttribute20 'Region',
U.extensionAttribute40 'Location', 
R.Name0 'Computer Name',
CS.Manufacturer0 'Manufacturer',
CS.Model0 'Model', 
Round(Cast(M.TotalPhysicalMemory0 as float )/1024/1024 , 0) 'RAM',
P.Name0 'Processor',
U.displayName0 'User Name',
U.Windows_NT_Domain0 'User Domain',
streetAddress0 'Street Address', 
U.L0 'City', 
st0 'State', 
postalCode0 'Zip', 
U.telephoneNumber0 'Phone', 
Mail0 'Email', 
S.operatingSystem0 'Operating System',
s.operatingSystemVersion0 'OS Version',
case OS.BuildNumber0
when '19044' then 'Windows 10 21H2'
when '19043' then 'Windows 10 21H1'
when '19042' then 'Windows 10 20H2'
when '19041' then 'Windows 10 2004'
when '18363' then 'Windows 10 1909'
when '18362' then 'Windows 10 1903'
when '17763' then 'Windows 10 1809'
when '17134' then 'Windows 10 1803'
when '16299' then 'Windows 10 1709'
when '15063' then 'Windows 10 1703'
when '14393' then 'Windows 10 1607'
when '10586' then 'Windows 10 1511'
when '10240' then 'Windows 10 1507'
end as 'Win10 Build'

From 
v_R_System S
inner join v_R_SYSTEM R on S.ResourceID=R.ResourceID
inner join v_UserMachineRelation UM on R.ResourceID=UM.MachineResourceID
inner join v_GS_OPERATING_SYSTEM OS on OS.ResourceID = R.ResourceID
inner join v_GS_COMPUTER_SYSTEM CS on R.ResourceID=CS.ResourceID
inner join v_GS_PROCESSOR P on R.ResourceID=P.ResourceID
inner join v_GS_X86_PC_MEMORY M on R.ResourceID=M.ResourceID
Left join [v_R_User] U on R.User_Name0= U.User_Name0

where (S.operatingSystem0 like 'Windows 10%' or S.operatingSystem0 like 'Windows 8%' or S.operatingSystem0 like 'Windows 7%')
and (R.Full_Domain_Name0 like '%buildersfirstsource%' or R.Full_Domain_Name0 like '%probuild%')

order by R.Name0